---
title: "Reverse engineering an Electronicx battery protocol"
date: 2022-01-15
description: "I explain how I reverse engineered the BLE protocol of a Electronicx battery and what the results are"
series: []
tags: ["reverse engineering"]
---

I recently bought a [100Ah LiFePO4 battery from electronicx](https://electronicx.de/Electronicx-Caravan-Edition-LiFePO4-Akku-12V-100Ah-LFP-Bluetooth-APP-Lithium-Eisenphosphat). The battery has a built-in BLE (Bluetooth low energy) module so that one can install the app of the vendor to get some information like the voltage or the current load as well as some other information.

I was thinking of creating some kind of monitoring system based on an Arduino or Raspberry. For that, I first wanted to have a look at how the data is transmitted to the app so that I could reimplement this.

## Approach 1: BLE Characteristics

My first thought was: BLE devices expose characteristics that usually are used to expose individual values - just like what is needed by such a battery. So I installed a few BLE inspectors and tried to connect to the battery. I was able to connect to the battery, however, the battery closed the connection after a few seconds automatically again. During the connection time, I was able to see that the battery only really has two characteristics - which is not enough to expose all of the different values the battery exposes in the app. This was a setback at first. But soon after, I had a new idea.

## Approach 2: Packet Logger

As I use a MacBook with an M1 chip, I was able to install the vendor's iOS app on my Mac. And after some back and forth, I finally convinced the app to connect to the battery. This opened up a new approach. I started the Packet Logger app from apple, which displays all outgoing and incoming Bluetooth messages of a Mac. Now I was able to see the communication of the app and the battery. I found that the battery uses the BLE characteristics in an interesting way. The app periodically writes to one of the characteristics. Just milliseconds after, the battery writes 9 values to the *other* characteristic. So they are using the two characteristics as a two-way communication buffer. After observing this a few times, I noticed that the value set by the app is always the same:

`[0x3A, 0x30, 0x30, 0x30, 0x32, 0x35, 0x30, 0x30, 0x30, 0x30, 0x45, 0x30, 0x33, 0x7E]`

Joining all of the values written by the battery looked something like this:

`[0x3A, 0x30 0x30 0x38 0x32 0x33 0x31 0x30 0x30 0x38 0x43 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x43 0x35 0x32 0x30 0x43 0x33 0x33 0x30 0x43 0x34 0x46 0x30 0x43 0x34 0x46 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x31 0x42 0x34 0x34 0x32 0x43 0x32 0x38 0x32 0x38 0x32 0x38 0x46 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x32 0x32 0x30 0x30 0x30 0x30 0x35 0x35 0x30 0x33 0x33 0x45 0x30 0x33 0x44 0x45 0x30 0x33 0x45 0x38 0x46 0x30, 0x7E]`

Looking at these, I was able to identify some interesting facts about these messages:
 - All messages, sent by the app and the battery, start with `0x3A` and end with `0x7E`. So they probably are using these as a start and end byte.
 - Except for the start and end bit, all other bytes encode ASCII characters in the range `0-9,A-F`, which -- interestingly -- are used for hexadecimal numbers. This also supports the theory of the start and end bytes.
- There are long sections of repeating `0x30`, which stand for a `0` in ASCII. This also makes sense because the app displays the individual voltages of 16 cells. However, my version of the battery (100Ah) only has 4 cells. All the other cells are displayed with `0V` in the app. If the protocol is generic for all models, one would expect many zeros.

I the following, when I talk about a byte, I mean droping the start and the stop byte, and decode the rest in pairs of two as hexadecimal numbers. So the message `[0x3A, 0x30, 0x30, 0x30, 0x32 0x7E]` would be decoded as follows:

  - Dropping start and end byte: `[0x30, 0x30, 0x30, 0x32]`.
  - Decode as ASCII-Characters: `0002`
  - read pairs of two: `['00', '02'] = [0x00, 0x02] = [0, 2]`

  So the message `[0x3A, 0x30, 0x30, 0x30, 0x32 0x7E]` effectively contains the two bytes `[0, 2]`

## Identifying the different parts of the response

To get many readings from the battery and store them for analysis, I wrote a small program that connects to the battery, requests data by sending this magic value the vendors app send to the battery. Et voilà, I was able to read a response. I updated the program to request new data every second. With that, I was able to get a few responses.

Now I of course wanted to know where and how to get the values from this byte buffer. I started by disconnecting all attached devices to get a load of 0 and have more or less stable values for the voltage.

After recording some samples, I found the following:
  - Most of the bytes are always the same
  - I get some small variations in the bytes 12 - 20
  - The last byte is interesting:
    - The value changes drastically
    - If the rest of the bytes are identical between two readings, the last byte is identical, too
    - So the last byte is probably some kind of checksum

I first looked at the small variations. As my battery has 4 cells which voltage fluctuates a bit (the app displays four significant digits), 8 bytes with small variations came in handy. With that connection, it was easy to calculate the voltage from the bytes: Just read two bytes as an Int and divide the value by 1000. With that I got the voltage numbers. After adding some load to the battery, I also was able to identify the bytes for the current.

Next up, I inspected the checksum. After some trial and error, I found a common algorithm that matched the checksum: the hex two-complement checksum.

With that, I found all the information I was interested in.

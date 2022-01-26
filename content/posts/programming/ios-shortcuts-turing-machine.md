---
title: "Is the iOS Shortcuts app Turing-complete?"
date: 2021-03-14
description: "This article explores if it is possible to create a turing machine in the iOS Shortcuts app"
series: []
tags: ["Turing", "Shortcuts", "iOS"]
---

The short answer: **Yes**.

## The Long Answer

In this post, we will explore how to create a Turing machine in the [iOS Shortcut app](https://support.apple.com/guide/shortcuts/welcome/ios). The Shortcuts app is intended to define more or less complex workflows to simplify repetitive day-to-day tasks. The usual applications range from simple water loggers to more complete morning routines which inform the user about the weather and the upcoming appointments.

But we have a slightly different goal. We have the grand goal to create the gods of all programs. A program that can run a program to solve any solvable task: A Turing machine. By doing this, we can prove that the shortcuts app itself is Turing complete and can solve and solvable task.

### What is a Turing Machine

First, let's look into what a Turing machine is. A Turing machine has an infinitely long tape. The machine can read from and write on that tape with a head that can move left and right on that tape. Additionally, the machine always has an internal *state*. The state is always one from a finite list of predefined possible states.

The last part is a finite table of instructions. The exact structure and interpretation of this table differ from definition to definition.

The table defines how the machine will behave for each combination of the internal state and the tape value as read by the head at its current position. The behavior is defined by the new value written on the tape, the movement of the head after writing the value (1 for right, -1 for left, and 0 for stop), and the new internal state. The machine will continue to run the instructions until it is stopped by a 0 in movement.

To program a machine that will continuously print 01010101010... onto the tape, the following table can be used.

| state | tape value | new tape value | movement | new state |
|-------|------------|----------------|----------|-----------|
| b     |            | 0              | 1        | c         |
| c     |            | 1              | 1        | b         |


### A Turing Machine in the Shortcuts App

Let's figure out what we need to build a Turing Machine and how to build this in the Shortcuts app. First, we need an *infinite* tape. The issue with infinity obviously is, that you would need an infinite amount of memory/disk space on your iPhone or iPad -- which you probably don't have. So what we really want here is to have a data structure that can grow without software limitations. For a tape, the obvious choice would be a list but as far as I know, lists cannot be modified in the Shortcuts app. So we will use a Dictionary instead. The Shortcuts app provides three useful actions for that: create a dictionary with values, get a value for a key, and set the value for a key -- that's all we need. The key will just be the position on the tape.

The second issue is the infinite loop of executing instructions. The shortcuts app has a `repeat` action but for that one has to know in advance, how often the loop has to be executed. This would not make our machine Turing-complete. Also, there are not `goto` instructions. However, there is an action to run another shortcut which can also be used to start the same shortcut itself which effectively will wrap the whole shortcut in an infinite loop. And that's exactly what we want. The issue with that is, we can only pass one value to the new shortcut. As we learned before, we have to keep track of multiple mutating states and the whole instruction table. A solution for that is to wrap the whole state of the machine and everything we need in another dictionary. The shortcut will then get this dictionary as an input, modify it and then start itself with the modified dictionary.

With all of this, we have a complete Turing machine.

## Download

To try it out yourself, you can download my implementation of the Turing machine [here](https://www.icloud.com/shortcuts/bb9609cb37cd4d0ab795c0d1691866f6).

This is just the machine and starting the shortcut like this will fail. The shortcut must be started with the initial state of a Turing machine including the instruction table. Luckily, I also have a shortcut that builds such an initial machine, which you can get [here](https://www.icloud.com/shortcuts/eea9abe2121f4be7b125bbd0b865545c).

The example Turing machine is an implementation of the example given above: it will continuously print 01010101010... After each step, the Turing machine shortcut prints out the whole state of the machine. After executing the first step, the machine's state will contain `"tape":{"0":0}` which means that on the tape on position 0 the value is 0. After the second step, the state will contain `"tape":{"0":0,"1":1}`, after the third step `"tape":{"0":0,"1":1,"2":0}` etc. Keep in mind that a dictionary does not have an order so that the values might not be in the same order.

As this example program will never stop, you will have to manually kill it. The easiest one is to tap again on the shortcut (when you are in the shortcut overview) or to press the stop button (when you are in the shortcut detail view) after you dismissed one of the intermediate outputs. But you have to be quick because the machine will present you the next output just a few moments later.

## Create your own program

Now, you can create your own programs by modifying the example one. The first dictionary contains the initial state of the tape. Use numbers for the key and numbers for the values.

The second dictionary contains the instruction table. Use `<internal state>|<tape value>` for the key here. To match a position of the tape which is empty, just leave out the tape value but make sure that you still have the vertical bar. The value of the instruction table must be a dictionary itself, which must have the following value:

| key   | value                            |
|-------|----------------------------------|
| print | number: the value to print       |
| move  | number: steps to move, 0 to stop |
| state | text: the new state              |

The third dictionary contains the following keys:

| key      | value                                                |
|----------|------------------------------------------------------|
| position | number: the initial position of the head on the tape |
| state    | text: the initial state                              |

With all of that, you should be able to solve any solvable task.

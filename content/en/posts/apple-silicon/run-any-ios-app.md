---
title: "iOS Apps on Apple Silicon"
date: 2020-11-26
description: "Run any iOS app on Apple Silicon Macs"
series: ["Apple Silicon"]
tags: ["Apple Silicon"]
---

The new Macs with an Apple Silicon chip can run most of the iOS apps which already exist run.
However, some developers have disabled this for their apps.
This might be useful for technical reasons if the app is not compatible, but most disabled iOS apps run flawlessly on macOS.

Using the steps below, these apps can still be installed on iOS.

## Installation steps

1. Install `fswatch`. This can be done using `brew install fswatch` when the package manager [brew]({{< ref "/homebrew-setup.md" >}}) is installed.
1. Execute the [script]({{< ref "#script" >}}) from the bottom of the page.
1. Install [Apple Configurator 2](https://apps.apple.com/de/app/apple-configurator-2/id1037126344) and sign in.
1. Connect an iOS device to your Mac.
1. In Apple Configurator 2, add the app you want to install using `Actions > Add > Apps ...`.
1. Wait until Apple Configurator 2 downloaded the app.
    1. If you already have the app installed on your iOS device, you will get a prompt asking you what you want to do. Select `Stop`.
    1. If you don't have the app installed, the app will be installed on your iOS device. You can delete it afterward.
1. The script creates a macOS copy of the app installer in your downloads folder. Simply double click the `.ipa` file to install the app.
1. Now, you can download another app using the same steps or stop the script.

## Script

```install-ios-apps.sh
#!/bin/bash
WATCH_FOLDER=~/Library/Group\ Containers/K36BKF7T3D.group.com.apple.configurator/Library/Caches/Assets
export EXPORT_FOLDER=~/Downloads

function handleIPA() {
    if [[ "$1" == *.ipa ]]; then
        if [ -f "$1" ]; then
            IPA_NAME=`basename "$1"`
            EXPORT_PATH="$EXPORT_FOLDER/$IPA_NAME"
            cp "$1" "$EXPORT_PATH"
            xattr -cr "$EXPORT_PATH"
            echo "Downloaded $EXPORT_PATH"
        fi
    fi
}

export -f handleIPA

echo "Please download the app using Apple Configurator"
fswatch -0 "$WATCH_FOLDER" | xargs -0 -n 1 -I % bash -c 'handleIPA "%"'
```

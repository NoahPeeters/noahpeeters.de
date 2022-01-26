---
title: "Setup Homebrew on Apple Silicon"
date: 2020-11-28
description: "Install a native ARM and an Intel version of homebrew on an Apple Silicon Mac"
series: ["Apple Silicon"]
tags: ["Apple Silicon"]
---


[Homebrew](https://brew.sh) is a popular package manager on macOS to install a variety of command line tools and desktop apps. This means, setting up homebrew correctly is crucial, as it has to make sure that both native ARM and emulated Intel tools are properly installed.

First of all, homebrew itself runs without any issues so far but will print a warning during usage. However, not all tools homebrew installs are compatible with the new architecture. To further complicate matters, homebrew does not allow mixing ARM and Intel tools.

## Installation

The goal is to have a setup which allows to install all compatible tools natively and install the rest as an Intel version which will be executed with Rosetta 2. For that we will have to create two homebrew installataions -- a native one and an Intel one.

### Install an Intel homebrew

Installing an Intel homebrew is straight forward. We can simply use the installation script from the [homepage](https://brew.sh) and add the prefix `arch --x86_64` to run it using Rosetta:

```bash
arch --x86_64 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Install an ARM homebrew

Now, we have to follow the [alternative installation instructions](https://docs.brew.sh/Installation#untar-anywhere). Homebrew recommends installing it to `/opt/homebrew` on macOS ARM, which can be achieved using the following commands: 

```bash
cd ~/Downloads
mkdir homebrew
curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C homebrew
sudo mv homebrew /opt/homebrew
```

## Setting up the environment

To make both installations work, we need to setup the environment correctly. All of the following should be added to your shell. If you did not change your configuration, you have to add everything to the end of `~/.zshrc`.

First, we have to add the ARM homebrew installation to the `PATH` environment variable. This will make sure both tools installed using ARM brew and Intel brew are available while ARM brew tools have a higher priority:

```bash
if [ -d "/opt/homebrew/bin" ]; then
    export PATH="/opt/homebrew/bin:$PATH"
fi
```

As we now have two homebrew installations, we need a way to differentiate the two. For that, we simply can add the following:

```bash
function ibrew() {
   arch --x86_64 /usr/local/bin/brew $@
}
```

Now we can install ARM compatible software using `brew install <name>` and the rest using `ibrew install <name>`.

## Best practice

From that point on, one has to decide between `brew` and `ibrew` when installing new software. The follwing are my recommendations:

1. For casks always use `brew`. Casks are precompiled so it does not make a difference and if one ever wants to uninstall the workaround Intel brew, one does not have to reinstall the casks.
1. First try to install new software using `brew`. If the software is compatible, it does not have to use Rosetta which will make the software faster.
    - [This post](https://github.com/Homebrew/brew/issues/7857) keeps track of which core formulae currently work, although this is not always up to date. I was able to install quite a few tools which are not checked in the post, yet.
1. If the software is not compatible, you have to use `ibrew`. Some packages might still not work. In that case your out of luck. You can try to install them manually or have to wait for an upgrade.
1. If other software relies on absolut paths and expect a software in `/usr/local/bin` (the default path for Intel brew), I would simply install the software with `ibrew` even if it is compatible. Additionally, I would installed it with `brew` as well.
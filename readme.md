# Scripts, utilities and configuration files

Repository for maintaining and backing up my personalized files.

## [.bashrc](./.bashrc)

Bash configuration file, should be located in the user home directory (`/home/username/.bashrc` or simply `~/.bashrc`).

Configures the PS1 prompt, aliases, path variables, completions, some tools etc.

As far as I know, this file is sourced by the shell on startup and its content stays in memory.
Therefore, for less-used commands, it's better to create a script and append it to the `PATH` variable.

For changes to take effect the shell must be restarted.

## [.vimrc](./.vimrc)

Vim configuration file, should be located in the user home directory (`~/.vimrc`).

For Neovim, it is possible to use this file as well (although is probably better to read Neovim docs).
Anyway, to use this file to configure Neovim it should be renamed to `init.vim` and placed in the Neovim configuration directory (`~/.config/nvim/init.vim`).

## [inputrc](./inputrc)

This file should be located at `/etc/inputrc`.

I use it to toggle on the insensitive autocompletion and to turn off the (extremely annoying) bell sound.

## [profile.ps1](./Microsoft.PowerShell_profile.ps1)

Is it too bad to say that this is PowerShell's `.bashrc`?

Anyway, it's located in the PowerShell profile dir, whose path is stored in the `$PROFILE` variable (but is usually at `C:\Users\username\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`).

I use it to set the prompt/PS1 (with Git branch name inside repos) and to create some functions and aliases, mainly for running `.jar` applications.

## [run-jar.sh](./run-jar.sh)

As I commented in the [_.bashrc_ section](#bashrc), I prefer to create scripts for less used commands instead of putting them in the `.bashrc`.

Given that I don't use `.jar` applications that often, I created this script to run them.
I keep it in the `/opt/` directory and use it to create other scripts for running specific _jars_, which I add to the `PATH` variable in the _.bashrc_ file. E.g.:

_/opt/asm-simulators/bin/rars_
```bash
#!/bin/bash

/opt/run-jar.sh '/opt/asm-simulators/rars/rars-1_6.jar'

```

In _~/.bashrc_
```bash
# add scripts for run .jar apps
export PATH="$PATH:/opt/asm-simulators/bin"

```

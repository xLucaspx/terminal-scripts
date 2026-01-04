# Vim

My Vim configuration files and commands reference guide.

- [`.vimrc`](#vimrc)
- [Commands and options](#commands-and-options)
- [Spell checking](#spell-checking)

## `.vimrc`

Vim configuration file, should be located in the user home directory (`~/.vimrc`).

For Neovim, it is possible to use this file as well (although it is probably better to read Neovim docs). Anyway, to use
this file to configure Neovim it should be renamed to `init.vim` and placed in the Neovim configuration directory
(`~/.config/nvim/init.vim`).

## Commands and options

Depending on the option, it can be used with `set` as a configuration, or it can be used as a stand-alone command, e.g.,
`set nohlsearch` deactivates search highlight for all searches, but `nohl` clears the current search highlight without
changing the option. Some names also exist both as options and commands, e.g., `set number` activates line numbering,
but `number` prints the current line number.

| Command (Short)                  | Inverse (Short)                       | Description                                                                                           |
| -------------------------------- | ------------------------------------- | ----------------------------------------------------------------------------------------------------- |
| `set autoindent` (`set ai`)      | `set noautoindent` (`set noai`)       | Copies the indentation of the previous line when starting a new one                                   |
| `set cursorline` (`set cul`)     | `set nocursorline` (`set nocul`)      | Toggles current line highlighting                                                                     |
| `set expandtab` (`set et`)       | `set noexpandtab` (`set noet`)        | When active, inserts spaces instead of tab characters                                                 |
| `set hlsearch` (`set hls`)       | `set nohlsearch` (`set nohls`, `noh`) | Toggles persistent search highlight on matches                                                        |
| `set ignorecase` (`set ic`)      | `set noignorecase` (`set noic`)       | Makes searches case insensitive by default (used with `set smartcase`)                                |
| `set incsearch` (`set is`)       | `set noincsearch` (`set nois`)        | Toggles incremental search results highlighting while typing the pattern                              |
| `set number` (`set nu`)          | `set nonumber` (`set nonu`)           | Toggles line numbering / Prints current line number                                                   |
| `set relativenumber` (`set rnu`) | `set norelativenumber` `set nornu`    | Toggles line numbering relative to the cursor                                                         |
| `set smartcase` (`set scs`)      | `set nosmartcase` (`set noscs`)       | Makes searches case-sensitive if the pattern contains upper-case letters (used with `set ignorecase`) |
| `set spell`                      | `set nospell`                         | Toggles spell checking (configure languages with `set spelllang`)                                     |

## Spell checking

Enable/disable with `set spell/nospell`. More than one language can be set in spell checking, e.g.:
`set spelllang=en_gb,pt_br`.

To check suggestions for marked words, place the cursor on the word and use `z=`. To navigate between marked words, use
`[s` and `]s`. To add a word to your personal dictionary, use `zg` (good word), and to mark a word as wrong use `zw`
(wrong word).

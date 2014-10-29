## Intro
This is a fork of the invaluable http://www.vim.org/scripts/script.php?script_id=363

## Description
Toggle view of invisible characters such as tabs, trailing spaces and hard returns. The script includes intuitive presets for these characters, a global environmental variable (g:LIST) that is retained and initialized across sessions if you use a viminfo, and a familiar (to some of us) keyboard shortcut mapping to F4.

If you want to change this shortcut add this in `~/.vimrc`

```vim
let g:creamInvisibleShortCut = "<F5>"
```

This configuration includes characters as nice looking as your specific setup will allow, determined by hardware, operating system and Vim version. (Vim version 6.1.469 supports multi-byte characters, used with UTF-8 encoding.)

## Installation

You can (should) use vundle to install with ease:

```vim
Plugin 'albfan/cream-invisibles'
```

then perform

```vim
:PluginInstall
```

## Related projects

This is one of the many custom utilities and functions for gVim from the Cream project (http://cream.sourceforge.net), a configuration of Vim for those of us familiar with Apple and Windows software.

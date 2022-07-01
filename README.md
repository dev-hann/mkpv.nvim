# Markdown Preview


It is Markdown Preview for Vim(neoVim). Written by `Flutter` & `Dart`.

Main features:

## Install

### Plugin

Add the following text to your `vimrc`.

```
  call plug#begin()
   Plug 'yoehwan/mkpv.nvim'
  call plug#end()
```

then run the following in vim

```
   :source %
   :PlugInstall
```

## Getting Started
	
## Config
```
  // if when value is 1, when open Readme file,
  // automatically open preview app.
  g:auto_open_mkpv=0

  // according your current line on vim,
  // preview app auto scroll to current line.
  g:auto_scroll_mkpv=1

```

## Future Works


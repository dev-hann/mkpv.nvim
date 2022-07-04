# Markdown Preview

It is Markdown Preview for (neo)Vim. Written by `Flutter` & `Dart`.

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

<b>your readme file must saved before launch Preview app.

( Preview app watching your readme file changed! )</b>

```
// Launch Preview App. 
:MKPVOpen

:MKPVClose

:MKPVUpdate

:MKPVToggleAutoScroll
```


## Config
```
  // if when value is 1, when open Readme file,
  // automatically open preview app.
  // g:auto_open_mkpv=0 (Not support yet)

  // according your current line on vim,
  // preview app auto scroll to current line.
  g:auto_scroll_mkpv=1
  ```

## Future Works
* (AutoScroll) ~~According buffer current line, scroll Preview App line.~~
* (AutoLaunch) when buffer's extension is md file, launch Preview App 'Automatically'.
* (Read Buffer File) Read not saved temp Buffer file.


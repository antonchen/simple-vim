" File: .vimrc
" Author: Anton Chen
" Version: 0.1
" Email: contact@antonchen.com
" Last Modified: 2016-10-05 20:24

" Global Settings 全局设置
" {{{

" 设置 <Leader>
let mapleader = ','
let g:mapleader = ','

" 判断操作系统类型
if has("win32") || has("win32unix")
    let g:OS#name = "win"
    let g:OS#win = 1
    let g:OS#mac = 0
    let g:OS#unix = 0
elseif has("mac")
    let g:OS#name = "mac"
    let g:OS#mac = 1
    let g:OS#win = 0
    let g:OS#unix = 0
elseif has("unix")
    let g:OS#name = "unix"
    let g:OS#unix = 1
    let g:OS#win = 0
    let g:OS#mac = 0
endif
if has("gui_running")
    let g:OS#gui = 1
else
    let g:OS#gui = 0
endif

" 设置用户路径
if g:OS#win
    let $VIMFILES = $VIM.'/vimfiles'
    let $HOME = $VIMFILES
    let $WORKING = 'D:\Documents\Working'
    source $VIMRUNTIME/mswin.vim
    behave mswin
elseif g:OS#unix
    let $VIM = $HOME
    let $VIMFILES = '~/.vim'
elseif g:OS#mac
    let $VIM = $HOME
    let $VIMFILES = '~/.vim'
endif


" }}}

" Load File 加载配置
" {{{

if filereadable(expand("~/.vim/main.vimrc"))
    source ~/.vim/main.vimrc
endif

" }}}

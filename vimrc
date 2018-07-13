" Simple vim config for server.
" Version: 0.1
" Author: Anton Chen <contact@antonchen.com>
" Create Date: 2016-08-22 15:07:51
" Last Modified: 2018-07-13 11:32:54

let Author = 'Your Name <youremail@example.com>'

" Settings
" {{{

" Leader
let mapleader = ','
let g:mapleader = ','
" 高亮
syntax on
" 历史行数
set history=2000
" 文件类型识别
filetype on
" 开启插件
filetype plugin on
" 开启 indent 缩进
filetype indent on

" 基础设置
set shortmess=atI                      " 不显示欢迎信息
set helplang=cn                        " 首选帮助语言
set title                              " 终端标题
set magic                              " 开启 magic 正则
set nobackup                           " 关闭备份
set nocompatible                       " 禁止 vi 模式
set backspace=indent,eol,start         " 设置 <Backspace>
" set clipboard=unnamed                  " 拷贝到系统剪切板
" set whichwrap+=<,>,h,l                 " 左右移动跨行
set autoread                           " 文件在Vim之外修改过，自动重新读入
set lazyredraw                         " 运行宏时不重绘

" 关闭错误提示
set novisualbell                       " 关闭闪烁提示
set noerrorbells                       " 关闭声音提示
set t_vb=
set tm=500

" 配色
colorscheme molokai
let g:rehash256 = 1

" 高亮
" set cursorcolumn                       " 高亮当前列
" set cursorline                         " 高亮当前行

" 剩余 7 行时翻页
set scrolloff=7
" 禁用鼠标
" set mouse=a

" 显示
set ruler                              " 显示当前行号与列号
set number                             " 显示行号
set numberwidth=6                      " 设置行号列宽度
" set nowrap                             " 关闭自动换行
set showcmd                            " 在状态栏显示正在输入的命令
set showmode                           " 显示当前Vim模式
" set showmatch                          " 当关闭如括号这样的代码时，光标跳转到括号开始再跳回
" set matchtime=3                        " 光标跳转时间

" 搜索
set hlsearch                           " 高亮匹配
set incsearch                          " 开启即时搜索
set ignorecase                         " 搜索时忽略大小写
set smartcase                          " 字符串有大写字母时大小写敏感

" 缩进
set expandtab                          " 使用空格缩进
set smartindent                        " 智能缩进
set autoindent                         " 继承缩进
set shiftround                         " 缩进宽度对齐到 shiftwidth 的整数倍
set tabstop=4                          " <Tab> 宽度
set softtabstop=4                      " 编辑模式下 <Tab> 宽度
set shiftwidth=4                       " 自动缩进宽度
set smarttab                           " 插入 <Tab> 时使用 'shiftwidth'

" 补全
set wildmenu                           " 命令模式补全
set wildmode=full                      " 补全菜单样式
set wildignore=*.o,*~,*.pyc,*.class    " 排除补全

" 代码折叠
set foldenable
" 折叠方法
" manual    手工折叠
" indent    使用缩进表示折叠
" expr      使用表达式定义折叠
" syntax    使用语法定义折叠
" diff      对没有更改的文本进行折叠
" marker    使用标记进行折叠, 默认标记是 {{{ 和 }}}
set foldmethod=marker
" 代码折叠自定义快捷键 <leader>zz
let g:FoldMethod = 0
map <leader>zz :call ToggleFold()<cr>
fun! ToggleFold()
    if g:FoldMethod == 0
        exe "normal! zM"
        let g:FoldMethod = 1
    else
        exe "normal! zR"
        let g:FoldMethod = 0
    endif
endfun


" 上次文件编辑位置
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" 字体设置
if has("gui_running")
    set guifont=Monaco:h14
endif

" 状态栏
set laststatus=2                       " 状态栏高度
" set statusline=%<%f\ %h%m%r%=%k\ %m\ %r%y\ [%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}\|%{&ff}]\ %-14.(%l,%c%V%)\ %P
" 转换文件大小
function! Buf_total_num()
    return len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
endfunction
function! File_size(f)
    let l:size = getfsize(expand(a:f))
    if l:size == 0 || l:size == -1 || l:size == -2
        return ''
    endif
    if l:size < 1024
        return l:size.' bytes'
    elseif l:size < 1024*1024
        return printf('%.1f', l:size/1024.0).'k'
    elseif l:size < 1024*1024*1024
        return printf('%.1f', l:size/1024.0/1024.0) . 'm'
    else
        return printf('%.1f', l:size/1024.0/1024.0/1024.0) . 'g'
    endif
endfunction
" 定义状态栏格式
set statusline=%<%1*[B-%n]%*
set statusline+=%2*[TOT:%{Buf_total_num()}]%*
set statusline+=%3*\ %{File_size(@%)}\ %*
set statusline+=%4*%m\ %F\ %*
set statusline+=%=%5*\ %r%y\ [%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}\|%{&ff}]\ %-14.(%l,%c%V%)
set statusline+=%6*\ %P\ %*
" 自定义状态栏颜色
" 终端
hi User1 cterm=bold ctermfg=237 ctermbg=39
hi User2 cterm=None ctermfg=39  ctermbg=242
hi User3 cterm=None ctermfg=251 ctermbg=240
hi User4 cterm=bold ctermfg=169 ctermbg=239
hi User5 cterm=None ctermfg=250 ctermbg=238
hi User6 cterm=None ctermfg=249 ctermbg=240
" GUI
hi User1 gui=bold guifg=#3a3a3a guibg=#00afff
hi User2 gui=None guifg=#00afff guibg=#6c6c6c
hi User3 gui=None guifg=#c6c6c6 guibg=#585858
hi User4 gui=bold guifg=#d75faf guibg=#4e4e4e
hi User5 gui=None guifg=#bcbcbc guibg=#444444
hi User6 gui=None guifg=#b2b2b2 guibg=#585858

" 文件格式
set fileformat=unix

" 新文件编码
set nobomb " 禁止UTF-8 BOM
set encoding=utf-8
set termencoding=utf-8

" 自动识别文件编码
set fileformats=unix,dos,mac
set fileencodings=utf-8,ucs-bom,cp936,gb18030,big5,euc-jp,euc-kr,latin1

" 如遇Unicode值大于255的文本，不必等到空格再折行
set formatoptions+=m
" 合并两行中文时，不在中间加空格
set formatoptions+=B
" 选中颜色
hi Visual term=reverse cterm=reverse guibg=Grey

" }}}

" File type
" {{{

" Fix crontab
autocmd FileType crontab set nobackup nowritebackup
autocmd FileType python set tabstop=4 shiftwidth=4 expandtab ai
autocmd FileType ruby set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
autocmd FileType yaml set tabstop=2 shiftwidth=2 softtabstop=2 expandtab noai nocin nosi inde=
autocmd BufRead,BufNewFile *.md,*.mkd,*.markdown  set filetype=markdown.mkd

autocmd BufRead,BufNewFile nginx.conf set filetype=nginx
autocmd BufRead,BufNewFile */etc/nginx/*.conf set filetype=nginx
autocmd BufRead,BufNewFile */usr/local/nginx/conf/*.conf set filetype=nginx

autocmd BufRead,BufNewFile *.json set filetype=json

autocmd BufNewFile * exec ":call AutoSetFileHead()"
function! AutoSetFileHead()
    let NewFileTime = strftime('%Y-%m-%d %H:%M:%S')
    " .sh
    if &filetype == 'sh'
        call setline(1, "\#!/bin/bash")
        call append(1, "\# Author: ".g:Author)
        call append(2, "\# Create Date: ".NewFileTime)
        call append(3, "\# Last Modified: ".NewFileTime)
        call append(4, "\# Description: ")
        call append(5, "HERE=$(cd -P -- $(dirname -- \"$0\") && pwd -P)")
        normal G
        normal o
    endif

    " python
    if &filetype == 'python'
        call setline(1, "\#!/usr/bin/env python")
        call append(1, "\# encoding: utf-8")
        call append(2, "\# Author: ".g:Author)
        call append(3, "\# Create Date: ".NewFileTime)
        call append(4, "\# Last Modified: ".NewFileTime)
        call append(5, "\# Description: ")
        normal G
        normal o
    endif
endfunc

autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

" }}}

" Key map
" {{{

" 禁用 Ex 模式
nmap Q <Nop>
" 禁用 <F1> 帮助
nmap <F1> <Nop>
" 行号
nmap <F2> :set nu! nu?<CR>
" 换行符
nmap <F3> :set list! list?<CR>
" 自动换行
nmap <F4> :set wrap! wrap?<CR>
" 粘贴模式
set pastetoggle=<F5>
" 格式化
nmap <F6> gg=G<C-o><C-o>
" nmap <F6> :call Format()<CR>
" function! Format()
"     if &filetype != 'json'
"         exec "normal gg=G\<C-o>\<C-o>"
"     else
"         %!python -m json.tool
"     endif
" endfun

" 快速保存
nmap <leader>w :w<CR>
" 快速退出
nmap <leader>q :q<CR>
" 快速保存退出
nmap <leader>x :x<CR>

" U 重做
nmap U <C-r>

" 快速进入命令行
nmap ; :

" 关闭搜索 ,/
noremap <silent><leader>/ :nohls<CR>

" Bash模式:C-a 行首,C-e 行尾
map <C-a> <Home>
map <C-e> <End>

" 标签跳转
map <S-Up> :bp<CR>
map <S-Down> :bn<CR>

" 关闭方向键
" map <Left> <Nop>
" map <Right> <Nop>
" map <Up> <Nop>
" map <Down> <Nop>

" }}}

" Plugin
" {{{
" SuperTab
let g:SuperTabMappingForward = "<s-tab>"
let g:SuperTabRetainCompletionType = 0
let g:SuperTabDefaultCompletionType = "<C-N>"
" TagmaLast
let g:TagmaLastAutoUpdate = 1
let g:TagmaLastTimeFormat = '%Y-%m-%d %H:%M:%S'
" }}}

" File: main.vimrc
" Author: Anton Chen
" Version: 0.1
" Email: contact@antonchen.com
" Last Modified: 2016-07-13 17:45

" General Settings 基础设置
" {{{

" 不要Vim模仿Vi模式，兼容设置
set nocompatible
" 设置退格键
set backspace=indent,eol,start

" 历史记录
set history=5000

" 文件类型识别
filetype on
" 针对不同的文件类型采用不同的缩进格式
filetype indent on
" 允许插件
filetype plugin on
" 启动自动补全
filetype plugin indent on

" 文件修改之后自动载入
set autoread

" 取消备份
set nobackup
" 关闭交换文件
set noswapfile

" 不启用鼠标
" set mouse-=a

" 修改终端标题
set title 

" 设置viminfo文件存储内容
set viminfo^=%

" 开启正则表达式
set magic

" 即时搜索模式
set incsearch
" 搜索忽略大小写
set ignorecase
" 有大写字母时大小写敏感
set smartcase

" 智能缩进
set smartindent
" 自动缩进
set autoindent

" Tab 键设置
" 宽度
set tabstop=4
" 继承缩进宽度
set shiftwidth=4
" 退格键一次删除 4个空格
" set softtabstop=4
set smarttab
" 使用空格缩进
set expandtab
" 缩进时取整
set shiftround

" 开启代码折叠
set foldenable
" 折叠方法
" manual    手工折叠
" indent    使用缩进表示折叠
" expr      使用表达式定义折叠
" syntax    使用语法定义折叠
" diff      对没有更改的文本进行折叠
" marker    使用标记进行折叠, 默认标记是 {{{ 和 }}}
set foldmethod=marker
" set foldlevel=99
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

" }}}

" Display Settings 显示设置
" {{{

" 字体设置
if g:OS#gui && g:OS#unix
    set guifont=Sauce\ Code\ Powerline\ Regular\ 12
elseif g:OS#gui && g:OS#mac
    "set guifont=Sauce_Code_Powerline:h14
    set guifont=Monaco_for_Powerline_Plus_Nerd_File_Types:h14
elseif g:OS#gui && g:OS#win
    set guifont=Sauce_Code_Powerline:h12
endif

" 启动后无欢迎界面
set shortmess=atI

" 隐藏菜单栏
if g:OS#gui
set guioptions-=m " 隐藏菜单栏
set guioptions-=T " 隐藏工具栏
set guioptions-=L " 隐藏左侧滚动条
set guioptions-=r " 隐藏右侧滚动条
set guioptions-=b " 隐藏底部滚动条
set showtabline=0 " 隐藏Tab栏
endif

" 退出后内容显示在终端
set t_ti= t_te=

" 开启语法高亮
syntax on

" 显示当前的行号列号
set ruler
" 在状态栏显示正在输入的命令
set showcmd
" 左下角显示当前Vim模式
set showmode

" 显示行号
set number
" 行号宽度
set numberwidth=6

" 移动光标时保留多少行开始滚动
set scrolloff=7

" 命令行（在状态行下）的高度，默认为1，这里是2
set statusline=%<%f\ %h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)\ %P
set laststatus=2

" 突出显示当前列
set cursorcolumn
" 突出显示当前行
set cursorline

" 高亮搜索到的文本
set hlsearch

" 括号匹配的情况下跳转至匹配括号高亮一下
" set showmatch
" set matchtime=2

" }}}

" Encoding Settings 文件编码设置
" {{{

" 文件格式
set fileformat=unix

" 新文件编码
set encoding=utf-8
set termencoding=utf-8
set fileformats=unix,dos,mac

" 自动识别文件编码
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set helplang=cn

" 禁止UTF-8 BOM
set nobomb

" 如遇Unicode值大于255的文本，不必等到空格再折行
set formatoptions+=m
" 合并两行中文时，不在中间加空格
set formatoptions+=B

" }}}

" Others 其它配置
" {{{

" 上次文件编辑位置
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Windows 文件默认保存位置
if g:OS#win
    exec 'cd ' . fnameescape($WORKING)
endif

" }}}

" Load File 载入配置
" {{{

if filereadable(expand("~/.vim/hotkey.vimrc"))
    source ~/.vim/hotkey.vimrc
endif

" }}}

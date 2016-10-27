" File: main.vimrc
" Author: Anton Chen
" Version: 0.1
" Email: contact@antonchen.com
" Last Modified: 2016-10-27 15:13

" Load File 加载配置
" {{{
if filereadable(expand("~/.vim/plugins.vimrc"))
        source ~/.vim/plugins.vimrc
    endif

if filereadable(expand("~/.vim/hotkey.vimrc"))
    source ~/.vim/hotkey.vimrc
endif

" }}}

" General Settings 基础设置
" {{{

" 高亮
syntax on
" 历史行数
set history=2000
" 文件类型识别
filetype on
" 开启插件
filetype plugin on
" 开启自动
filetype indent on

" 基础设置
set title                              " 终端标题
set helplang=cn                        " 首选帮助语言
set magic                              " 开启 magic 正则
set nobackup                           " 关闭备份
set noswapfile                         " 关闭交换文件
set nocompatible                       " 禁止 vi 模式
set backspace=indent,eol,start         " 设置 <Backspace>
"set clipboard=unnamed                  " 拷贝到系统剪切板
set whichwrap+=<,>,h,l                 " 左右移动跨行
set autoread                           " 文件在Vim之外修改过，自动重新读入
set viminfo^=%                         " 设置viminfo文件存储内容

" 关闭错误提示
set novisualbell                       " 关闭闪烁提示
set noerrorbells                       " 关闭声音提示
set t_vb=
set tm=500

" 高亮
set cursorcolumn                       " 高亮当前列
set cursorline                         " 高亮当前行

" 启用鼠标
" set mouse=a

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

" 隐藏菜单栏
if g:OS#gui
set guioptions-=m                      " 隐藏菜单栏
set guioptions-=T                      " 隐藏工具栏
set guioptions-=L                      " 隐藏左侧滚动条
set guioptions-=r                      " 隐藏右侧滚动条
set guioptions-=b                      " 隐藏底部滚动条
set showtabline=0                      " 隐藏Tab栏
endif

set ruler                              " 显示当前行号与列号
set shortmess=atI                      " 不显示欢迎信息
set number                             " 显示行号
set numberwidth=6                      " 设置行号列宽度
set nowrap                             " 关闭自动换行
set showcmd                            " 在状态栏显示正在输入的命令
set showmode                           " 显示当前Vim模式
set scrolloff=7                        " 剩余 7 行时翻页
" set showmatch                          " 当关闭如括号这样的代码时，光标跳转到括号开始再跳回
" set matchtime=3                        " 光标跳转时间
" set t_ti= t_te=                        " 退出后内容显示在终端

" 选中颜色
hi Visual term=reverse cterm=reverse guibg=Grey

" 状态栏
set laststatus=2                       " 状态栏高度
set statusline=%<%f\ %h%m%r%=%k<%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}\ [%{&ff}]>\ %-14.(%l,%c%V%)\ %P

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

" Fix crontab
autocmd filetype crontab setlocal nobackup nowritebackup

" Windows 文件默认保存位置
if g:OS#win
    exec 'cd ' . fnameescape($WORKING)
endif

" }}}

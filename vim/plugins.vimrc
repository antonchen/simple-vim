" File: plugin.vimrc
" Author: Anton Chen
" Version: 0.1
" Email: contact@antonchen.com
" Last Modified: 2016-07-20 14:06

" Vim-Plug
" {{{
call plug#begin('~/.vim/plugins')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-startify'
Plug 'tomasr/molokai'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

Plug 'majutsushi/tagbar'
Plug 'Shougo/neocomplete.vim'
Plug 'antonchen/vim-snippets'
Plug 'tracyone/dict'
Plug 'SirVer/ultisnips'

Plug 'antonchen/vim-template'
Plug 'vim-scripts/TagmaLast'


call plug#end()
" }}}

" File Header
" {{{

" vim-template
let g:username = 'Anton Chen'
let g:email = 'contact@antonchen.com'
" TagmaLast
let g:TagmaLastAutoUpdate = 1
let g:TagmaLastTimeFormat = '%Y-%m-%d %H:%M'

" }}}

" UltiSnips
" {{{
let g:UltiSnipsUsePythonVersion = 2
let g:UltiSnipsExpandTrigger = '<Tab>'
let g:UltiSnipsListSnippets = '<C-Tab>'
let g:UltiSnipsJumpForwardTrigger = '<Tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'
let g:UltiSnipsSnippetDirectories = ["plugins/vim-snippets"]
let g:UltiSnipsSnippetsDir = $VIMFILES.'/plugins/vim-snippets'
" }}}

" NeoComplete
" {{{

let g:neocomplete#enable_at_startup = 1

" }}}

"Tagbar
nmap <F8> :TagbarToggle<CR>

" Airline
" {{{

let g:airline_theme = 'luna'
let g:airline_powerline_fonts = 1
" 打开Tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" 关闭空白符合计数器
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#symbol = '!'

set t_Co=256
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" }}}

" startify
" {{{

let g:startify_custom_header = []

" }}}

" 配色设置
colorscheme molokai 
let g:rehash256 = 1

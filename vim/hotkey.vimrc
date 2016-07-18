" File: hotkey.vimrc
" Author: Anton Chen
" Version: 0.1
" Email: contact@antonchen.com
" Last Modified: 2016-07-13 17:45

" HotKey Settings  快捷键设置
" {{{

" 废弃F1帮助
noremap <F1> <Esc>''

" 设置 <F3> 粘贴模式
set pastetoggle=<F3>

" 关闭搜索 ,/
noremap <silent><leader>/ :nohls<CR>

" Bash模式:C-a 行首,C-e 行尾
map <C-j> <t_kd>
map <C-k> <t_ku>
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

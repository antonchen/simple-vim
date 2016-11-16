" File: hotkey.vimrc
" Author: Anton Chen
" Version: 0.1
" Email: contact@antonchen.com
" Last Modified: 2016-11-16 14:30

" HotKey Settings  快捷键设置
" {{{

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

#!/bin/bash
# Create Date: 2017-05-17 11:24:39
# Last Modified: 2017-05-17 12:03:51
shellDir="$(cd `dirname $0` && pwd)"
vimConfURL='https://github.com/antonchen/simple-vim/archive/master.zip'

which wget > /dev/null 2>&1
if [ $? -eq 0 ]; then
    wget --no-check-certificate -c $vimConfURL
else
    curl -O $vimConfURL
fi

if [ -f master.zip ]; then
    mv master.zip simple-vim.zip
    if unzip simple-vim.zip; then
        mv simple-vim-master simple-vim
        rm -f simple-vim.zip
    else
        echo "[-] Unzip file failed, please install unzip command." >&2
        exit 2
    fi
else
    echo "[-] Download failed." >&2
    exit 2
fi

if [ -d $HOME/.vim ]; then
    echo "[+] Backup $HOME/.vim to $HOME/.vim_bak" >&2
    mv $HOME/.vim{,_bak}
fi
if [ -f $HOME/.vimrc ]; then
    echo "[+] Backup $HOME/.vimrc to $HOME/.vimrc_bak" >&2
    mv $HOME/.vimrc{,_bak}
fi

cp -r simple-vim/vim $HOME/.vim
cp simple-vim/vimrc $HOME/.vimrc
rm -rf simple-vim
echo "[+] Install simple vim successfully." >&2

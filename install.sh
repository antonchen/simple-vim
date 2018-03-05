#!/bin/bash
# Create Date: 2017-05-17 11:24:39
# Last Modified: 2018-03-05 13:54:55
HERE=$(cd -P -- $(dirname -- "$0") && pwd -P)
DownloadURL='https://github.com/antonchen/simple-vim/archive/master.zip'

if command -v wget > /dev/null 2>&1; then
    wget --no-check-certificate -O simple-vim.zip -c $DownloadURL
elif command -v curl > /dev/null 2>&1; then
    curl -k -L -e  '; auto' -o simple-vim.zip $DownloadURL
else
    echo "[-] Download file failed, please install wget or curl command." >&2
fi

if [ -f simple-vim.zip ]; then
    test -d simple-vim-master && rm -rf simple-vim-master
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

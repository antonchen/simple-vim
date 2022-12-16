#!/bin/bash
# Create Date: 2017-05-17 11:24:39
# Last Modified: 2018-10-18 18:20:11
DownloadURL='https://ghproxy.com/https://github.com/antonchen/simple-vim/archive/refs/heads/master.tar.gz'

cd /tmp
if command -v wget > /dev/null 2>&1; then
    wget --no-check-certificate -O simple-vim.tar.gz -c $DownloadURL
elif command -v curl > /dev/null 2>&1; then
    curl -k -L -e  '; auto' -o simple-vim.tar.gz $DownloadURL
else
    echo "[-] Download file failed, please install wget or curl command." >&2
fi

if [ -f simple-vim.tar.gz ]; then
    test -d simple-vim-master && rm -rf simple-vim-master
    echo "[+] Extracting files..." >&2
    if gzip -dc simple-vim.tar.gz | tar -xf -; then
        mv simple-vim-master simple-vim
        rm -f simple-vim.tar.gz
    else
        echo "[-] Extract file failed." >&2
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

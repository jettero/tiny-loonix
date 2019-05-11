#!/bin/bash

function ppacman {
    pacman --cachedir /poo --noconfirm --needed "$@"
}

function pinstall {
    ppacman -Sy archlinux-keyring
    ppacman -S  pacman

    if [ $# -gt 0 ]
    then ppacman -S "$@"
    fi

    rm -rf /poo
}

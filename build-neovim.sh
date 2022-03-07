#!/bin/bash
set -e

is_ubuntu() {
    command -v apt-get >/dev/null
}

is_arch() {
    command -v pacman >/dev/null
}

install_ubuntu_deps() {
    sudo apt-get update
    sudo apt-get install -y \
        autoconf \
        automake \
        cmake \
        curl \
        doxygen \
        g++ \
        gettext \
        git \
        libtool \
        libtool-bin \
        ninja-build \
        pkg-config \
        unzip
}

install_arch_deps() {
    sudo pacman -Sy --needed --noconfirm \
        base-devel \
        cmake \
        curl \
        git \
        ninja \
        tree-sitter \
        unzip
}

build_neovim() {
    local srcdir="${HOME}/.local/src/neovim"
    mkdir -p $(dirname $srcdir)
    git clone "https://github.com/neovim/neovim" $srcdir
    cd $srcdir
    make CMAKE_BUILD_TYPE=Release
    sudo make install
}

if is_ubuntu; then
    install_ubuntu_deps
    build_neovim
elif is_arch; then
    install_arch_deps
    build_neovim
else
    echo "Error: unknown system, aborting." >&2
    exit 1
fi

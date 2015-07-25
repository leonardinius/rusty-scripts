#!/bin/bash

set -x 
set -e

version=${1:-"nightly"}
toolchain="rustc-${version}"
target=/usr/local/src

mememe=$(users)

cd ${target}/${toolchain}/

src_dirs=`ls -d ${target}/${toolchain}/src/{liballoc,libarena,libbacktrace,libcollections,libcore,libflate,libfmt_macros,libgetopts,libgraphviz,liblog,librand,librbml,libserialize,libstd,libsyntax,libterm}`

ctags -f rusty-tags.vi --options=src/etc/ctags.rust --languages=Rust --recurse $src_dirs
ctags -e -f rusty-tags.emacs --options=src/etc/ctags.rust --languages=Rust --recurse $src_dirs

mkdir /home/${mememe}/.rusty-tags || echo 'Assuming directory already exists'

cp rusty-tags.emacs /home/${mememe}/.rusty-tags/rust-std-lib.emacs
cp rusty-tags.vi /home/${mememe}/.rusty-tags/rust-std-lib.vi
chown -R ${mememe}:${mememe} /home/${mememe}/.rusty-tags/

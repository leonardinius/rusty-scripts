#!/bin/sh

set -x 
set -e

cd $(mktemp -d);

version=${1:-"nightly"}
toolchain="rustc-${version}"
toolchain_src=${toolchain}-src.tar.gz
target=/usr/local/src

mememe=$(users)

wget https://static.rust-lang.org/dist/${toolchain_src} -O out.tar.gz

mkdir out

rm -rf ${target}/${toolchain}
tar xzf out.tar.gz -C ${target}

chown -R ${mememe}:${mememe} ${target}/${toolchain}


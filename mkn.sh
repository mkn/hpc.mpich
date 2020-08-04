#!/usr/bin/env bash
set -ex
CWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
MPICH_VER="3.3.2"

[ ! -d mpich ]  && git clone https://github.com/pmodels/mpich -b v${MPICH_VER} mpich

clean(){ rm -rf inc lib }

build(){
  cd mpich && git submodule update --init
  ./autogen.sh --without-izem --without-ucx --without-libfabric
  ./configure --prefix=$CWD --disable-fast # --enable-g=all 
  make -j && make install && make clean
  echo 0
}

[ -n "$MKN_CLEAN" ] && ((MKN_CLEAN > 0)) && clean

exit $(build)

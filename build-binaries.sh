#!/bin/bash
# steps to build Wget+Lua and Rsync binaries

mkdir dest

mkdir src
cd src

curl -L http://www.lua.org/ftp/lua-5.1.5.tar.gz | tar xz
curl -L http://warriorhq.archiveteam.org/downloads/wget-lua/wget-1.14.lua.LATEST.tar.bz2 |bunzip2 > wget-1.14.lua.LATEST.tar
curl -L https://rsync.samba.org/ftp/rsync/rsync-3.0.9.tar.gz | tar xz

cd lua-5.1.5
sed -i 's/INSTALL_TOP= \/usr\/local/INSTALL_TOP= \/tmp/' Makefile
make linux
make install
cd ../

mkdir wget-1.14.lua
cd wget-1.14.lua
tar --strip-components=1 -xf ../wget-1.14.lua.LATEST.tar
CFLAGS=-I/tmp/include LDFLAGS=-L/tmp/lib ./configure --with-ssl=openssl --disable-nls
make
cp src/wget ../../dest/wget-lua
cd ..

cd rsync-3.0.9
./configure
make
cp rsync ../../dest/rsync
cd ..

cd ../dest
tar czvf warrior-binaries-$( date +'%Y%m%d' ).tar.gz *


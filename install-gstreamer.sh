#! /bin/bash

sqlite_version="sqlite-autoconf-3410200"
gstreamer_version="1.22.2"

base_dir=$(cd "$(dirname "$0")";pwd)

if [ ! -f ${sqlite_version}".tar.gz" ]; then
  echo "sqlite not found, cloning"
  wget https://www.sqlite.org/2023/${sqlite_version}.tar.gz
fi

if [ ! -d ${sqlite_version} ]; then
  tar -zxvf ${sqlite_version}.tar.gz
fi

cd ${sqlite_version}

if grep "#define SQLITE_ENABLE_COLUMN_METADATA 1" 'sqlite3.c' > /dev/null
then
  echo "sqlite enable column metadata"
else 
  sed -i '/#define SQLITE_AMALGAMATION 1/a\#define SQLITE_ENABLE_COLUMN_METADATA 1' sqlite3.c 
fi

./configure && make && sudo make install

cd ${base_dir}

sudo apt install -y libopencv-dev nasm libx264-dev libx265-dev

if [ ! -f "gstreamer-"${gstreamer_version}".tar.gz" ];then
  echo "gstreamer not found, cloning"
  wget https://gitlab.freedesktop.org/gstreamer/gstreamer/-/archive/${gstreamer_version}/gstreamer-${gstreamer_version}.tar.gz
fi

if [ ! -d gstreamer-${gstreamer_version}.tar.gz ]; then
  tar -zxvf gstreamer-${gstreamer_version}.tar.gz
fi

cd gstreamer-${gstreamer_version} && rm -rf build &&  meson build --prefix=/usr/local/gstreamer -Dlibav=enabled -Dgst-full-plugins=enabled \
    -Dcairo:cairo=disabled \
    -Dbase:x11=enabled \
    -Dbase:xshm=enabled \
    -Dbase:xvideo=enabled \
    -Dbase:xi=enabled \
    -Dvaapi=enabled \
    -Dgpl=enabled \
    -Dbad=enabled \
    -Dgst-plugins-bad:x265=enabled \
    -Dvaapi:encoders=enabled && cd build && ninja && sudo ninja install
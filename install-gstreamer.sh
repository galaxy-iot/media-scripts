# /bin/bash

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

tar -zxvf ${sqlite_version}.tar.gz
cd ${sqlite_version} && ./configure && make && sudo make install

cd ${base_dir}

sudo apt install libopencv-dev

if [ ! -f "gstreamer-"${gstreamer_version}".tar.gz" ];then
  echo "gstreamer not found, cloning"
  wget https://gitlab.freedesktop.org/gstreamer/gstreamer/-/archive/${gstreamer_version}/gstreamer-${gstreamer_version}.tar.gz
fi

if [ ! -d gstreamer-${gstreamer_version}.tar.gz ]; then
  tar -zxvf gstreamer-${gstreamer_version}.tar.gz
fi

cd gstreamer-${gstreamer_version} && meson build --prefix=/usr/local/gstreamer -Dlibav=enabled -Dgst-full-plugins=enabled \
    -Dcairo:cairo=disabled \
    -Dbase:x11=enabled \
    -Dbase:xshm=enabled \
    -Dbase:xvideo=enabled \
    -Dbase:xi=enabled \
    -Dvaapi=enabled \
    -Dvaapi:encoders=enabled && cd build && ninja && sudo ninja install
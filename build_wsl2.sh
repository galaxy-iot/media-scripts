#! /bin/bash
sudo apt install -y glslang-tools libelf-dev byacc libxml2-dev graphviz doxygen xsltproc xmlto libxcb-glx0-dev libxcb-shm0-dev libx11-xcb-dev libxcb-dri2-0-dev libxcb-dri3-dev libxcb-present-dev libxshmfence-dev autoconf libtool llvm-11 libxext-dev libxfixes-dev libxxf86vm-dev libxrandr-dev

sudo pip3 install mako

base_dir=$(cd "$(dirname "$0")";pwd)

echo ${base_dir}

if [ ! -d "wayland" ]; then
  echo "wayland not found, cloning"
  git clone https://gitlab.freedesktop.org/wayland/wayland.git
fi

echo "build wayland"
cd wayland && meson build && ninja -C build && sudo ninja -C build install
echo "build wayland done"
cd ${base_dir}

if [ ! -d "wayland-protocols" ]; then
  echo "wayland protocol not found, cloning"
  git clone https://gitlab.freedesktop.org/wayland/wayland-protocols.git
fi

echo "build wayland protocols"
cd wayland-protocols && meson build && ninja -C build && sudo ninja -C build install
echo "build wayland protocols done"

cd ${base_dir}

if [ ! -d "drm" ];then
  echo "drm not found, cloning"
  git clone https://gitlab.freedesktop.org/mesa/drm.git
fi

echo "build drm"
cd drm && meson build && sudo ninja -C build install
echo "build drm done"

cd ${base_dir}

if [ ! -d "libva" ];then
  echo "libva not found, cloning"
  git clone https://github.com/intel/libva.git -b 2.18.0
fi

echo "build libva"
cd libva/build && meson .. -Dprefix=/usr -Dlibdir=/usr/lib/x86_64-linux-gnu && ninja && sudo ninja install
echo "build libva done"

cd ${base_dir}

if [ ! -d "libva-utils" ];then
  echo "libva-util not found, cloning"
  git clone https://github.com/intel/libva-utils.git -b 2.18.0
fi

echo "build lib utils"
mkdir -p libva-utils/build && cd libva-utils/build && meson .. && ninja && sudo ninja install
echo "build lib utils done"

cd ${base_dir}

if [ ! -f "mesa-23.0.0.tar.xz" ];then 
  echo "mesa tar not found"
  wget https://archive.mesa3d.org/mesa-23.0.0.tar.xz
fi

if [ ! -d "mesa-23.0.0" ];then
  echo "mesa not found"
  tar -Jxvf mesa-23.0.0.tar.xz
fi

echo "build mesa"
mkdir -p mesa-23.0.0/build && cd mesa-23.0.0/build && meson .. -Dprefix=/usr -Dlibdir=/usr/lib/x86_64-linux-gnu -Dgallium-drivers=swrast,d3d12 -Dgallium-va=enabled -Dvideo-codecs=h264dec,h264enc,h265dec,h265enc,vc1dec && ninja && sudo ninja install
echo "build mesa done"
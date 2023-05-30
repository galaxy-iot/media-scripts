#! /bin/bash

source /opt/intel/openvino/setupvars.sh
export PATH=$PATH:/usr/local/gstreamer/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/gstreamer/lib/x86_64-linux-gnu:/usr/local/gstreamer/lib/x86_64-linux-gnu/gstreamer-1.0
export LIBRARY_PATH=$LIBRARY_PATH:/use/local/gsteamer/lib/x86_64-linux-gnu:/usr/local/gstreamer/lib/x86_64-linux-gnu/gstreamer-1.0
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/gstreamer/lib/x86_64-linux-gnu/pkgconfig
export GST_PLUGIN_PATH=$GST_PLUGIN_PATH:/usr/local/gstreamer/lib/x86_64-linux-gnu:/usr/local/gstreamer/lib/x86_64-linux-gnu/gstreamer-1.0

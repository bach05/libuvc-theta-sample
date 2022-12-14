# PRE-INSTALLATION STEPS

This steps are takes from this [guide](https://husarion.com/tutorials/ros-components/ricoh-theta-z1/). 

## v4l2loopback

First download, build and install v4l2loopback. It will allow you to create virtual loopback camera interfaces.

```
mkdir -p ~/your_ws/src/theta_z1
cd ~/your_ws/src/theta_z1/
git clone https://github.com/umlaeute/v4l2loopback.git
cd v4l2loopback/
make && sudo make install
sudo depmod -a
```

After successful installation run:

```
ls /dev | grep video
```

You should see your video interfaces.

If you don't have any other cameras installed the output should be empty. To start loopback interface and find it's ID run:

```
sudo modprobe v4l2loopback
ls /dev | grep video
```
New /dev/video device should appear. It's your loopback interface you will later assign to your THETA Z1.

**ATTENTION**: if you get an error like
```
rmmod: ERROR: Module v4l2loopback is not currently loaded
modprobe: ERROR: could not insert 'v4l2loopback': Operation not permitted
```

Try to solve it with
```
sudo apt-get install v4l2loopback-dkms
```
## Ricoh Theta dependencies

Install required packages:

```

sudo apt-get install libgstreamer1.0-0 \
     gstreamer1.0-plugins-base \
     gstreamer1.0-plugins-good \
     gstreamer1.0-plugins-bad \
     gstreamer1.0-plugins-ugly \
     gstreamer1.0-libav \
     gstreamer1.0-doc \
     gstreamer1.0-tools \
     gstreamer1.0-x \
     gstreamer1.0-alsa \
     gstreamer1.0-gl \
     gstreamer1.0-gtk3 \
     gstreamer1.0-qt5 \
     gstreamer1.0-pulseaudio \
     libgstreamer-plugins-base1.0-dev \
     libjpeg-dev
```

After installation building and install libuvc-theta:

```
cd ~/your_ws/src/theta_z1
git clone https://github.com/ricohapi/libuvc-theta.git
cd libuvc-theta
mkdir build
cd build
cmake ..
make
sudo make install
```
# libuvc-theta-sample
## gst/gst_viewer
Decode and display sample using gstreamer. You may need gstreamer1.0 develpment packages to build and run.

## gst/gst_loopback
Feed decoded video to the v4l2loopback device so that v4l2-based application can use THETA video without modification.

**CAUTION: gst_loopback may not run on all platforms, as decoder to v4l2loopback pipeline configuration is platform dependent.**

### INSTALLATION
```
git clone https://github.com/bach05/libuvc-theta-sample.git
cd gst
make
```

### CUSTOM START UP for loopback (i.e. to read video stream as a webcam with ROS, OpenCV, etc...)
```
sh streaming_theta.sh
```

# OTHER USEFUL GUIDES

* https://husarion.com/tutorials/ros-components/ricoh-theta-z1/ 
* https://codetricity.github.io/theta-linux/ 
* https://community.theta360.guide/t/linux-live-streaming-quick-start-on-ubuntu-x86-how-to-build-libuvc-for-ricoh-theta-v-and-z1/6123

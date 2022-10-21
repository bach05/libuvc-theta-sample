#!/bin/bash

echo '[INITIALIZING] RICOH THETA live streaming.'

sudo rmmod v4l2loopback
sudo modprobe v4l2loopback video_nr=5 card_label="RICOH THETA Z1"

echo '[INIZIALIZED] v4l2loopback on /dev/video5 created.'

echo '[START] streaming started.'

./gst_loopback

echo '[DONE] streaming ended.'

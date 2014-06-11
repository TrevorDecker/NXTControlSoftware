%script for testing the usb Camrea

% Start up the video.
vid = videoinput('linuxvideo',1);
vid.FramesPerTrigger = 1;
preview(vid);

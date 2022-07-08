# cuda-desktop-novnc
Dockerfile for simple novnc docker image based on nvidia/cuda

## NOTICE
This is a part of fun project and there are many problems (only minimal test has been done).
For example, nbody (from cuda-samples) cannot run without `-hostmem` arg).

Update suggestion is welcomed.

When writing the Dockerfile and desktop.conf, the following repos are referenced.
(If there's a problem, please notify me)

[https://github.com/Tiryoh/docker-ros-desktop-vnc](https://github.com/Tiryoh/docker-ros-desktop-vnc)  
[https://github.com/fcwu/docker-ubuntu-vnc-desktop](https://github.com/fcwu/docker-ubuntu-vnc-desktop)  
[https://github.com/uphy/ubuntu-desktop-jp](https://github.com/uphy/ubuntu-desktop-jp)  

# Build and run

## Build

```bash
docker build . -t cuda-desktop-novnc
```

## Run

```bash
docker run -p 6081:6081 --gpus all cuda-desktop-novnc
```

After starting the container, open a browser window and navigate to `http://your.machines.ip.addr:6081` and you can access to the desktop environment.

## Changing configuration

### Resolution

The default setting is `1600x900x16`, meaning you have width x height of 1600x900 and 16-bit color depth.  
If you want to change this configuration, edit `desktop.conf` and build the image again.

The following should be for `1920x1080x24`.

```
[program:X11]
command=/usr/bin/Xvfb :0 -screen 0 1920x1080x24
autorestart=true
stdout_logfile=/var/log/Xvfb.log
stderr_logfile=/var/log/Xvfb.err
```

### Port for noVNC

`novnc` uses port `6081` for browser (in `desktop.conf`).  
If you want to use the other port, specify the port at starting the container.

Host machine's `6900` will be used in the following.

```
docker run -p 6900:6081 --gpus all cuda-desktop-novnc
```

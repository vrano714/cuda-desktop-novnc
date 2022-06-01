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


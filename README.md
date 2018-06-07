# docker-tensorflow-opencv
Automated Build for Tensorflow Docker Containter with OpenCV 3.4.1

If you just want to use opencv with python, I suggest looking at the repo by
[janza](https://github.com/janza/docker-python3-opencv). I have based my
Dockerfile off his, just using a different base to have tensorflow working with
GPU support.

To access GPUs for tensorflow in the docker container, you need NVIDIA-Docker
installed. Use the `docker-tensorflow-opencv:gpu` tag for the gpu enabled
version. For CPU only (significantly smaller image size), use the
`docker-tensorflow-opencv:latest` tag.


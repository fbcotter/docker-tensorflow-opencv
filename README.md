# docker_tensorflow
Automated Build for Tensorflow Docker Containter with OpenCV 3.3.

If you just want to use opencv with python, I suggest looking at the repo by
![janza](https://github.com/janza/docker-python3-opencv). I have based my
Dockerfile off his, just using a different base to have tensorflow working with
GPU support.

To access GPUs for tensorflow in the docker container, you need NVIDIA-Docker
installed.


# hipchat over vnc
#
# VERSION               0.1
# DOCKER-VERSION        0.4

FROM  ubuntu
MAINTAINER Jesse Nelson "spheromak@gmail.com"

# make sure the package repository is up to date
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update

# Install vnc, xvfb in order to create a 'fake' display
RUN apt-get install -y x11vnc xvfb wget libxslt1.1 libsqlite3.0 libltdl7 
RUN mkdir /.vnc

# Setup VNC pass
RUN x11vnc -storepasswd 1234 ~/.vnc/passwd

# setup hipchat sources
RUN echo "deb http://downloads.hipchat.com/linux/apt stable main" > /etc/apt/sources.list.d/atlassian-hipchat.list
ADD hipchat-linux.key /tmp/hipchat.key
RUN apt-key add /tmp/hipchat.key

RUN apt-get update
RUN apt-get -yq install  hipchat

RUN bash -c 'echo "hipchat" >> /.bashrc'

# VNC Port should run
EXPOSE 5900

# Autostart hipchat
CMD ["x11vnc", "-forever", "-usepw", "-create"]


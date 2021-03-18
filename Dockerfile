FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y sudo

ENV DOCKER_USER bucky

RUN adduser --disabled-password --gecos '' "$DOCKER_USER"
RUN adduser "$DOCKER_USER" sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER "$DOCKER_USER"
WORKDIR "/home/$DOCKER_USER"
RUN touch ~/.sudo_as_admin_successful
RUN sudo ln -s /usr/share/zoneinfo/America/Chicago /etc/localtime
RUN sudo apt-get install -y build-essential curl git
RUN sudo apt-get install -y python3 python3-pip

# change if u don't live here ig lmao
# timezone is required for cmake
RUN sudo apt-get install -y cmake clang-format

RUN sudo apt-get install -y zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

RUN git clone https://github.com/google/googletest.git -b release-1.10.0 && \
    cd googletest && \
    mkdir build && \      
    cd build && \
    cmake .. && \
    make && \
    sudo make install

# Please change to your github otherwise I'd get too much credit ;)
RUN git config --global user.email "mkurzynski@wisc.edu" && \
    git config --global user.name "Marco Kurzynski"

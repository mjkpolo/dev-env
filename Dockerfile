FROM ubuntu

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
RUN sudo apt-get install -y build-essential curl git wget
RUN sudo apt-get install -y python3 python3-pip python-is-python3
RUN sudo apt-get install -y cmake clang-format 
RUN git clone https://github.com/badgerloop-software/pod-embedded
RUN ~/pod-embedded/deploy.sh cross-setup && ~/pod-embedded/deploy.sh gtest-setup
CMD cd ~/code && ./deploy.sh clean && ./deploy.sh build

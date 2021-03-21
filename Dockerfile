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
RUN sudo apt-get install -y build-essential curl git zsh wget
RUN sudo apt-get install -y python3 python3-pip python-is-python3
RUN sudo apt-get install -y cmake clang-format 
RUN sudo apt-get install -y libgtest-dev gcovr
RUN wget -c https://releases.linaro.org/components/toolchain/binaries/6.5-2018.12/arm-linux-gnueabihf/gcc-linaro-6.5.0-2018.12-x86_64_arm-linux-gnueabihf.tar.xz
RUN sudo tar xf gcc-linaro-6.5.0-2018.12-x86_64_arm-linux-gnueabihf.tar.xz -C /opt/
RUN rm gcc-linaro-6.5.0-2018.12-x86_64_arm-linux-gnueabihf.tar.xz
CMD cd ~/code && ./deploy.sh clean && ./deploy.sh build

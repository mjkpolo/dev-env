RUN apt-get update
RUN apt-get install -y sudo
ENV DOCKER_USER dev
RUN adduser --disabled-password --gecos '' "$DOCKER_USER"
RUN adduser "$DOCKER_USER" sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER "$DOCKER_USER"
WORKDIR "/home/$DOCKER_USER"
RUN touch ~/.sudo_as_admin_successful
# tools
RUN sudo apt-get install -y build-essential curl git openssh-client neovim zsh libgtest-dev bash-completion

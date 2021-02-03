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
RUN sudo apt-get install -y build-essential curl git wget neovim zsh
RUN sudo apt-get install -y nodejs npm openjdk-11-jdk exuberant-ctags

RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

RUN mkdir -p "$HOME/.config/nvim"
COPY ./init.vim /tmp/init.vim
RUN cat /tmp/init.vim > ~/.config/nvim/init.vim && \
    sudo rm /tmp/init.vim
RUN cat ~/.config/nvim/init.vim
RUN curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN nvim +PlugInstall +qall

# Please change to your github otherwise I'd get too much credit ;)
RUN git config --global user.email "mkurzynski@wisc.edu" && \
    git config --global user.name "Marco Kurzynski"

FROM ubuntu

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
RUN sudo apt-get install -y build-essential curl git neovim bash-completion libgtest-dev exuberant-ctags ccls
RUN sudo ln -s /usr/share/zoneinfo/America/Chicago /etc/localtime
RUN sudo apt-get install -y cmake

RUN git clone https://github.com/mjkpolo/dotfiles
RUN mkdir -p "$HOME/.config/nvim"
RUN ln -s ~/dotfiles/vimrc ~/.config/nvim/init.vim

RUN curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN nvim +PlugInstall +qall
RUN ln -s ~/dotfiles/coc-settings.json ~/.config/nvim/coc-settings.json

RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
ENV NVM_DIR /home/$DOCKER_USER/.nvm
RUN . "$NVM_DIR/nvm.sh" && \
	nvm install --lts && \
	nvm alias default stable
RUN git config --global user.email "mkurzynski@wisc.edu" && \
    git config --global user.name "Marco Kurzynski"

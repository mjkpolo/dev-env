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
RUN sudo apt-get install -y build-essential curl git neovim libgtest-dev exuberant-ctags ccls
RUN sudo apt-get install -y python3 python3-pip python-is-python3

# change if u don't live here ig lmao
# timezone is required for cmake
RUN sudo ln -s /usr/share/zoneinfo/America/Chicago /etc/localtime
RUN sudo apt-get install -y cmake clang-format

# if other dotfiles change instances of dotfiles to your folder name
# mine are pretty dece tho
RUN git clone https://github.com/mjkpolo/dotfiles
RUN mkdir -p "$HOME/.config/nvim"
RUN ln -s ~/dotfiles/vimrc ~/.config/nvim/init.vim
RUN curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN nvim +PlugInstall +qall

# dependent on my dotfiles so copy my coc-settings.json if changed
RUN ln -s ~/dotfiles/coc-settings.json ~/.config/nvim/coc-settings.json
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
ENV NVM_DIR /home/$DOCKER_USER/.nvm
RUN . "$NVM_DIR/nvm.sh" && \
	nvm install --lts && \
	nvm alias default stable

# Please change to your github otherwise I'd get too much credit ;)
RUN git config --global user.email "mkurzynski@wisc.edu" && \
    git config --global user.name "Marco Kurzynski"

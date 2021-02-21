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

# change if u don't live here ig lmao
# timezone is required for cmake
RUN sudo ln -s /usr/share/zoneinfo/America/Chicago /etc/localtime
RUN sudo apt-get install -y build-essential curl git neovim libgtest-dev exuberant-ctags ccls nodejs
RUN sudo apt-get install -y python3 python3-pip python-is-python3

RUN sudo apt-get install -y cmake clang-format wget

RUN sudo apt-get install -y zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# if other dotfiles change instances of dotfiles to your folder name
# mine are pretty dece tho
RUN mkdir -p "$HOME/.config/nvim"
COPY ./init.vim /tmp/init.vim
RUN cat /tmp/init.vim > ~/.config/nvim/init.vim && \
    sudo rm /tmp/init.vim
COPY ./coc-settings.json /tmp/coc-settings.json
RUN cat /tmp/coc-settings.json > ~/.config/nvim/coc-settings.json && \
    sudo rm /tmp/coc-settings.json

RUN curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN nvim +PlugInstall +qall

# Please change to your github otherwise I'd get too much credit ;)
RUN git config --global user.email "mkurzynski@wisc.edu" && \
    git config --global user.name "Marco Kurzynski"

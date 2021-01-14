# dev-env
---
>Made this for my fellow mac fanboys (don't be proud it's embarassing)
---
## Disclaimer
This is using my dotfiles from my github, so things may change (prolly just colorscheme), and for best practice you should change this to suit yourself <br/>
Yes, I know I could have a copy in this folder but that would be less interesting and I'm lazy
### Guide
- run `git clone https://github.com/mjkpolo/dev-env`
- run `cd dev-env`
- **you have to change the github info in the dockerfile otherwise it says I wrote everything you do**
- run `./build` and "ubuntu" is added to your bin/path
- run `ubuntu` in the folder you want to mount to docker
### Editing
type `nvim` to open the editor. use `;` in vim for a fuzzy finder, `ctrl-n` for nerdtree and `ctrl-b` for tagbar <br/>
for more, check my dotfiles and read the vimrc (which is actually linked to `.config/nvim/init.vim` in docker)

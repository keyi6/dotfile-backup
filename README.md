# README
This is my dofile backup, including vim configuration and zsh configuration.

## vim config
Use internal package manager(version >= 8.0 required).

```shell
# create dir for plugins
mkdir -p ~/.vim/pack/plugins/start

# airline plugin
git clone https://github.com/vim-airline/vim-airline ~/.vim/pack/dist/start/vim-airline
# supertab plugin
git clone --depth=1 https://github.com/ervandew/supertab.git ~/.vim/pack/plugins/start/supertab
```

See: [install powerline fonts](https://github.com/powerline/fonts)

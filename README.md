Personal vimrc and vim plugins.

# After a fresh clone

Run the following to pull down the submodules.

```shell
git submodule update --init
```

# Git repos of vim plugins

Create the diretory for the plugins to be stored
```shell
mkdir ~/.vim/pack/git-plugins/start
```

Add the submodules
```
cd ~/.vim/pack/git-plugins/start
git submodule add <URL of git repo to clone>
```

* https://github.com/dense-analysis/ale.git
* https://github.com/tpope/vim-fugitive.git


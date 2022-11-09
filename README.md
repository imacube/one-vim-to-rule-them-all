Personal vimrc and vim plugins.

To create first make sure the `~/.vimrc` file is not present (rename or delete it).

If there is a `.vim` directory back it up.

```
git clone https://github.com/imacube/one-vim-to-rule-them-all.git ~/.vim
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

# vim: tabstop=4 shiftwidth=4 expandtab

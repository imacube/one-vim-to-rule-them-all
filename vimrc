"
" Adapted from $VIMRUNTIME/vimrc_example.vim
"

set nocompatible

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

set history=200		" keep 200 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set ttimeout		" time out for key codes
set ttimeoutlen=100	" wait up to 100ms after Esc for special key
set display=truncate	" Show @@@ in the last line if it is truncated.
set scrolloff=10	" Minimum number of lines above and below the cursor

" Terminal configuration
set termwinsize=12x0
set splitbelow
set mouse=a

" vim menu activation and configuration
source $VIMRUNTIME/menu.vim
set wildmenu		" display completion matches in a status line
set wildmode=full	" Complete next full match using the original string
set cpo-=<		"
set wildcharm=<C-Z>	" Works like wildchar but is recognized inside a macro
" Activate emenu, a console menu
map <F4> :emenu <C-Z>

" modelines
set modeline
set modelines=5

" Do not recognize octal numbers for Ctrl-A and Ctrl-X, most users find it
" confusing.
set nrformats-=octal

" Don't use Ex mode, use Q for formatting.
" Revert with ":unmap Q".
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
" Revert with ":iunmap <C-U>".
inoremap <C-U> <C-G>u<C-U>

syntax on		" Syntax highlighting on
let c_comment_strings=1	" Highlighting strings inside C comments

" Only do this part when Vim was compiled with the +eval feature.
if 1

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  " Revert with ":filetype off".
  filetype plugin indent on

  " Put these in an autocmd group, so that you can revert them with:
  " ":augroup vimStartup | au! | augroup END"
  augroup vimStartup
    au!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid, when inside an event handler
    " (happens when dropping a file on gvim) and for a commit message (it's
    " likely a different one than last time).
    autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif

  augroup END

endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If set (default), this may break plugins (but it's backward
  " compatible).
  set nolangremap
endif


" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

" Configure backup, undo and swap
set nobackup
set nowritebackup
set undofile	" keep an undo file (undo changes after closing)
let vimDir='$HOME/.vim'
let mySwapDir=expand(vimDir . '/swap')
let myUndoDir=expand(vimDir . '/undo')
call system('mkdir ' . vimDir)
call system('mkdir ' . mySwapDir)
call system('mkdir ' . myUndoDir)
let &undodir=myUndoDir
let &directory=mySwapDir

" Search settings
set hlsearch
set incsearch
nnoremap <F2> :nohlsearch<CR>
nnoremap <F8> :qall<CR>

" Code work
nnoremap <F5> :make test<CR>
nnoremap <F4> :close<CR>

set number	" Show line numbers

" Vexplore options
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
augroup ProjectDrawer
  autocmd!
  autocmd VimEnter * if eval("@%") == "" | :Vexplore | endif
augroup END
set statusline=%<%f\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P
nnoremap <F12> :Vexplore<CR>

" BEGIN ALE
" Specific to ALE
" Put these lines at the very end of your vimrc file.

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
" END ALE

" If a local .vimrc file exists, source it last
if filereadable('.vimrc')
	source .vimrc
endif


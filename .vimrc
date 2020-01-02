" .vimrc
" Author: Franzwagner Ternus <franzwagner.str@gmail.com>
" Source: https://github.com/strund3r/dotfiles

" ----------------------------------------- "
"             General  Settings             "
" ----------------------------------------- "
syntax enable	" enable syntax processing
set number	" Show line numbers
set showcmd	" show command in bottom bar
set noshowcmd " Display incomplete commands.
set cursorline	" highlight current line
set linebreak	" Break lines at word (requires Wrap lines)
set showbreak=+++ 	" Wrap-broken line prefix
set textwidth=100	" Line wrap (number of cols)
set showmatch	" Highlight matching brace
"set spell	" Enable spell-checking
set spelllang=en_us
set errorbells	" Beep or flash screen on errors
"set visualbell	" Use visual bell (no beeping)
set title	" Set the window’s title, reflecting the file currently being edited.
set encoding=utf-8

set hlsearch	" Highlight all search results
set smartcase	" Enable smart-case search
set ignorecase	" Always case-insensitive
set incsearch	" Searches for strings incrementally

set autoindent	" Auto-indent new lines
set shiftwidth=4	" Number of auto-indent spaces
set smartindent	" Enable smart-indent
set smarttab	" Enable smart-tabs
set tabstop=4	" number of visual spaces per TAB
set softtabstop=4	" number of spaces in tab when editing

set showmode " Display the mode you're in.
set wildmode=list:longest " Complete files like a shell.
set nowrap " Turn off line wrapping.

" Advanced
set ruler	" Show row and column ruler information
set cmdheight=2	" Command line height
 
set undolevels=1000	" Number of undo levels
set backspace=indent,eol,start	" Backspace behaviour
set wildmenu	" visual autocomplete for command menu

" Change the cursor at insert mode
let &t_ti.="\<Esc>[1 q"
let &t_SI.="\<Esc>[5 q"
let &t_EI.="\<Esc>[1 q"
let &t_te.="\<Esc>[0 q"

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" If linux then set ttymouse
let s:uname = system("echo -n \"$(uname)\"")
if !v:shell_error && s:uname == "Linux" && !has('nvim')
  set ttymouse=xterm
endif

" ----------------------------------------- "
"            File  Type  Settings           "
" ----------------------------------------- "

au BufNewFile,BufRead *.vim setlocal noet ts=4 sw=4 sts=4
au BufNewFile,BufRead *.txt setlocal noet ts=4 sw=4
au BufNewFile,BufRead *.md setlocal spell noet ts=4 sw=4
au BufNewFile,BufRead *.yml,*.yaml setlocal expandtab ts=2 sw=2
au BufNewFile,BufRead *.cpp setlocal expandtab ts=2 sw=2
au BufNewFile,BufRead *.json setlocal expandtab ts=2 sw=2

augroup filetypedetect
  au BufNewFile,BufRead .tmux.conf*,tmux.conf* setf tmux
  au BufNewFile,BufRead .nginx.conf*,nginx.conf* setf nginx
augroup END

au FileType nginx setlocal noet ts=4 sw=4 sts=4

" Go settings
au BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4
" autocmd BufEnter *.go colorscheme nofrils-dark

" Markdown Settings
autocmd BufRead,BufNewFile *.md,*.markdown set filetype=ghmarkdown

" Dockerfile settings
autocmd BufRead,BufNewFile Dockerfile* set filetype=dockerfile
autocmd BufRead,BufNewFile Rockerfile* set filetype=dockerfile

" Terraform settings
autocmd FileType terraform set shiftwidth=2
autocmd FileType terraform set tabstop=2
autocmd FileType terraform set expandtab

" Puppet settings
autocmd BufRead,BufNewFile *.pp set filetype=puppet
autocmd BufRead,BufNewFile Puppetfile set filetype=ruby
autocmd FileType puppet set shiftwidth=2
autocmd FileType puppet set tabstop=2

" shell/config/systemd settings
autocmd FileType fstab,systemd set noexpandtab
autocmd FileType gitconfig,sh,toml set noexpandtab

" python indent
autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4 textwidth=80 smarttab expandtab

" toml settings
au BufRead,BufNewFile MAINTAINERS set ft=toml

" mips settings
au BufRead,BufNewFile *.mips set ft=mips

" spell check for git commits
autocmd FileType gitcommit setlocal spell

" Open NERDTree automatically when vim starts up
autocmd vimenter * NERDTree

" Open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Open NERDTree automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" ------------------------------------------ "
"                  Mappings                  "
" ------------------------------------------ "

" Tabs
nnoremap <space>t :tabnew<cr>
nnoremap <space>e :tabedit
nnoremap <space>n :tabnext<cr>
nnoremap <space>p :tabprevious<cr>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Open NERDTree
map <F6> :NERDTreeToggle<CR>

" Fugitive
nnoremap <space>gd :Gdiff<cr>
nnoremap <space>gs :Gstatus<cr>
nnoremap <space>gw :Gwrite<cr>
nnoremap <space>ga :Gadd<cr>
nnoremap <space>gb :Gblame<cr>
nnoremap <space>gci :Gcommit<cr>
nnoremap <space>ge :Gedit<cr>
nnoremap <space>gm :Gmove
nnoremap <space>gr :Gread<cr>
nnoremap <space>grm :Gremove<cr>
nnoremap <space>gp :Git push

" Airline
let g:airline_powerline_fonts = 1

" Terraform
let g:terraform_fmt_on_save = 1

" ----------------------------------------- "
"                  Plugins                  "
" ----------------------------------------- "

" Install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Directory for plugins
call plug#begin('~/.vim/plugged')

" easy-align
Plug 'junegunn/vim-easy-align'

" Dash (Docs)
Plug 'rizzatti/dash.vim'

" fugitive.vim
Plug 'tpope/vim-fugitive'

" vim-surround
Plug 'tpope/vim-surround'

" NERDTree
Plug 'scrooloose/nerdtree'

" vim-gitgutter
Plug 'airblade/vim-gitgutter'

" vim-airline
Plug 'vim-airline/vim-airline'

" autocomplete
"Plug 'valloric/youcompleteme'

" Indent Guide
Plug 'nathanaelkane/vim-indent-guides'

" Start Screen
"Plug 'mhinz/vim-startify'

" Puppet
Plug 'rodjek/vim-puppet'

" Terraform
Plug 'hashivim/vim-terraform'

" Packer
Plug 'hashivim/vim-packer'

" Consul
Plug 'hashivim/vim-consul'

" Vault
Plug 'hashivim/vim-vaultproject'

" Docker
Plug 'ekalinin/Dockerfile.vim'

" Initialize plugin system
call plug#end()

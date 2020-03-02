" Automatic installation of VIM Plugin
" Reference: https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Install VIM plugins
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Visual file structure management with NerdTree
" Reference: https://github.com/preservim/nerdtree
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Git
Plug 'vim-scripts/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" NerdTree and Git
Plug 'xuyuanp/nerdtree-git-plugin'

" Base16 color scheme
" Reference Base16 shell: https://github.com/chriskempson/base16-shell#base16-vim-users
" Reference Base16 VIM: https://github.com/chriskempson/base16-vim
Plug 'chriskempson/base16-vim'

" End initialization of the plugin system
call plug#end()

""" Leader key configuration
:let mapleader = " "
:let maplocalleader = "\\"

""" General Tab mappings
:map  <C-l> :tabn<CR>
:map  <C-h> :tabp<CR>
:map  <C-n> :tabnew<CR>

""" NerdTree configuration

let g:NERDTreeWinSize=50
let g:NERDTreeShowHidden=1

" Key map leader key to 
:nnoremap <leader>n :NERDTreeToggle<CR>

" Control P Fuzzy Finder mappings
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

""" End of NerdTree configuration

""" GitGutter configuration
" Remember <leader>h_ for GitGutter
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gf :Git! diff --name-only master<CR>
nnoremap <leader>gg :copen<CR>:Ggrep
nnoremap <leader>gh :Gdiff origin/HEAD<CR>
nnoremap <leader>gm :Gdiff master<CR>
nnoremap <leader>go :Gdiff origin<CR>
nnoremap <leader>gs :Gstatus<CR>

""" End of GitGutter configuration

""" Base16 configuration

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

""" End of Base16 configuration
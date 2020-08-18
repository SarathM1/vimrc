" Specify a directory for plugins
call plug#begin('~/.vim/plugins')

Plug 'tpope/vim-fugitive'
Plug 'jreybert/vimagit'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
" Plug 'neomake/neomake'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-surround'
Plug 'tomtom/tcomment_vim'
" FZF
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mhartington/oceanic-next'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'honza/vim-snippets'
Plug 'scrooloose/syntastic'
Plug 'davidhalter/jedi-vim'
" Plug 'sbdchd/neoformat'

" Initialize plugin system.
call plug#end()

" Neovim Settings
set termguicolors
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
if system('uname -s') == "Darwin\n"
  set clipboard=unnamed "OSX
else
  set clipboard=unnamedplus "Linux
endif
set pastetoggle=<f2>
set nopaste


" Cursor shape in different modes
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
:autocmd InsertEnter * set cul
:autocmd InsertLeave * set nocul

" To auto-remove trailing white spaces on save
autocmd BufWritePre * %s/\s\+$//e
set noshowmode
set noswapfile
filetype on
set cursorline
set  number
set relativenumber
set numberwidth=1

" indentation settings
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

" Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase

set conceallevel=0
set virtualedit=
set wildmenu
set laststatus=2
set wrap linebreak nolist
set wildmode=full
set autoread
" leader is ,
let mapleader = ','
set undofile
set undodir="$HOME/.VIM_UNDO_FILES"
" Remember cursor position between vim sessions
autocmd BufReadPost *
            \ if line("'\"") > 0 && line ("'\"") <= line("$") |
            \   exe "normal! g'\"" |
            \ endif
" center buffer around cursor when opening files
autocmd BufRead * normal zz
" set updatetime=500
set complete=.,w,b,u,t,k
autocmd InsertEnter * let save_cwd = getcwd() | set autochdir
autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)
set formatoptions+=t
" set inccommand=nosplit
set shortmess=atIc
set isfname-==
set spell

" }}}

" System mappings  ----------------------------------------------------------{{{

" No need for ex mode
nnoremap Q <nop>
" exit insert, dd line, enter insert
inoremap <c-d> <esc>ddi

" File path completion 'ctr f'
inoremap <c-f> <c-x><c-f>

" Align blocks of text and keep them selected
vmap < <gv
vmap > >gv
vnoremap <c-/> :TComment<cr>
"}}}"

" Themes, Commands, etc  ----------------------------------------------------{{{
" syntax on
" colorscheme slate
" Or if you have Neovim >= 0.1.5
if (has("termguicolors"))
    set termguicolors
endif

" Theme
syntax enable
colorscheme OceanicNext

" Disable annoying red highlights
set nospell
"}}}

" MarkDown ------------------------------------------------------------------{{{

noremap <leader>TM :TableModeToggle<CR>
let g:table_mode_corner="|"

" let g:neomake_markdown_proselint_maker = {
"             \ 'errorformat': '%W%f:%l:%c: %m',
"             \ 'postprocess': function('neomake#postprocess#GenericLengthPostprocess'),
"             \}
" let g:neomake_markdown_enabled_makers = ['alex', 'proselint']
"
"}}}

" Python --------------------------------------------------------------------{{{

" let g:python_host_prog = '/usr/local/bin/python2'
" let g:python3_host_prog = '/usr/bin/python3'
" " let $NVIM_PYTHON_LOG_FILE='nvim-python.log'
let g:jedi#auto_vim_configuration = 0
" To disable docstring popup
autocmd FileType python setlocal completeopt-=preview
" }}}


" Git -----------------------------------------------------------------------{{{
set signcolumn=yes
" }}}

" NERDTree ------------------------------------------------------------------{{{

let g:vimfiler_ignore_pattern = ""
" map <silent> - :VimFiler<CR>
let g:vimfiler_tree_leaf_icon = ''
let g:vimfiler_tree_opened_icon = ''
let g:vimfiler_tree_closed_icon = ''
let g:vimfiler_file_icon = ''
let g:vimfiler_marked_file_icon = '*'
let g:vimfiler_expand_jump_to_first_child = 0
" let g:vimfiler_as_default_explorer = 1
augroup vfinit
    autocmd FileType vimfiler call s:vimfilerinit()
augroup END
function! s:vimfilerinit()
    set nonumber
    set norelativenumber
    nmap <silent><buffer><expr> <CR> vimfiler#smart_cursor_map(
                \ "\<Plug>(vimfiler_expand_tree)",
                \ "\<Plug>(vimfiler_edit_file)"
                \)
    nmap <silent> m :call NerdUnite()<cr>
    nmap <silent> r <Plug>(vimfiler_redraw_screen)
endf
" let g:vimfiler_ignore_pattern = '^\%(\.git\|\.DS_Store\)$'
let g:webdevicons_enable_vimfiler = 0
let g:vimfiler_no_default_key_mappings=1
function! NerdUnite() abort "{{{
    let marked_files =  vimfiler#get_file(b:vimfiler)
    call unite#start(['nerd'], {'file': marked_files})
endfunction "}}}

map <silent> - :NERDTreeToggle<CR>
augroup ntinit
    autocmd FileType nerdtree call s:nerdtreeinit()
augroup END
function! s:nerdtreeinit()
    nunmap <buffer> K
    nunmap <buffer> J
endf
let NERDTreeShowHidden=1
let NERDTreeHijackNetrw=0
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:NERDTreeWinSize=45
let g:NERDTreeAutoDeleteBuffer=1
let g:WebDevIconsOS = 'Darwin'
let NERDTreeMinimalUI=1
let NERDTreeCascadeSingleChildDir=1
let g:NERDTreeHeader = 'hello'


" let g:webdevicons_conceal_nerdtree_brackets = 0
" let g:WebDevIconsNerdTreeAfterGlyphPadding = ''
" 
let g:NERDTreeShowIgnoredStatus = 0
" let g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol = 1
" let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = ''
" To solve a bug; https://github.com/scrooloose/nerdtree/issues/911
let g:NERDTreeNodeDelimiter = "\u00a0"
"}}}

" Vim-Devicons -------------------------------------------------------------0{{{

let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {} " needed
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['js'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['vim'] = ''

" }}}

" Code formatting -----------------------------------------------------------{{{

" ,f to format code, requires formatters: read the docs
" noremap <silent> <leader>f :Neoformat<CR>

" augroup fmt
"     autocmd!
"     autocmd BufWritePre * undojoin | Neoformat
" augroup END

" }}}

" vim-airline ---------------------------------------------------------------{{{

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#mike#enabled = 0
set hidden
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline_powerline_fonts = 1
" let g:airline#extensions#neomake#error_symbol='• '
" let g:airline#extensions#neomake#warning_symbol='•  '
let g:airline_symbols.branch = ''
let g:airline_theme='oceanicnext'
cnoreabbrev <silent> <expr> x getcmdtype() == ":" && getcmdline() == 'x' ? 'Sayonara' : 'x'
tmap <leader>x <c-\><c-n>:bp! <BAR> bd! #<CR>
nmap <leader>t :term<cr>
nmap <leader>, :bnext<CR>
tmap <leader>, <C-\><C-n>:bnext<cr>
nmap <leader>. :bprevious<CR>
tmap <leader>. <C-\><C-n>:bprevious<CR>
tmap <leader>1  <C-\><C-n><Plug>AirlineSelectTab1
tmap <leader>2  <C-\><C-n><Plug>AirlineSelectTab2
tmap <leader>3  <C-\><C-n><Plug>AirlineSelectTab3
tmap <leader>4  <C-\><C-n><Plug>AirlineSelectTab4
tmap <leader>5  <C-\><C-n><Plug>AirlineSelectTab5
tmap <leader>6  <C-\><C-n><Plug>AirlineSelectTab6
tmap <leader>7  <C-\><C-n><Plug>AirlineSelectTab7
tmap <leader>8  <C-\><C-n><Plug>AirlineSelectTab8
tmap <leader>9  <C-\><C-n><Plug>AirlineSelectTab9
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
let g:airline#extensions#tabline#buffer_idx_format = {
            \ '0': '0 ',
            \ '1': '1 ',
            \ '2': '2 ',
            \ '3': '3 ',
            \ '4': '4 ',
            \ '5': '5 ',
            \ '6': '6 ',
            \ '7': '7 ',
            \ '8': '8 ',
            \ '9': '9 ',
            \}

"}}}

" Linting -------------------------------------------------------------------{{{

" autocmd! BufWritePost * Neomake
" let g:neomake_warning_sign = {'text': '•'}
" let g:neomake_error_sign = {'text': '•'}

"}}}

" FZF -------------------------------------------------------------------{{{

nnoremap <c-p> :Files<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>l :Lines<CR>
nnoremap <Leader>bl :BLines<CR>
"}}}

" Split  Windows -------------------------------------------------------------------{{{
nmap sh :split<Return><C-w>w
nmap sv :vsplit<Return><C-w>w
"}}}

" Bind nohl
" Removes highlight of your last search
" ``<C>`` stands for ``CTRL`` and therefore ``<C-n>`` stands for ``CTRL+n``
noremap <C-n> :nohl<CR>
vnoremap <C-n> :nohl<CR>
inoremap <C-n> :nohl<CR>

" Save file using Ctrs-------------------------------------------------------------------{{{
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

"}}}

" Inset header files automatically-------------------------------------------------------------------{{{
" Reference: https://www.thegeekstuff.com/2008/12/vi-and-vim-autocommand-3-steps-to-add-custom-header-to-your-file/
autocmd bufnewfile *.c so $HOME/vim_templates/c_header.txt
autocmd bufnewfile *.c exe "1," . 10 . "g/File Name:.*/s//File Name: " .expand("%")
autocmd bufnewfile *.c exe "1," . 10 . "g/Date:.*/s//Date: " .strftime("%d-%m-%Y")
autocmd Bufwritepre,filewritepre *.c execute "normal ma"
autocmd Bufwritepre,filewritepre *.c exe "1," . 10 . "g/Last Modified:.*/s/Last Modified:.*/Last Modified: " .strftime("%c")
autocmd bufwritepost,filewritepost *.c execute "normal `a"
"}}}


" fileType-------------------------------------------------------------------{{{
" Not detected automatically by vim
autocmd BufNewFile,BufRead *.launch set syntax=xml filetype=xml
autocmd BufNewFile,BufRead *.conf.local set syntax=tmux
autocmd BufRead,BufNewFile *.yml set expandtab shiftwidth=2
"}}}

" deoplete-------------------------------------------------------------------{{{
let g:deoplete#enable_at_startup = 1
" It is recommended to set up a serperate python environment for neovim
" in both python2 and python3 to avoid reinstalling neovim python package

" Use miniconda3 or anaconda3
if isdirectory(expand('~/miniconda3/envs/vim_env3/bin/'))
    let g:python3_host_prog = expand('~/miniconda3/envs/vim_env3/bin/python')
endif
if isdirectory(expand('~/miniconda3/envs/vim_env2/bin/'))
    let g:python_host_prog = expand('~/miniconda3/envs/vim_env2/bin/python')
endif

if isdirectory(expand('~/anaconda3/envs/vim_env3/bin/'))
    let g:python3_host_prog = expand('~/anaconda3/envs/vim_env3/bin/python')
endif
if isdirectory(expand('~/anaconda3/envs/vim_env2/bin/'))
    let g:python_host_prog = expand('~/anaconda3/envs/vim_env2/bin/python')
endif
" }}}

"Syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
let g:syntastic_python_checkers=['flake8']
let g:syntastic_python_flake8_args='--ignore=C0116,C0115'

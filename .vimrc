" These are my VIM settings

set nocompatible " Don't try to be vi compatible
let mapleader = "," " change mapleader from \ to ,
set mouse=a " turn the mouse on
set hidden "hides buffer instead of closing them
syntax on " color syntax
set number " line numbers
"set conceallevel=3
set nomodeline " turn modelines off for security reasons
"set ruler " show file stats
set visualbell " blink cursor instead of a beep
set noerrorbells " don't beep
" have these turned off because I'm using lightline
"set showcmd " show (partial) command in the last line of the screen
set noshowmode " shows current mode
set title " change the terminal's title
set encoding=UTF-8 " Encoding
set nowrap " won't wrap the text
set formatoptions=tqn1 " see :h fo-table
set tabstop=4 " tab are 4 spaces
set shiftwidth=4 " indent with > and < by 4 spaces
"set softtabstop=4 " not really sure???
set smarttab " insert tabs on the shiftwidth, not tabstop
set expandtab " makes tabs spaces
set autoread " automatically reload files changed outside of Vim
set ttyfast " makes keyboard commands faster
set nobackup " don't use these
set noswapfile " these are annoying and I wouldn't know what to do anyway
set autochdir " this changes the current working directory automatically
set autoindent " auto indenting on
set copyindent " copy the previous indentation on autoindent
set showmatch " set show matching parens
set ignorecase " ignore case when searching
set smartcase " only ignore case if search is all lowercase
set hlsearch " highlight search results
set incsearch " show search matches as you type
set gdefault " you omit g in find+replace (:%s/foo/bar)
set laststatus=2 " always show status line
set showtabline=2 " always show the tab line
set scrolloff=3 " keep 3 lines above and below cursor when scrolling
set backspace=indent,eol,start " make backspace work like most other programs
set listchars=tab:>.,trail:.,extends:#,nbsp:.
set list " shows hidden characters
set matchpairs+=<:> " set match pairs use % to jump between pairs

" git mergetool
nmap <leader>dl :diffget LOCAL<CR>
nmap <leader>db :diffget BASE<CR>
nmap <leader>dr :diffget REMOTE<CR>

" Vim Plug installation and plugin management settings
" PlugInstall: install plugins
" PlugUpdate: updates plugins
" PlugUpgrade: updates vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
"Plug 'ycm-core/YouCompleteMe', { 'do': 'python3 install.py --all' }
Plug 'dense-analysis/ale'
Plug 'mattn/emmet-vim'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'morhetz/gruvbox'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'jparise/vim-graphql'
Plug 'preservim/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'ap/vim-css-color'
Plug 'ryanoasis/vim-devicons'
"Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'sheerun/vim-polyglot'
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'terryma/vim-multiple-cursors'
Plug 'mitsuhiko/vim-jinja'
"Plug 'Glench/Vim-Jinja2-Syntax'
"Plug 'pangloss/vim-javascript'
call plug#end()

" disable django files
"let g:polyglot_disabled = ['jinja']

autocmd filetype text,markdown,pullrequest set wrap

" this will clear the highlighted searches
nmap <silent> <leader>/ :nohlsearch<CR>

" instead of jumping over wrapped lines, jumps to next row
nnoremap j gj
nnoremap k gk

" create a vertical split and switch over to it
nnoremap <leader>vv <C-w>v<C-w>l
" go to next window
nnoremap <leader><Tab> <C-w>w
"noremap <C-j> <C-w>j
"noremap <C-k> <C-w>k
"noremap <C-l> <C-w>l
"noremap <C-h> <C-w>h

" Move lines up and down
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

" easy way to get out of insert mode
inoremap jj <Esc>

" select all, copy, and paste
nnoremap <leader>a gg<S-v>G
vnoremap <leader>c "*y<CR>
vnoremap <leader>p "*p<CR>

" save
nmap <leader>s :w<CR>

" save all and quit
nmap <leader>q :wqa<CR>

" visual block mode
nnoremap <leader>v <C-v>

" find and replace
nnoremap <leader>r *:%s//

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" terminal emulation
nnoremap <silent> <leader>sh :terminal<CR>

" ALE settings
let g:ale_fixers = {
\   'javascript': ['prettier', 'eslint'],
\   'typescriptreact': ['prettier', 'eslint'],
\   'html': ['prettier'],
\   'json': ['prettier'],
\   'css': ['prettier'],
\   'yml': ['prettier'],
\   'markdown': ['prettier'],
\   'python': ['black', 'isort'],
\   'sh': ['shfmt'],
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\}

let g:ale_enabled = 1
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 0
let g:ale_linters_explicit = 0 " only use linters I've defined here
let g:ale_echo_msg_format = '%linter%: %s'
let g:ale_lint_on_text_changed = 'always'  " never/insert/normal/always
"let g:ale_sign_error = '❌'
"let g:ale_sign_warning = '⚠️'

" Vim Markdown Preview Settings
let vim_markdown_preview_toggle=0 " previews on <C-p>, set to 3 for auto on sove
"let vim_markdown_preview_browser='Google Chrome'
let vim_markdown_preview_temp_file=1
"let vim_markdown_preview_github= 1
let vim_markdown_preview_pandoc=1
nmap <leader>md <C-p>


" fzf
set rtp+=/usr/local/opt/fzf
nnoremap ; :Files<CR>
nnoremap <leader>f :Rg<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>h :History<CR>

" gruvbox color scheme
let g:gruvbox_vert_split='bg1'
let g:gruvbox_sign_column='bg0'
let g:gruvbox_italic=1
colorscheme gruvbox
set background=dark
" vim incorrectly detects italics escape codes from terminfo.
" TODO: Look for fix
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

" vim-eunuch mappings
"nnoremap <leader>mv :Rename
"nnoremap <leader>sw :SudoWrite
"nnoremap <leader>mk :Mkdir

" NERDTree settings
nnoremap <leader>t :NERDTreeToggle<CR>
let g:NERDTreeMouseMode=3
let g:NERDTreeShowHidden=1
let g:NERDTreeMinimalUI = 0
let g:NERDTreeDirArrows = 1
let g:NERDTreeWinSize = 50

" emmet settings
map <leader>em <C-y>,

" lightline w/lightline-bufferline and gitbranch integration
let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'active': {
    \   'left': [ ['mode', 'paste'],
    \           ['gitbranch', 'readonly', 'filename', 'modified'], ],
    \ },
    \ 'tabline': {
    \   'left': [ [ 'buffers' ] ],
    \   'right': [ [ 'close' ], ],
    \ },
    \ 'component_expand': {
    \   'buffers': 'lightline#bufferline#buffers',
    \ },
    \ 'component_type': {
    \   'buffers': 'tabsel',
    \ },
    \ 'component_function': {
    \   'filetype': 'MyFiletype',
    \   'fileformat': 'MyFileformat',
    \   'gitbranch': 'gitbranch#name',
    \ },
    \ 'component': {
    \   'separator': '',
    \ }}

" lightline-bufferline
let g:lightline#bufferline#unnamed = '[No Name]'
let g:lightline#bufferline#shorten_path = 1
let g:lightline#bufferline#enable_devicons = 0

function! MyFiletype()
	return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
	return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

" buffer shortcuts
nnoremap <Left> :bp<CR>
nnoremap <Right> :bn<CR>
nnoremap <leader>w :bp<CR>:bd #<CR>

" terryma/vim-multiple-cursors
let g:multi_cursor_start_key='<C-m>'
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-m>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'
let g:multi_cursor_exit_from_visual_mode=1
let g:multi_cursor_exit_from_insert_mode=1

" delimitMate
let g:loaded_delimitMate = 1
let g:delimitMate_expand_cr = 1

" web devicons
let g:webdevicons_enable = 1
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1

" vim-fugitive
nmap <leader>gb :Gblame<CR>
nmap <leader>gv :GBrowse<CR>

" prose mode
function! ProseMode()
  call goyo#execute(0, [])
  set spell noci nosi noai nolist noshowmode noshowcmd
  set complete+=s
  set bg=light
  "if !has('gui_running')
    "let g:solarized_termcolors=256
  "endif
endfunction

command! ProseMode call ProseMode()
nmap <Leader>p :ProseMode<CR>

"TODO: add EditorConfig plugin if want to sync various code style prefs across
"editors

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL

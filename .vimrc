" Modern Vim Configuration - Enhanced with Language Support and NvChad-like Features
" Authors: EuclidaeZ, NvChad-inspired
" Version: 2025.07
" Compatible with Vim 8.0+

" ==================================================
" BASIC SETTINGS
" ==================================================
set nocompatible
filetype plugin indent on
syntax enable

" Encoding
set encoding=utf-8
set fileencoding=utf-8

" Editor behavior
set number relativenumber
set mouse=a
set wildmenu
set wildmode=longest:full,full
set hlsearch incsearch ignorecase smartcase
set autoindent smartindent
set tabstop=2 shiftwidth=2 expandtab smarttab
set showcmd showmatch scrolloff=8 sidescrolloff=8 wrap linebreak
set splitbelow splitright
set clipboard=unnamedplus
set nobackup nowritebackup noswapfile
set updatetime=100
set noshowmode cmdheight=1 signcolumn=yes

" Persistent undo
if has('persistent_undo')
  set undofile
  set undodir=~/.vim/undodir
  if !isdirectory(&undodir)
    call mkdir(&undodir, 'p')
  endif
endif

" True color support
if has('termguicolors')
  set termguicolors
endif

" ==================================================
" PLUGIN MANAGEMENT (vim-plug)
" ==================================================
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Core functionality
Plug 'neoclide/coc.nvim', {'branch': 'release'}  " LSP support
Plug 'puremourning/vimspector'                  " Debugging
Plug 'preservim/nerdtree'                       " File explorer
Plug 'Xuyuanp/nerdtree-git-plugin'             " NERDTree git integration
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'                         " Fuzzy finder
Plug 'voldikss/vim-floaterm'                    " Terminal integration
Plug 'tpope/vim-fugitive'                      " Git integration
Plug 'airblade/vim-gitgutter'                  " Git gutter
Plug 'tpope/vim-commentary'                    " Comments
Plug 'tpope/vim-surround'                      " Surround
Plug 'jiangmiao/auto-pairs'                    " Auto pairs
Plug 'easymotion/vim-easymotion'               " Better motions
Plug 'mg979/vim-visual-multi'                  " Multiple cursors
Plug 'mhinz/vim-startify'                      " Startup screen
Plug 'ntpeters/vim-better-whitespace'          " Whitespace handling
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" Language support
Plug 'rust-lang/rust.vim'                       " Rust
Plug 'saecki/crates.nvim', {'do': '!cargo build --release'} " Cargo.toml
Plug 'p00f/clangd_extensions.nvim'              " C++ enhancements
Plug 'cdelledonne/vim-cmake'                    " CMake support
Plug 'ziglang/zig.vim'                          " Zig support
Plug 'bfrg/vim-cpp-modern'                     " Modern C++ syntax
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } } " Browser
Plug 'tikhomirov/vim-glsl'                     " GLSL support
Plug 'uiiaoo/java-syntax.vim'                  " Java syntax
Plug 'sheerun/vim-polyglot'                    " Additional syntax highlighting

" UI enhancements
Plug 'joshdick/onedark.vim'                    " Color scheme
Plug 'vim-airline/vim-airline'                 " Status line
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'                  " Icons
Plug 'Yggdroot/indentLine'                     " Indentation guides
Plug 'dense-analysis/ale'                      " Linting

call plug#end()

" ==================================================
" THEME AND UI
" ==================================================
colorscheme onedark
let g:airline_theme = 'onedark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_powerline_fonts = 1
let g:indentLine_enabled = 1
let g:indentLine_char = '▏'
let g:indentLine_color_gui = '#3B4048'

" Optional transparent background
" hi Normal guibg=NONE ctermbg=NONE
" hi LineNr guibg=NONE ctermbg=NONE
" hi SignColumn guibg=NONE ctermbg=NONE

" ==================================================
" PLUGIN CONFIGURATIONS
" ==================================================

" NERDTree
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = ['^\.DS_Store$', '^tags$', '\.git$[[dir]]', '\.idea$[[dir]]', 'node_modules', '__pycache__', '\.sass-cache$']
let g:NERDTreeStatusline = ''
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" FZF
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}

" Floaterm
let g:floaterm_width = 0.9
let g:floaterm_height = 0.9
let g:floaterm_keymap_toggle = '<leader>tt'

" GitGutter
let g:gitgutter_enabled = 1
let g:gitgutter_map_keys = 0

" vimspector
let g:vimspector_enable_mappings = 'HUMAN'
let g:vimspector_install_gadgets = [
  \ 'vscode-cpptools',
  \ 'CodeLLDB',
  \ 'vscode-java-debug',
  \ 'debugpy'
  \]

" crates.nvim
let g:crates_config = {
  \ 'show_popup': 'on_hold',
  \ 'popup_delay': 300,
  \ }

" Startify
let g:startify_session_dir = '~/.vim/sessions'
let g:startify_lists = [
  \ { 'type': 'sessions',  'header': ['   Sessions'] },
  \ { 'type': 'files',     'header': ['   Recent Files'] },
  \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
  \ { 'type': 'bookmarks', 'header': ['   Bookmarks'] },
  \ ]

" CoC
let g:coc_global_extensions = [
  \ 'coc-rust-analyzer',
  \ 'coc-clangd',
  \ 'coc-pyright',
  \ 'coc-java',
  \ 'coc-zig',
  \ 'coc-glsl',
  \ 'coc-json',
  \ 'coc-tsserver',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-go',
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-prettier'
  \]

" CoC completion
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <c-space> coc#refresh()

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

" CoC key mappings
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>ca <Plug>(coc-codeaction)
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" ALE (Linting)
let g:ale_linters = {
  \ 'python': ['flake8', 'pylint'],
  \ 'javascript': ['eslint'],
  \ 'rust': ['analyzer'],
  \ 'cpp': ['clangd'],
  \ }
let g:ale_fixers = {
  \ '*': ['remove_trailing_lines', 'trim_whitespace'],
  \ 'javascript': ['prettier', 'eslint'],
  \ 'python': ['black', 'isort'],
  \ }

" ==================================================
" KEY MAPPINGS
" ==================================================
let mapleader = " "
let maplocalleader = " "

" Core functionality
nnoremap ; :<CR>
inoremap jk <Esc>
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>x :x<CR>
nnoremap <leader>e :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>

" Fuzzy finder
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :Rg<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fh :History<CR>

" Buffer and tab navigation
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprev<CR>
nnoremap <leader>bd :bdelete<CR>
nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>tc :tabclose<CR>
nnoremap <leader>to :tabonly<CR>

" Window navigation and resizing
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-Up> :resize +2<CR>
nnoremap <C-Down> :resize -2<CR>
nnoremap <C-Left> :vertical resize -2<CR>
nnoremap <C-Right> :vertical resize +2<CR>

" Git mappings
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gc :Git commit<CR>
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gl :Git log<CR>

" Search and replace
nnoremap <leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>
vnoremap <leader>s :s/\%V//g<Left><Left><Left><Left>
nnoremap <leader>h :nohlsearch<CR>

" Line movement
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" EasyMotion
nmap <leader>j <Plug>(easymotion-overwin-f)
nmap <leader>J <Plug>(easymotion-overwin-f2)

" Language execution (F5)
function! RunCode()
  if &ft == 'rust'
    FloatermNew --autoclose=0 cargo run
  elseif &ft == 'python'
    FloatermNew --autoclose=0 python %
  elseif &ft == 'java'
    FloatermNew --autoclose=0 javac % && java %:r
  elseif &ft == 'zig'
    FloatermNew --autoclose=0 zig run %
  elseif &ft == 'c' || &ft == 'cpp'
    FloatermNew --autoclose=0 make run
  elseif &ft == 'glsl'
    echo "GLSL requires external compiler"
  else
    echo "No runner configured for" &ft
  endif
endfunction
nnoremap <F5> :call RunCode()<CR>

" Zed code runner (F6)
nnoremap <F6> :FloatermNew --autoclose=0 bash ~/zed_script.sh<CR>

" Debugging (vimspector)
nnoremap <leader>db :call vimspector#ToggleBreakpoint()<CR>
nnoremap <leader>dc :call vimspector#Continue()<CR>
nnoremap <leader>di :call vimspector#StepInto()<CR>
nnoremap <leader>do :call vimspector#StepOver()<CR>
nnoremap <leader>dO :call vimspector#StepOut()<CR>
nnoremap <leader>dr :call vimspector#Launch()<CR>
nnoremap <leader>dl :call vimspector#Restart()<CR>
nnoremap <leader>du :call vimspector#ToggleConsole()<CR>
nnoremap <leader>dt :call vimspector#Reset()<CR>

" Rust-specific
nnoremap <leader>rr :FloatermNew --autoclose=0 cargo run<CR>
nnoremap <leader>rt :FloatermNew --autoclose=0 cargo test<CR>
nnoremap <leader>rb :FloatermNew --autoclose=0 cargo build<CR>
nnoremap <leader>rc :FloatermNew --autoclose=0 cargo check<CR>
nnoremap <leader>ct :CargoToggle<CR>
nnoremap <leader>cr :CargoReload<CR>
nnoremap <leader>cv :CargoShowVersions<CR>
nnoremap <leader>cf :CargoShowFeatures<CR>
nnoremap <leader>cd :CargoShowDependencies<CR>

" C++/CMake
nnoremap <leader>ch :ClangdSwitchSourceHeader<CR>
nnoremap <leader>cs :ClangdSymbolInfo<CR>
nnoremap <leader>ct :ClangdTypeHierarchy<CR>
nnoremap <leader>cm :ClangdMemoryUsage<CR>
nnoremap <leader>cg :CMakeGenerate<CR>
nnoremap <leader>cb :CMakeBuild<CR>
nnoremap <leader>cr :CMakeRun<CR>
nnoremap <leader>cd :CMakeDebug<CR>
nnoremap <leader>cc :CMakeClean<CR>
nnoremap <leader>cx :CMakeClose<CR>

" Terminal
nnoremap <leader>tt :FloatermToggle<CR>
tnoremap <Esc> <C-\><C-n>

" Toggle line numbers
nnoremap <leader>ln :call ToggleLineNumbers()<CR>

" ==================================================
" LANGUAGE-SPECIFIC SETTINGS
" ==================================================
" Rust
let g:rustfmt_autosave = 1
autocmd FileType rust nnoremap <buffer> <leader>rr :Cargo run<CR>

" Zig
autocmd FileType zig setlocal commentstring=//\ %s

" Java
autocmd FileType java setlocal omnifunc=coc#refresh()
let g:java_highlight_functions = 1
let g:java_highlight_all = 1

" GLSL
autocmd BufNewFile,BufRead *.glsl,*.vert,*.frag,*.geom set filetype=glsl
let g:glsl_default_version = '460'

" Python
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4
let g:python_highlight_all = 1

" C/C++
autocmd FileType cpp setlocal commentstring=//\ %s
autocmd FileType c,cpp nnoremap <buffer> <leader>cg :CMakeGenerate<CR>

" ==================================================
" AUTOCOMMANDS
" ==================================================
augroup VimConfig
  autocmd!
  " Highlight on yank
  if exists('##TextYankPost')
    autocmd TextYankPost * silent! lua vim.highlight.on_yank({higroup='IncSearch', timeout=300})
  endif
  " Return to last position
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  " Auto-resize splits
  autocmd VimResized * wincmd =
  " Auto-reload vimrc
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
  " Create directories on save
  autocmd BufWritePre * call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

" ==================================================
" UTILITY FUNCTIONS
" ==================================================
" Toggle relative numbers
function! ToggleLineNumbers()
  if &relativenumber
    set norelativenumber
    set number
  else
    set relativenumber
  endif
endfunction

" Create directory if it doesn't exist
function! s:MkNonExDir(file, buf)
  if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
    let dir=fnamemodify(a:file, ':h')
    if !isdirectory(dir)
      call mkdir(dir, 'p')
    endif
  endif
endfunction

" ==================================================
" INSTALLATION INSTRUCTIONS
" ==================================================
" 1. Save this file as ~/.vimrc
" 2. Open Vim and run :PlugInstall
" 3. Restart Vim
" 4. Run :CocInstall for language servers
" 5. For transparency, uncomment the transparency lines in the theme section

Modern Vim Configuration
A powerful, modern Vim configuration inspired by EuclidaeZ and NvChad, designed for multi-language development with enhanced language server protocol (LSP) support, debugging, and a polished UI. Compatible with Vim 8.0+.
Features

Core Functionality: Syntax highlighting, auto-indentation, true color support, and persistent undo.
Plugins: Includes coc.nvim (LSP), vimspector (debugging), NERDTree (file explorer), fzf.vim (fuzzy finder), vim-airline (status/tabline), and more.
Language Support: Rust, C++, Zig, Java, GLSL, Python, JavaScript, and more, with language-specific key mappings and tools.
UI Enhancements: onedark theme, powerline fonts, indentation guides, and a customizable startup screen with vim-startify.
Key Mappings: Intuitive shortcuts for navigation, code execution, debugging, and Git integration.
Automation: Auto-reload vimrc, auto-create directories on save, and highlight-on-yank.

Installation

Backup Existing Configuration:mv ~/.vimrc ~/.vimrc.bak
mv ~/.vim ~/.vim.bak


Save the Configuration:
Copy the provided vimrc content to ~/.vimrc.


Install vim-plug:
The configuration automatically installs vim-plug if not present. Alternatively, run:curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim




Install Plugins:
Open Vim and run::PlugInstall


Wait for plugins to install, then restart Vim.


Install Language Servers:
For LSP support, run::CocInstall


This installs language servers like coc-rust-analyzer, coc-clangd, etc.


Optional Dependencies:
For Rust (crates.nvim), ensure cargo is installed:sudo dnf install cargo


For C++ (vim-cmake), ensure cmake and make are installed:sudo dnf install cmake make





Usage

Save the vimrc file to ~/.vimrc.
Open Vim to start using the configuration.
Use the leader key (<Space>) for most shortcuts (see below).
For transparency, uncomment the following lines in the THEME AND UI section:hi Normal guibg=NONE ctermbg=NONE
hi LineNr guibg=NONE ctermbg=NONE
hi SignColumn guibg=NONE ctermbg=NONE



Shortcuts
The configuration uses <Space> as the leader key (<leader>) and local leader key (<localleader>).
Core Functionality

; : Enter command mode (equivalent to :)
jk (in insert mode): Exit to normal mode
<leader>w : Save file (:w)
<leader>q : Quit (:q)
<leader>x : Save and quit (:x)
<leader>h : Clear search highlights (:nohlsearch)
<leader>ln : Toggle relative/absolute line numbers

File Explorer (NERDTree)

<leader>e : Toggle NERDTree
<leader>f : Find current file in NERDTree

Fuzzy Finder (fzf.vim)

<leader>ff : Search files (:Files)
<leader>fg : Search file contents (:Rg)
<leader>fb : List open buffers (:Buffers)
<leader>fh : Search command history (:History)

Buffer and Tab Navigation

<leader>bn : Next buffer (:bnext)
<leader>bp : Previous buffer (:bprev)
<leader>bd : Delete buffer (:bdelete)
<leader>tn : New tab (:tabnew)
<leader>tc : Close tab (:tabclose)
<leader>to : Close all other tabs (:tabonly)

Window Navigation and Resizing

<C-h> : Move to left window
<C-j> : Move to bottom window
<C-k> : Move to top window
<C-l> : Move to right window
<C-Up> : Increase window height
<C-Down> : Decrease window height
<C-Left> : Decrease window width
<C-Right> : Increase window width

Git Integration (vim-fugitive, vim-gitgutter)

<leader>gs : Open Git status (:Git)
<leader>gc : Git commit (:Git commit)
<leader>gp : Git push (:Git push)
<leader>gl : Git log (:Git log)

Search and Replace

<leader>s (normal mode): Replace word under cursor (:%s/<word>)
<leader>s (visual mode): Replace in selection (:s/%V)

Line Movement

<A-j> (normal/insert): Move line down
<A-k> (normal/insert): Move line up
<A-j> (visual): Move selected lines down
<A-k> (visual): Move selected lines up

Code Navigation (coc.nvim)

gd : Go to definition
gy : Go to type definition
gi : Go to implementation
gr : Show references
<leader>rn : Rename symbol
<leader>ca : Code actions
K : Show documentation (hover)
<Tab> (insert mode): Trigger completion / cycle forward
<S-Tab> (insert mode): Cycle backward
<C-Space> (insert mode): Trigger completion
<CR> (insert mode): Confirm completion

Code Execution

<F5> : Run code based on filetype:
Rust: cargo run
Python: python %
Java: javac % && java %:r
Zig: zig run %
C/C++: make run
GLSL: Displays "GLSL requires external compiler"


<F6> : Run custom Zed script (bash ~/zed_script.sh)

Debugging (vimspector)

<leader>db : Toggle breakpoint
<leader>dc : Continue execution
<leader>di : Step into
<leader>do : Step over
<leader>dO : Step out
<leader>dr : Launch debugger
<leader>dl : Restart debugger
<leader>du : Toggle debug console
<leader>dt : Reset debugger

Rust-Specific (rust.vim, crates.nvim)

<leader>rr : Run (cargo run)
<leader>rt : Test (cargo test)
<leader>rb : Build (cargo build)
<leader>rc : Check (cargo check)
<leader>ct : Toggle Cargo window
<leader>cr : Reload Cargo
<leader>cv : Show crate versions
<leader>cf : Show crate features
<leader>cd : Show crate dependencies

C++/CMake (vim-cmake, clangd_extensions.nvim)

<leader>ch : Switch between source/header
<leader>cs : Show symbol info
<leader>ct : Show type hierarchy
<leader>cm : Show memory usage
<leader>cg : Generate CMake build
<leader>cb : Build CMake project
<leader>cr : Run CMake project
<leader>cd : Debug CMake project
<leader>cc : Clean CMake build
<leader>cx : Close CMake window

Terminal (vim-floaterm)

<leader>tt : Toggle floating terminal
<Esc> (in terminal mode): Exit to normal mode

Motion (vim-easymotion)

<leader>j : Jump to character (single-char search)
<leader>J : Jump to two characters (two-char search)

Language-Specific Settings

Rust: Auto-formats on save with rustfmt.
Zig: Sets comment style to //.
Java: Enables enhanced syntax highlighting and LSP completion.
GLSL: Sets default version to 460 and recognizes .glsl, .vert, .frag, .geom files.
Python: Uses 4-space indentation and enables full syntax highlighting.
C/C++: Sets comment style to // and provides CMake integration.

Plugin Configuration

NERDTree: Shows hidden files, ignores .git, node_modules, etc.
vim-airline: Uses onedark theme with powerline fonts and tabline support.
coc.nvim: Supports LSP for Rust, C++, Python, Java, Zig, GLSL, JavaScript, etc.
vimspector: Configured for C++, Java, Python, and Rust debugging.
fzf.vim: Customizable file and content search with split/tab options.
vim-startify: Displays sessions, recent files, and bookmarks on startup.
crates.nvim: Enhances Rust Cargo.toml editing with version/feature popups.
ale: Provides linting for Python, JavaScript, Rust, and C++.
vim-fugitive/vim-gitgutter: Git integration with status, commit, and diff markers.

Troubleshooting

Plugins Fail to Load: Run :PlugInstall or check ~/.vim/plugged/ for issues.
LSP Errors: Ensure language servers are installed (:CocInstall) and dependencies (e.g., rust-analyzer, clangd) are available.
Slow Performance: Disable ale (let g:ale_enabled = 0) if coc.nvim is sufficient for linting.
Transparency Issues: Ensure your terminal supports true colors and transparency.

Contributing
Feel free to fork this configuration and submit pull requests with improvements. Report issues or suggestions in the issue tracker of the repository hosting this config (if applicable).
License
This configuration is provided under the MIT License. See the respective plugin repositories for their licenses.
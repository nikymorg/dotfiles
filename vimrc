" show line numbers
set number

" syntax highlighting
syntax on
syntax enable

" keep 500 commands in history
set history=500

" show cursor position
set ruler

" show incomplete commands
set showcmd

" show menu for tab completion
set wildmenu

" keep 5 line margin
set scrolloff=5

" search settings
set hlsearch
set incsearch
set ignorecase

" line wrap at space
set lbr

" indentation
set smartindent
set autoindent     " open lines at same indentation
set expandtab      " turn tabs into tabstop spaces
set tabstop=2      " 1 tab = 2 spaces
set shiftwidth=2   " shift 2 spaces

" colorscheme
colorscheme desert

" whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

autocmd FileType netrw setl bufhidden=delete

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*,*/log/*,*/app/assets/javascripts/_bundles/*,*.beam,*/_build,*/deps/*
set runtimepath^=~/.vim/bundle/vim-vinegar/plugin/vinegar.vim

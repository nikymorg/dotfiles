let g:pathogen_disabled=['auto-pairs']

execute pathogen#infect()
syntax on

filetype indent plugin on  " Wrap gitcommit file types at the appropriate length
syntax enable      " syntax highlighting
set vb             " flashes screen on errors
set hlsearch       " highlight search terms
set incsearch
set ignorecase
set number
set tags=tags

" indentation
set smartindent
set autoindent     " open lines at same indentation
set expandtab      " turn tabs into tabstop spaces
set tabstop=2      " 1 tab = 2 spaces
set shiftwidth=2   " shift 2 spaces

set textwidth=76
set wildmenu
set mouse=a	       " allow mouse
"set cursorline     " highlights/underlines current line
set ruler	       " shows cursor position
set background=dark
set t_Co=256
colorscheme default

" whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

filetype on         "enable filetype detection
filetype plugin on  "enable filetype-specific plugins
filetype plugin indent on " fix indenting of # comments
runtime macros/matchit.vim

" set pastetoggle
set pastetoggle=<f5>

let NERDTreeShowHidden=1 "show hidden files in tree

" some mappings
let mapleader = ","
map <C-N> <esc>:NERDTreeToggle<CR>
nmap <space> zz
nmap <C-H> <C-W>h
nmap <C-L> <C-W>l
nmap <C-J> <C-W>j
nmap <C-K> <C-W>k
nmap <C-P> <C-W>k
"Note that <CR> is used for ENTER
imap <leader>wq <esc>:wq<CR>

" Quit all windows. Helpful esp. in Git Diff
map <F2> <esc>:qall<CR>

if &diff
    colorscheme github
endif

" Toggle line wrapping.
"map <leader>w <esc>:set wrap!<CR>
"map <leader>e <esc>:set expandtab<CR>
"map <leader>ne <esc>:set noexpandtab<CR>
"map <leader>l <esc>:set list<CR>
"map <leader>nl <esc>:set nolist<CR>
"map <leader>f <esc>:NERDTreeFind<CR>
"nnoremap <leader>d <esc>:bd<cr>

"" Toggle cursorline
"map <leader>cl <esc>:set cursorline!<CR>

" clear highlights
nnoremap <Leader><space> :nohlsearch<CR>


"%:h expansion
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*,*/log/*,*/app/assets/javascripts/_bundles/*,*.beam,*/_build,*/deps/*

" Ignore some folders and files for CtrlP indexing
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.yardoc\|public$|log\|tmp$|node_modules\|deps\',
  \ 'file': '\.so$\|\.dat$|\.DS_Store$'
  \ }

" add a cache for ctrlP
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
let g:ctrlp_clear_cache_on_exit = 0

" delegate to ag if available
if executable('ag')
	let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
				\ --ignore .git
				\ --ignore .svn
				\ --ignore .hg
				\ --ignore .DS_Store
				\ --ignore "**/*.pyc"
				\ -g ""'
endif

""ale
let g:ale_linters = {
\  'javascript': ['eslint'],
\  'jsx': ['eslint']
\}

let g:ale_fixers = {
\  'javascript': ['eslint'],
\  'jsx': ['eslint']
\}

let g:ale_sign_column_always = 1
let g:ale_fix_on_save = 0


" ag for ack

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif


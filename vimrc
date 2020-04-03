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

" ctrl-p fuzzy finder
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*,*/log/*,*/app/assets/javascripts/_bundles/*,*.beam,*/_build,*/deps/*

let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.yardoc\|public$|log\|tmp$',
  \ 'file': '\.so$\|\.dat$|\.DS_Store$'
  \ }

" Use The Silver Searcher
if executable('ag')
  " Use ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Ale linting settings
let g:ale_fixers = {
\   'javascript': ['eslint'],
\}

highlight clear SignColumn
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow

let g:ale_change_sign_column_color = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'

let g:ale_echo_cursor = 1
let g:ale_echo_msg_error_str = 'Error'
let g:ale_echo_msg_format = '%code: %%s'
let g:ale_echo_msg_info_str = 'Info'
let g:ale_echo_msg_warning_str = 'Warning'

-- from https://github.com/nvim-lua/kickstart.nvim
-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 }, -- style
  'junegunn/fzf', -- fuzzyfinder
  'junegunn/fzf.vim', -- fuzzyfinder commands
  'dense-analysis/ale', -- syntax checking
  'github/copilot.vim', -- AI code suggestions
  'tpope/vim-vinegar', -- filenav
})

-- show line numbers
vim.opt.number = true

vim.cmd([[
  " syntax highlighting
  syntax on
  syntax enable
  set re=0

  " set fold method
  set foldmethod=syntax
  set nofoldenable

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

  " whitespace
  highlight ExtraWhitespace ctermbg=red guibg=red
  match ExtraWhitespace /\s\+$/
  autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd InsertLeave * match ExtraWhitespace /\s\+$/
  autocmd BufWinLeave * call clearmatches()
  autocmd FileType netrw setl bufhidden=delete

  " colorscheme
  colorscheme catppuccin-mocha

  " grep
  set grepprg=rg\ --vimgrep\ --smart-case\ --follow

  " fuzzy finder
  nnoremap <silent> <C-p> :GFiles<CR>
  set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*,*/log/*,*/app/assets/javascripts/_bundles/*,*.beam,*/_build,*/deps/*

  " Ale linting settings
  let g:ale_ruby_sorbet_executable = "./bin/srb"
  let g:ale_javascript_eslint_executable = "./bin/eslint"

  let b:ale_linters={}
  let g:ale_fixers = {
  \   'javascript': ['eslint'],
  \   'typescript': ['eslint'],
  \   'ruby': ['rubocop', 'srb'],
  \   'erb': ['erblint']
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
]])

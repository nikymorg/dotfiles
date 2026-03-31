-- Settings shared between standalone nvim and VS Code
-- =====================

-- search
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- indentation
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- line wrap at space
vim.opt.linebreak = true

-- history
vim.opt.history = 500

-- scrolling
vim.opt.scrolloff = 5

-- Standalone nvim only
-- =====================
if not vim.g.vscode then

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
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 }, -- style
  'junegunn/fzf', -- fuzzyfinder
  'junegunn/fzf.vim', -- fuzzyfinder commands
  'dense-analysis/ale', -- syntax checking
  'tpope/vim-vinegar', -- filenav
})

-- line numbers
vim.opt.number = true

-- syntax
vim.cmd('syntax on')
vim.cmd('syntax enable')
vim.opt.regexpengine = 0

-- folding
vim.opt.foldmethod = 'syntax'
vim.opt.foldenable = false

-- ui
vim.opt.ruler = true
vim.opt.showcmd = true
vim.opt.wildmenu = true

-- whitespace highlighting
vim.api.nvim_set_hl(0, 'ExtraWhitespace', { bg = 'red' })
local whitespace_group = vim.api.nvim_create_augroup('ExtraWhitespace', { clear = true })
vim.api.nvim_create_autocmd('BufWinEnter', {
  group = whitespace_group,
  pattern = '*',
  callback = function() vim.fn.matchadd('ExtraWhitespace', [[\s\+$]]) end,
})
vim.api.nvim_create_autocmd('InsertEnter', {
  group = whitespace_group,
  pattern = '*',
  callback = function()
    vim.fn.clearmatches()
    vim.fn.matchadd('ExtraWhitespace', [[\s\+\%#\@<!$]])
  end,
})
vim.api.nvim_create_autocmd('InsertLeave', {
  group = whitespace_group,
  pattern = '*',
  callback = function()
    vim.fn.clearmatches()
    vim.fn.matchadd('ExtraWhitespace', [[\s\+$]])
  end,
})
vim.api.nvim_create_autocmd('BufWinLeave', {
  group = whitespace_group,
  pattern = '*',
  callback = function() vim.fn.clearmatches() end,
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'netrw',
  callback = function() vim.bo.bufhidden = 'delete' end,
})

-- colorscheme
vim.cmd.colorscheme('catppuccin-mocha')

-- grep
vim.opt.grepprg = 'rg --vimgrep --smart-case --follow'

-- fuzzy finder
vim.keymap.set('n', '<C-p>', ':GFiles<CR>', { silent = true })
vim.opt.wildignore:append('*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*,*/log/*,*/app/assets/javascripts/_bundles/*,*.beam,*/_build,*/deps/*')

-- ALE linting
vim.g.ale_ruby_sorbet_executable = './bin/srb'
vim.g.ale_javascript_eslint_executable = './bin/eslint'
vim.g.ale_fixers = {
  javascript = { 'eslint' },
  typescript = { 'eslint' },
  ruby = { 'rubocop', 'srb' },
  erb = { 'erblint' },
}

vim.api.nvim_set_hl(0, 'SignColumn', {})
vim.api.nvim_set_hl(0, 'ALEErrorSign', { fg = 'red' })
vim.api.nvim_set_hl(0, 'ALEWarningSign', { fg = 'yellow' })

vim.g.ale_change_sign_column_color = 0
vim.g.ale_lint_on_text_changed = 'never'
vim.g.ale_lint_on_insert_leave = 0
vim.g.ale_lint_on_enter = 0
vim.g.ale_sign_error = '✘'
vim.g.ale_sign_warning = '⚠'

vim.g.ale_echo_cursor = 1
vim.g.ale_echo_msg_error_str = 'Error'
vim.g.ale_echo_msg_format = '%code: %%s'
vim.g.ale_echo_msg_info_str = 'Info'
vim.g.ale_echo_msg_warning_str = 'Warning'

end -- not vim.g.vscode

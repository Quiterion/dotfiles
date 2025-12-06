-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

-- Hide statusline immediately (before any plugins load)
vim.opt.laststatus = 0

-- Leader key (must be set before lazy.nvim loads)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Tab/indent settings
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.termguicolors = true

-- Folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldtext =
  [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]

-- Display
vim.opt.wrap = true
vim.opt.hlsearch = false
vim.opt.cmdheight = 0
vim.o.winborder = "single"

-- Hide tabline initially (bufferline will show it when needed)
vim.opt.showtabline = 0

-- Disable winbar
vim.opt.winbar = ""

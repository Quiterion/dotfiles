-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- VimTeX compile
vim.keymap.set("n", "<leader>tc", ":VimtexCompile<CR>", { desc = "VimTeX compile" })

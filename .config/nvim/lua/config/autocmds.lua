-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

-- Hide statusline and tabline on dashboard
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "dashboard", "alpha" },
  callback = function()
    vim.opt.laststatus = 0
    vim.opt.showtabline = 0
    vim.opt.ruler = false
    vim.opt.showcmd = false
  end,
})

-- Restore statusline when leaving dashboard
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    vim.opt.laststatus = 3
    vim.opt.showtabline = 2
  end,
})

-- Initialize vimtex for tex files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = function()
    vim.cmd("call vimtex#init()")
  end,
})

-- Function to apply transparent highlights
local function apply_transparency()
  -- Main editor backgrounds
  vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE" })

  -- UI elements / popups
  vim.api.nvim_set_hl(0, "Pmenu", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#3d4048", bold = true })
  vim.api.nvim_set_hl(0, "PmenuSbar", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "PmenuThumb", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "CmpPmenu", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "CmpPmenuBorder", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "CursorLine", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "ColorColumn", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "WinBarNC", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "TabLineFill", { bg = "NONE" })

  -- Borders and separators
  vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#808080", bg = "NONE" })
  vim.api.nvim_set_hl(0, "VertSplit", { fg = "#808080", bg = "NONE" })
  vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#808080", bg = "NONE" })

  -- Diagnostics (no background)
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = "#1abc9c", bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = "#0db9d7", bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = "#e0af68", bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#db4b4b", bg = "NONE" })

  -- Plugin-specific
  vim.api.nvim_set_hl(0, "SLCopilot", { fg = "#6CC644", bg = "NONE" })
  vim.api.nvim_set_hl(0, "WhichkeyFloat", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "WhichKeyNormal", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "Folded", { fg = "#8b949e", bg = "NONE" })

  -- Neo-tree (LazyVim uses neo-tree instead of nvim-tree)
  vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { bg = "NONE" })

  -- Disable middle mouse
  vim.keymap.set("n", "<MiddleMouse>", "<Nop>", { noremap = true, silent = true })
end

-- Apply on colorscheme change
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = apply_transparency,
})

-- Also apply on VimEnter, BufEnter, and CmdlineLeave to ensure it persists
vim.api.nvim_create_autocmd({ "VimEnter", "BufEnter", "CmdlineLeave" }, {
  callback = function()
    vim.defer_fn(apply_transparency, 1)
  end,
})

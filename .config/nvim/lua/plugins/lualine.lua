-- Load pywal theme with transparency modifications
local function load_pywal_theme()
  package.loaded["lualine.themes.pywal"] = nil
  local ok, pywal_theme = pcall(require, "lualine.themes.pywal")
  if ok then
    for _, mode in pairs({ "normal", "insert", "visual", "replace", "command", "inactive" }) do
      if pywal_theme[mode] then
        if pywal_theme[mode].c then
          pywal_theme[mode].c.bg = "NONE"
        end
        if pywal_theme[mode].b then
          pywal_theme[mode].b.bg = "NONE"
        end
      end
    end
    return pywal_theme
  end
  return nil
end

return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function(_, opts)
      local pywal_theme = load_pywal_theme()
      if pywal_theme then
        opts.options = opts.options or {}
        opts.options.theme = pywal_theme
      end

      opts.options = opts.options or {}
      opts.options.globalstatus = true

      return opts
    end,
    config = function(_, opts)
      require("lualine").setup(opts)

      vim.api.nvim_create_user_command("LualineReloadPywal", function()
        local pywal_theme = load_pywal_theme()
        if pywal_theme then
          require("lualine").setup({ options = { theme = pywal_theme, globalstatus = true } })
        end
      end, { desc = "Reload lualine pywal theme" })

      local function hide_on_dashboard()
        local ft = vim.bo.filetype
        if ft == "snacks_dashboard" then
          vim.opt.laststatus = 0
          vim.opt.cmdheight = 0
        else
          vim.opt.laststatus = 3
        end
      end

      -- Multiple hooks to catch all cases
      vim.api.nvim_create_autocmd({ "BufEnter", "FileType", "BufWinEnter", "CmdlineLeave", "ModeChanged" }, {
        callback = hide_on_dashboard,
      })

      -- Defer to run after everything else
      vim.defer_fn(hide_on_dashboard, 1)
      --vim.defer_fn(hide_on_dashboard, 50)
      --vim.defer_fn(hide_on_dashboard, 100)
    end,
  },
}

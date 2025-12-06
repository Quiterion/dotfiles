return {
  "lervag/vimtex",
  ft = "tex",
  lazy = false,
  init = function()
    vim.g.tex_flavor = "latex"
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_quickfix_mode = 0
    vim.g.vimtex_compiler_latexmk = {
      build_dir = "",
      callback = 1,
      continuous = 1,
      executable = "latexmk",
      hooks = {},
      options = {
        "-shell-escape",
        "-verbose",
        "-synctex=1",
        "-file-line-error",
        "-interaction=nonstopmode",
      },
    }
    vim.g.tex_conceal = "abdmg"
  end,
}

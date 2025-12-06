return {
  -- Configure conform.nvim for formatting (LazyVim's default formatter)
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
      },
      formatters = {
        prettier = {
          prepend_args = { "--print-width", "100" },
        },
      },
    },
  },

  -- Ensure prettier is installed
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "prettier",
      },
    },
  },
}

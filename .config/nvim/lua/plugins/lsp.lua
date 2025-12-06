return {
  -- Configure pyright for use with Ruff
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            pyright = {
              -- Using Ruff's import organizer
              disableOrganizeImports = true,
            },
            python = {
              analysis = {
                -- Ignore all files for analysis to exclusively use Ruff for linting
                ignore = { "*" },
              },
            },
          },
        },
        -- Enable ruff_lsp for linting
        ruff_lsp = {},
      },
    },
  },

  -- Ensure ruff is installed via mason
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "pyright",
        "ruff",
        "ruff-lsp",
      },
    },
  },
}

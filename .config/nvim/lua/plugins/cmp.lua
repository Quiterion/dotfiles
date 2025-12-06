return {
  -- Configure nvim-cmp to disable completion in comments
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.enabled = function()
        local context = require("cmp.config.context")
        local buftype = vim.api.nvim_get_option_value("buftype", { buf = 0 })

        -- Disable in prompt buffers
        if buftype == "prompt" then
          return false
        end

        -- Keep enabled in command mode
        if vim.api.nvim_get_mode().mode == "c" then
          return true
        end

        -- Disable in comments
        return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
      end
      return opts
    end,
  },
}

return {
  "akinsho/bufferline.nvim",
  event = "BufAdd", -- Only load when a buffer is added (not on dashboard)
  opts = {
    options = {
      offsets = {
        {
          filetype = "neo-tree",
          text = "",
          text_align = "center",
        },
      },
    },
  },
}

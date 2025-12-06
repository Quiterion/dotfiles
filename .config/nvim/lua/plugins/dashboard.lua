return {
  {
    "folke/snacks.nvim",
    opts = function()
      -- Get fortune at config time
      local fortune_lines = {}
      local handle = io.popen("fortune -s 2>/dev/null")
      if handle then
        local result = handle:read("*a")
        handle:close()
        if result and result ~= "" then
          result = result:gsub("^%s+", ""):gsub("%s+$", "")
          for line in result:gmatch("[^\r\n]+") do
            table.insert(fortune_lines, line)
          end
        end
      end

      -- Build sections
      local sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup", padding = 1 },
        --{
        --  text = {
        --    "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━",
        --  },
        --  align = "center",
        --  hl = "Comment",
        --},
      }

      -- Add each fortune line as separate text section (italic)
      for _, line in ipairs(fortune_lines) do
        table.insert(sections, { text = { line }, align = "center", hl = "@text.emphasis" })
      end

      --table.insert(sections, {
      --  text = {
      --    "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━",
      --  },
      --  align = "center",
      --  hl = "Comment",
      --  padding = 1,
      --})

      return {
        dashboard = {
          preset = {
            header = [[
    ███╗   ██╗  ██████╗  ██████╗  ██╗   ██╗  ██╗  ███╗   ███╗
   ████║  ██╔╝ ██╔════╝██╔═══██║ ██╔╝  ██╔╝ ██╔╝ ████║ ████╔╝
  ██║██║ ██╔╝ █████╗  ██╔╝  ██╔╝██╔╝  ██╔╝ ██╔╝ ██║████╝██╔╝
 ██╔╝██║██╔╝ ██╔═══╝ ██╔╝  ██╔╝ ██║ ██╔═╝ ██╔╝ ██╔╝██╔╝██╔╝
██╔╝ ████╔╝ ██████╗  ██████╔═╝  ████╔═╝  ██╔╝ ██╔╝ ╚═╝██╔╝
╚═╝  ╚═══╝  ╚═════╝  ╚═════╝    ╚═══╝    ╚═╝  ╚═╝     ╚═╝
]],
          },
          sections = sections,
        },
      }
    end,
  },
}

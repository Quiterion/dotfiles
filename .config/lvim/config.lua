-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim

lvim.leader = ","
lvim.format_on_save.enabled = true
lvim.transparent_window = true
lvim.colorscheme = "github_dark"
lvim.use_icons = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.foldmethod = "expr"                     -- default is "normal"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- default is ""
vim.opt.foldlevel = 99
vim.opt.foldtext =
[[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
vim.opt.wrap = true
vim.opt.hlsearch = false
vim.opt.cmdheight = 0

lvim.autocommands = {
    {
        { "ColorScheme" },
        {
            pattern = "*",
            callback = function()
                -- change `Normal` to the group you want to change
                -- and `#ffffff` to the color you want
                -- see `:h nvim_set_hl` for more options
                vim.api.nvim_set_hl(0, "NormalFloat", { bg = nil })
                vim.api.nvim_set_hl(0, "CursorLine", { bg = nil })
                --vim.api.nvim_set_hl(0, "VertSplit", { fg = "#000000", bg = nil })
                vim.api.nvim_set_hl(0, "StatusLine", { bg = nil })
                vim.api.nvim_set_hl(0, "SLCopilot", { fg = "#6CC644", bg = nil })
                vim.api.nvim_set_hl(0, "FloatBorder", { bg = nil })
                vim.api.nvim_set_hl(0, "WhichkeyFloat", { bg = nil })
                vim.api.nvim_set_hl(0, "TelescopeNormal", { ctermbg = nil, guibg = nil })
                vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = "#1abc9c", bg = nil })
                vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = "#0db9d7", bg = nil })
                vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = "#e0af68", bg = nil })
                vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#db4b4b", bg = nil })
                vim.api.nvim_set_hl(0, "WinBarNC", { bg = nil })
                vim.api.nvim_set_hl(0, "TabLineFill", { bg = nil })
                vim.api.nvim_set_hl(0, "NvimTreeWindowPicker", { fg = "#ededed", bg = nil, bold = true })
                vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { fg = "#ffffff", bg = nil })
                --vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#808080", bg = nil })
                vim.api.nvim_set_keymap("n", "<MiddleMouse>", "<Nop>", { noremap = true, silent = true })
                vim.api.nvim_set_keymap("n", "<F8>", "<cmd>",
                    { noremap = true, silent = true, callback = function() vim.diagnostic.goto_next() end })
            end,
        },
    },
}

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
    {
        name = "prettier",
        ---@usage arguments to pass to the formatter
        -- these cannot contain whitespace
        -- options such as `--line-width 80` become either `{"--liBufferTabPagesne-width", "80"}` or `{"--line-width=80"}`
        args = { "--print-width", "100" },
        ---@usage only start in these filetypes, by default it will attach to all filetypes it supports
        filetypes = { "typescript", "typescriptreact" },
    },
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
    {
        name = "shellcheck",
        args = { "--severity", "warning" },
    },
}

local code_actions = require "lvim.lsp.null-ls.code_actions"
code_actions.setup {
    {
        name = "proselint",
    },
}

require('lspconfig').pyright.setup {
    settings = {
        pyright = {
            -- Using Ruff's import organizer
            disableOrganizeImports = true,
        },
        python = {
            analysis = {
                -- Ignore all files for analysis to exclusively use Ruff for linting
                ignore = { '*' },
            },
        },
    },
}

lvim.builtin.bufferline.options.offsets = {
    {
        filetype = "NvimTree",
        text = "",
        text_align = "center",
        --separator = false,
    },
}

-- lazy.nvim plugins

table.insert(lvim.plugins, {
    "zbirenbaum/copilot-cmp",
    event = "InsertEnter",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
        vim.defer_fn(function()
            require("copilot").setup({
                suggestion = { enabled = false },
                panel = { completion = false },
            })
            require("copilot_cmp").setup() -- https://github.com/zbirenbaum/copilot-cmp/blob/master/README.md#configuration
        end, 100)
    end,
})

table.insert(lvim.plugins, {
    'projekt0n/github-nvim-theme',
    name = 'github-theme',
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
})

lvim.builtin.cmp.enabled = function()
    -- disable completion in comments
    local context = require 'cmp.config.context'
    -- keep command mode completion enabled when cursor is in a comment
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = 0 })
    if buftype == "prompt" then
        return false
    end
    if vim.api.nvim_get_mode().mode == 'c' then
        return true
    else
        return not context.in_treesitter_capture("comment")
            and not context.in_syntax_group("Comment")
    end
end

table.insert(lvim.plugins, {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    opts = {
        -- add any opts here
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        --- The below dependencies are optional,
        "echasnovski/mini.pick",         -- for file_selector provider mini.pick
        "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
        "hrsh7th/nvim-cmp",              -- autocompletion for avante commands and mentions
        "ibhagwan/fzf-lua",              -- for file_selector provider fzf
        "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons
        "zbirenbaum/copilot.lua",        -- for providers='copilot'
        {
            -- support for image pasting
            "HakonHarnes/img-clip.nvim",
            event = "VeryLazy",
            opts = {
                -- recommended settings
                default = {
                    embed_image_as_base64 = false,
                    prompt_for_file_name = false,
                    drag_and_drop = {
                        insert_mode = true,
                    },
                    -- required for Windows users
                    use_absolute_path = true,
                },
            },
        },
        {
            -- Make sure to set this up properly if you have lazy=true
            'MeanderingProgrammer/render-markdown.nvim',
            opts = {
                file_types = { "markdown", "Avante" },
            },
            ft = { "markdown", "Avante" },
        },
    },
}

)


local theme = require("lualine.themes.pywal")
lvim.builtin.lualine.options.theme = theme


-- alpha config

--local alpha = require('lvim.core.alpha')
--local dashboard = require('alpha.themes.dashboard')
--local footerPadding = fn.floor(fn.max({ 2, fn.floor(fn.winheight(1) * marginBtmPercent) }) / 2)
--
--
--alpha.setup(config)
local alpha = require("lvim.core.alpha")
local dashboard = lvim.builtin.alpha.dashboard


dashboard.section.header.val = {
    "    ███╗   ██╗  ██████╗  ██████╗  ██╗   ██╗  ██╗  ███╗   ███╗",
    "   ████║  ██╔╝ ██╔════╝██╔═══██║ ██╔╝  ██╔╝ ██╔╝ ████║ ████╔╝",
    "  ██║██║ ██╔╝ █████╗  ██╔╝  ██╔╝██╔╝  ██╔╝ ██╔╝ ██║████╝██╔╝ ",
    " ██╔╝██║██╔╝ ██╔═══╝ ██╔╝  ██╔╝ ██║ ██╔═╝ ██╔╝ ██╔╝██╔╝██╔╝  ",
    "██╔╝ ████╔╝ ██████╗  ██████╔═╝  ████╔═╝  ██╔╝ ██╔╝ ╚═╝██╔╝   ",
    "╚═╝  ╚═══╝  ╚═════╝  ╚═════╝    ╚═══╝    ╚═╝  ╚═╝     ╚═╝    ",
}
local fortune = require("alpha.fortune")

local options = {
    max_width = 60,
}

--[[
local fortune_text = {}
local handle = io.popen("fortune -s startrek linux work science education computers")
if not handle then
    fortune_text = { "Could not fetch fortune quote" }
else
    for line in handle:lines() do
        -- Remove leading whitespace
        local trimmed = line:gsub("^%s*%-", "%-")

        local first_char = trimmed:sub(1, 1)
        local is_new_line = first_char == "-" or first_char == " "

        if #fortune_text > 0 and not is_new_line then
            -- Append to previous line
            local last_line = table.remove(fortune_text)
            table.insert(fortune_text, last_line .. " " .. trimmed)
        else
            table.insert(fortune_text, trimmed)
        end
    end
    handle:close()
    options.fortune_list = { fortune_text }
end
]]

dashboard.section.footer.val = fortune(options)

local content_height = #dashboard.section.header.val + (#dashboard.section.buttons.entries * 2 - 1) + 8
local padding = vim.fn.floor((61 - content_height + 2) / 2)
for _ = 1, padding, 1 do
    table.insert(dashboard.section.header.val, 0, "")
end

-- echo winheight
-- Send config to alpha
alpha.setup(dashboard.config)

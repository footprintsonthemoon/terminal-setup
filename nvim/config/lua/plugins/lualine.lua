return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local palette = require("catppuccin.palettes").get_palette("mocha")

      local theme = {
        normal = {
          a = { bg = palette.blue, fg = palette.base, gui = "bold" },
          b = { bg = palette.surface0, fg = palette.text },
          c = { bg = palette.mantle, fg = palette.subtext1 },
        },
        insert = {
          a = { bg = palette.green, fg = palette.base, gui = "bold" },
          b = { bg = palette.surface0, fg = palette.text },
          c = { bg = palette.mantle, fg = palette.subtext1 },
        },
        visual = {
          a = { bg = palette.mauve, fg = palette.base, gui = "bold" },
          b = { bg = palette.surface0, fg = palette.text },
          c = { bg = palette.mantle, fg = palette.subtext1 },
        },
        replace = {
          a = { bg = palette.red, fg = palette.base, gui = "bold" },
          b = { bg = palette.surface0, fg = palette.text },
          c = { bg = palette.mantle, fg = palette.subtext1 },
        },
        command = {
          a = { bg = palette.peach, fg = palette.base, gui = "bold" },
          b = { bg = palette.surface0, fg = palette.text },
          c = { bg = palette.mantle, fg = palette.subtext1 },
        },
        inactive = {
          a = { bg = palette.crust, fg = palette.overlay1 },
          b = { bg = palette.crust, fg = palette.overlay1 },
          c = { bg = palette.crust, fg = palette.overlay0 },
        },
      }

      require("lualine").setup({
        options = {
          theme = theme,
          globalstatus = true,
          section_separators = "",
          component_separators = "",
          disabled_filetypes = {
            statusline = { "neo-tree" },
          },
        },
        sections = {
          lualine_a = {
            {
              "mode",
              fmt = function(str)
                return str:sub(1, 1)
              end,
            },
          },
          lualine_b = {
            {
              "branch",
              icon = "",
              color = { fg = palette.lavender, gui = "bold" },
            },
          },
          lualine_c = {
            {
              "filename",
              path = 1,
              symbols = {
                modified = " ●",
                readonly = " ",
              },
            },
          },
          lualine_x = {
            {
              "filetype",
              icon_only = true,
            },
          },
          lualine_y = {},
          lualine_z = {
            {
              "location",
              color = { fg = palette.yellow, gui = "bold" },
              fmt = function(str)
                return str:gsub(" ", "")
              end,
            },
          },
        },
      })
    end,
  },
}

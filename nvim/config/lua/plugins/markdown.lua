return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    ft = { "markdown" }, -- nur laden wenn nötig
    config = function()
      require("render-markdown").setup({
        render_modes = { "n", "c", "t" }, -- normal, command, terminal

        heading = {
          enabled = true,
        },

        code = {
          enabled = true,
          sign = false,
          width = "block",
        },

        bullet = {
          enabled = true,
        },

        checkbox = {
          enabled = true,
        },
      })

      -- Toggle Rendering
      vim.keymap.set("n", "<leader>mr", function()
        require("render-markdown").toggle()
      end, { desc = "Markdown Render toggle" })
    end,
  },
}

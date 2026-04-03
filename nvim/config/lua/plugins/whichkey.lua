return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")

      wk.setup({})

      wk.add({
        { "<leader>f", group = "Find" },
        { "<leader>m", group = "Markdown" },
        { "<leader>e", desc = "Explorer" },
        { "<leader>o", desc = "Explorer fokussieren" },
        { "<leader>w", desc = "Zwischen Explorer und Editor wechseln" },
      })
    end,
  },
}

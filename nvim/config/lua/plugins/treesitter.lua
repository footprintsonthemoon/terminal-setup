return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        install = { "lua", "vim", "vimdoc", "python", "markdown", "markdown_inline" },
      })
    end,
  },
}

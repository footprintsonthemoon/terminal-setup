return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = "Neotree",
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Explorer oeffnen/schliessen" },
      { "<leader>o", "<cmd>Neotree focus<cr>", desc = "Explorer fokussieren" },
      {
        "<leader>w",
        function()
          local ft = vim.bo.filetype
          if ft == "neo-tree" then
            vim.cmd("wincmd l")
          else
            vim.cmd("wincmd h")
          end
        end,
        desc = "Zwischen Explorer und Editor wechseln",
      },
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = false,
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,

        window = {
          position = "left",
          width = 30,
          mappings = {
            ["<esc>"] = function()
              vim.cmd("wincmd l")
            end,
            ["w"] = function()
              vim.cmd("wincmd l")
            end,
          },
        },

        filesystem = {
          follow_current_file = {
            enabled = true,
          },
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = true,
            hide_hidden = false,
          },
          hijack_netrw_behavior = "open_default",
          use_libuv_file_watcher = true,
        },
      })
    end,
  },
}

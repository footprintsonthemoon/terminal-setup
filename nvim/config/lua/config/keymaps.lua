local builtin = require("telescope.builtin")

vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Dateien im Projekt suchen" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Im Projekt suchen" })

vim.keymap.set("n", "<leader>fc", function()
  builtin.find_files({
    cwd = vim.fn.expand("~/.config/nvim"),
    hidden = true,
  })
end, { desc = "Neovim-Konfiguration durchsuchen" })

vim.keymap.set("n", "<leader>fh", function()
  builtin.find_files({
    cwd = vim.fn.expand("~"),
    hidden = true,
  })
end, { desc = "Home-Verzeichnis durchsuchen" })

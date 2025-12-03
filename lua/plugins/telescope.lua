return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.6",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("telescope").setup({})
    
    -- Горячие клавиши
    vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>")
    vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>")
  end,
}

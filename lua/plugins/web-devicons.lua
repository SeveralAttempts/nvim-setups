return {
  "nvim-tree/nvim-web-devicons",
  lazy = true,  -- Загружать только когда нужно
  config = function()
    require("nvim-web-devicons").setup({})
  end,
}

return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,  -- Высокий приоритет для темы
  config = function()
    require("catppuccin").setup({
      flavour = "latte",  -- latte, frappe, macchiato, mocha
      background = {
        light = "latte",
        dark = "mocha",
      },
      transparent_background = false,
      show_end_of_buffer = false,
      term_colors = false,
      dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
      },
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        mini = false,
      },
    })
    
    -- Установить тему
    vim.cmd.colorscheme("catppuccin")
  end,
}

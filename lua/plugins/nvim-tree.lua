return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,  -- Загружать сразу, а не лениво
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("nvim-tree").setup({
      -- Отключаем старый netrw
      disable_netrw = true,
      hijack_netrw = true,
      
      -- Вид
      view = {
        width = 35,
        side = "left",
      },
      
      -- Действия
      actions = {
        open_file = {
          quit_on_open = false,  -- Закрывать дерево при открытии файла
        },
      },
      
      -- Обновление
      update_focused_file = {
        enable = true,
        update_root = true,
      },
      
      -- Git
      git = {
        enable = true,
      },
      
      -- Иконки
      renderer = {
        icons = {
          glyphs = {
            folder = {
              arrow_closed = "▶",
              arrow_open = "▼",
            },
          },
        },
      },
    })
    
    -- Горячие клавиши
    vim.keymap.set("n", "<C-t>", ":NvimTreeToggle<CR>", { desc = "Toggle file tree" })
    vim.keymap.set("n", "<leader>e", ":NvimTreeFocus<CR>", { desc = "Focus file tree" })
    vim.keymap.set("n", "<leader>r", ":NvimTreeRefresh<CR>", { desc = "Refresh file tree" })
  end,
}

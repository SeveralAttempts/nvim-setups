require("config.options")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim с плагинами из plugins/init.lua
require("lazy").setup(require("plugins"), {
  install = { colorscheme = { "habamax" } },
  checker = { enabled = true },
  rocks = { enabled = false },  -- Отключаем luarocks если есть проблемы
})

-- Автоматическое открытие nvim-tree
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    vim.defer_fn(function()
      pcall(function()
        require("nvim-tree.api").tree.open()
      end)
    end, 50)
  end,
})

return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },
  config = function()
    -- Импортируем Mason
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    
    -- Настройка Mason
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    })
    
    -- Настройка Mason LSP Config
    mason_lspconfig.setup({
      -- Список LSP серверов для автоматической установки
      ensure_installed = {
        "lua_ls",       -- Lua
        "clangd",       -- C/C++
        "bashls",       -- Bash
      },
      -- Автоматическая настройка LSP после установки
      automatic_installation = true,
    })
    
    -- Базовые настройки LSP
    local lspconfig = require("lspconfig")
    
    -- Глобальные настройки для всех LSP
    local on_attach = function(client, bufnr)
      -- Включить completion
      client.server_capabilities.semanticTokensProvider = nil
      
      -- Горячие клавиши для LSP
      local opts = { buffer = bufnr, remap = false }
      
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
      vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
      vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
      vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
    end
    
    -- Настройки для каждого LSP сервера
    mason_lspconfig.setup_handlers({
      function(server_name)
        lspconfig[server_name].setup({
          on_attach = on_attach,
        })
      end,
      
      -- Особые настройки для Lua
      ["lua_ls"] = function()
        lspconfig.lua_ls.setup({
          on_attach = on_attach,
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" }
              }
            }
          }
        })
      end,
    })
    
    -- Горячие клавиши для Mason
    vim.keymap.set("n", "<leader>mm", ":Mason<CR>", { desc = "Open Mason" })
    vim.keymap.set("n", "<leader>mi", ":MasonInstall<CR>", { desc = "Install package" })
    vim.keymap.set("n", "<leader>mu", ":MasonUninstall<CR>", { desc = "Uninstall package" })
    vim.keymap.set("n", "<leader>ml", ":MasonLog<CR>", { desc = "Show Mason log" })
  end,
}

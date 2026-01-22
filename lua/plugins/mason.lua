return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    
    -- 1. Настройка Mason
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    })

    -- 2. Настройка Mason LSP Config (обновленная для версии 2.0+)
    mason_lspconfig.setup({
      -- Список LSP серверов для автоматической установки
      ensure_installed = {
        "lua_ls",       -- Lua
        "clangd",       -- C/C++
        "bashls",       -- Bash
      },
      -- Автоматическая настройка LSP после установки (новый формат)
      automatic_enable = true,
    })
    
    -- 3. Базовые настройки LSP (новый API для Neovim 0.11+)
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
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "<leader>rr", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
    end
    
    -- 4. Настройки для каждого LSP сервера (новый подход)
    -- Вместо setup_handlers используем vim.lsp.config для каждого сервера
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    
    -- Общие настройки для всех серверов
    vim.lsp.config('*', {
      on_attach = on_attach,
      capabilities = capabilities,
    })
    
    -- Особые настройки для Lua (отдельный вызов vim.lsp.config)
    vim.lsp.config('lua_ls', {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" }
          }
        }
      }
    })
    
    -- Настройки для clangd (если нужны особые параметры)
    vim.lsp.config('clangd', {
      on_attach = on_attach,
      capabilities = capabilities,
      -- Добавьте здесь особые настройки для clangd
    })
    
    -- Настройки для bashls (если нужны особые параметры)
    vim.lsp.config('bashls', {
      on_attach = on_attach,
      capabilities = capabilities,
      -- Добавьте здесь особые настройки для bashls
    })
    
    -- 5. Горячие клавиши для Mason (сохранены без изменений)
    vim.keymap.set("n", "<leader>mm", ":Mason<CR>", { desc = "Open Mason" })
    vim.keymap.set("n", "<leader>mi", ":MasonInstall<CR>", { desc = "Install package" })
    vim.keymap.set("n", "<leader>mu", ":MasonUninstall<CR>", { desc = "Uninstall package" })
    vim.keymap.set("n", "<leader>ml", ":MasonLog<CR>", { desc = "Show Mason log" })
  end,
}

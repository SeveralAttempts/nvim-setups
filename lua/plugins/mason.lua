return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },

  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")

    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    -- LSP-серверы
    mason_lspconfig.setup({
      ensure_installed = {
        "lua_ls",
        "clangd",
        "bashls",
      },

      automatic_enable = true,
    })

    local on_attach = function(client, bufnr)
      local opts = {
        buffer = bufnr,
        remap = false,
      }

      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

      vim.keymap.set(
        "n",
        "<leader>vws",
        vim.lsp.buf.workspace_symbol,
        opts
      )

      vim.keymap.set(
        "n",
        "<leader>vd",
        vim.diagnostic.open_float,
        opts
      )

      vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)

      vim.keymap.set(
        "n",
        "<leader>ca",
        vim.lsp.buf.code_action,
        opts
      )

      vim.keymap.set(
        "n",
        "<leader>rr",
        vim.lsp.buf.references,
        opts
      )

      vim.keymap.set(
        "n",
        "<leader>rn",
        vim.lsp.buf.rename,
        opts
      )

      vim.keymap.set(
        "i",
        "<C-h>",
        vim.lsp.buf.signature_help,
        opts
      )

      -- Форматирование текущего файла
      vim.keymap.set(
        "n",
        "<leader>f",
        function()
          vim.lsp.buf.format({
            async = true,
          })
        end,
        {
          buffer = bufnr,
          desc = "Format file",
        }
      )
    end

    local capabilities =
      vim.lsp.protocol.make_client_capabilities()

    vim.lsp.config("*", {
      on_attach = on_attach,
      capabilities = capabilities,
    })

    vim.lsp.config("lua_ls", {
      on_attach = on_attach,
      capabilities = capabilities,

      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
        },
      },
    })

    -- C / C++
    vim.lsp.config("clangd", {
      on_attach = on_attach,
      capabilities = capabilities,

      cmd = {
        "clangd",

        -- Более удобное автодополнение
        "--completion-style=detailed",

        -- Показывать типы прямо в коде
        "--inlay-hints",

        -- Автоматически добавлять include при completion
        "--header-insertion=iwyu",

        -- Параллельная индексация проекта
        "--background-index",

        -- clang-tidy диагностика
        "--clang-tidy",
      },
    })

    vim.lsp.config("bashls", {
      on_attach = on_attach,
      capabilities = capabilities,
    })

    -- Mason
    vim.keymap.set(
      "n",
      "<leader>mm",
      ":Mason<CR>",
      { desc = "Open Mason" }
    )

    vim.keymap.set(
      "n",
      "<leader>mi",
      ":MasonInstall<CR>",
      { desc = "Install package" }
    )

    vim.keymap.set(
      "n",
      "<leader>mu",
      ":MasonUninstall<CR>",
      { desc = "Uninstall package" }
    )

    vim.keymap.set(
      "n",
      "<leader>ml",
      ":MasonLog<CR>",
      { desc = "Show Mason log" }
    )
  end,
}

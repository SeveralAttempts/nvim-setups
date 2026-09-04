return {
  "nvim-treesitter/nvim-treesitter",

  lazy = false,
  build = ":TSUpdate",

  config = function()
    local treesitter = require("nvim-treesitter")

    treesitter.setup()

    treesitter.install({
      "lua",
      "python",
      "c_sharp",
      "rust",
      "javascript",
      "typescript",
      "html",
      "css",
      "json",
      "yaml",
      "bash",
      "markdown",
      "vim",
      "regex",
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "lua",
        "python",
        "cs",
        "rust",
        "javascript",
        "typescript",
        "typescriptreact",
        "javascriptreact",
        "html",
        "css",
        "json",
        "yaml",
        "sh",
        "bash",
        "markdown",
        "vim",
      },

      callback = function()
        vim.treesitter.start()

        -- Treesitter indentation
        vim.bo.indentexpr =
          "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}

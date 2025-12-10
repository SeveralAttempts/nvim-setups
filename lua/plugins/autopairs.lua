return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {
    check_ts = true, -- Использовать Treesitter
    disable_filetype = { "TelescopePrompt", "spectre_panel" },
  },
}

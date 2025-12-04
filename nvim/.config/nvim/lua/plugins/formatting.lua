return {
  {
    "stevearc/conform.nvim",
    dependencies = { "zapling/mason-conform.nvim" },
    config = function()
      require("conform").setup {
        -- Define your formatters
        formatters_by_ft = {
          lua = { "stylua", lsp_format = "fallback" },
          python = { "black", lsp_format = "fallback" },
          typescript = { "prettier", lsp_format = "fallback" },
          javascript = { "prettier", lsp_format = "fallback" },
        },
        default_format_opts = {
          lsp_format = "fallback",
        },
        format_on_save = { timeout_ms = 500 },
      }
      require("mason-conform").setup()
    end,
  },
}

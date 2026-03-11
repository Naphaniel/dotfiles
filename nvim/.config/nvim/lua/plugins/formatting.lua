return {
  {
    "stevearc/conform.nvim",
    dependencies = { "zapling/mason-conform.nvim" },
    config = function()
      require("conform").setup {
        -- Define your formatters
        formatters_by_ft = {
          lua = { "stylua", lsp_format = "fallback" },
          python = { "ruff_format", lsp_format = "fallback" },
          fish = { "fish_indent", lsp_format = "fallback" },
          quarto = { "injected" },
        },
        default_format_opts = {
          lsp_format = "fallback",
        },
        format_on_save = { timeout_ms = 500 },
      }

      require("conform").formatters.injected = {
        options = {
          ignore_errors = false,
          lang_to_ext = {
            python = "py",
          },
          lang_to_formatters = {
            python = { "ruff_format" },
          },
        },
      }

      vim.keymap.set({ "n", "v" }, "<leader>rf", function()
        require("conform").format {
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        }
      end, { desc = "Format file or range (in visual mode)" })

      require("mason-conform").setup()
    end,
  },
}

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      { "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      require("mason-lspconfig").setup {
        automatic_installation = true,
      }

      require("lspconfig").lua_ls.setup { capabilities = capabilities }
      require("lspconfig").pyright.setup { capabilities = capabilities }
      require("lspconfig").ts_ls.setup { capabilities = capabilities }

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function()
          vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions, { buffer = 0 })
          vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, { buffer = 0 })
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
          vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = 0 })
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
          vim.keymap.set("n", "gca", vim.lsp.buf.code_action, { buffer = 0 })
          vim.keymap.set("n", "gs", require("telescope.builtin").lsp_document_symbols, { buffer = 0 })
        end,
      })

      require("lsp_lines").setup()
    end,
  },
}

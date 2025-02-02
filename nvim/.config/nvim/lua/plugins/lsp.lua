return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
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

      require("mason").setup()

      require("mason-lspconfig").setup({
        automatic_installation = true,
      })

      require("lspconfig").lua_ls.setup { capabilities = capabilities }
      require("lspconfig").pyright.setup { capabilities = capabilities }

      vim.diagnostic.config {
        virtual_text = true,
      }

      vim.keymap.set("n", "<space>k", function()
        vim.diagnostic.open_float()
      end)
    end,
  },
}

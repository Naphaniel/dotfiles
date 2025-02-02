return {
  {
    "mfussenegger/nvim-lint",
    dependencies = { "rshkarin/mason-nvim-lint", "williamboman/mason.nvim" },
    config = function()
      require("lint").linters_by_ft = {
        lua = { "luacheck" },
        python = { "pylint" },
      }
      require("mason-nvim-lint").setup()
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },
}

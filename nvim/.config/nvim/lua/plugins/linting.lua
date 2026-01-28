return {
  {
    "mfussenegger/nvim-lint",
    dependencies = { "rshkarin/mason-nvim-lint" },
    config = function()
      require("lint").linters_by_ft = {
        lua = { "luacheck" },
        python = { "ruff" },
        yaml = { "yamllint" },
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

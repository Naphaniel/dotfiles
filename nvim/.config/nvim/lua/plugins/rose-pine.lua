return {
  {
    "rose-pine/neovim",
    config = function()
      require("rose-pine").setup({
        variant = "main",
        styles = {
          italic = false
        }
      })
      vim.cmd.colorscheme("rose-pine")
    end
  }
}

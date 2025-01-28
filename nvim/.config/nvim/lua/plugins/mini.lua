return {
  {
    "echasnovski/mini.nvim",
    lazy = false,
    config = function()
      local statusline = require("mini.statusline")
      statusline.setup({ use_icons = true })

      require("mini.pairs").setup()
      require("mini.icons").setup()
    end
  }
}

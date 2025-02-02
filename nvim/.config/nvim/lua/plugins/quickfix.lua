return {
  {
    "stevearc/quicker.nvim",
    event = "FileType qf",
    opts = {},
    config = function()
      require("quicker").setup {
        borders = {
          vert = "│",
          -- Strong headers separate results from different files
          strong_header = "─",
          strong_cross = "┼",
          strong_end = "┤",
          -- Soft headers separate results within the same file
          soft_header = "╌",
          soft_cross = "┼",
          soft_end = "┤",
        },
        keys = {
          {
            ">",
            function()
              require("quicker").expand { before = 2, after = 2, add_to_existing = true }
            end,
            desc = "Expand quickfix context",
          },
          {
            "<",
            function()
              require("quicker").collapse()
            end,
            desc = "Collapse quickfix context",
          },
        },
      }

      vim.keymap.set("n", "<leader>q", function()
        require("quicker").toggle()
      end, {
        desc = "Toggle quickfix",
      })
      vim.keymap.set("n", "<leader>l", function()
        require("quicker").toggle { loclist = true }
      end, {
        desc = "Toggle loclist",
      })
    end,
  },
}

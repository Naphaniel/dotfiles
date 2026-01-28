return {

  { -- requires plugins in lua/plugins/treesitter.lua and lua/plugins/lsp.lua
    -- for complete functionality (language features)
    "quarto-dev/quarto-nvim",
    dev = false,
    opts = {
      lspFeatures = {
        enabled = true,
        chunks = "curly",
      },
      codeRunner = {
        enabled = true,
        default_method = "slime",
      },
    },
    dependencies = {
      -- for language features in code cells
      -- configured in lua/plugins/lsp.lua
      "jmbuhr/otter.nvim",
    },
    config = function()
      require("quarto").setup()

      vim.keymap.set("n", "<leader>qp", require("quarto").quartoPreview, { silent = true, noremap = true })
      vim.keymap.set("n", "<leader>qu", require("quarto").quartoUpdatePreview, { silent = true, noremap = true })
      vim.keymap.set("n", "<leader>qc", require("quarto").quartoClosePreview, { silent = true, noremap = true })
      vim.keymap.set("n", "<leader>qs", require("quarto").quartoSend, { silent = true, noremap = true })
      vim.keymap.set("n", "<leader>qsa", require("quarto").quartoSendAbove, { silent = true, noremap = true })
      vim.keymap.set("n", "<leader>qsb", require("quarto").quartoSendBelow, { silent = true, noremap = true })

      local function new_terminal_python()
        vim.cmd "vsplit term://python"
      end

      vim.keymap.set("n", "<leader>qnt", new_terminal_python, { silent = true, noremap = true })

      local is_code_chunk = function(lang)
        local current = require("otter.keeper").get_current_language_context()
        if current == lang then
          return true
        else
          return false
        end
      end

      local insert_a_code_chunk = function(lang, curly)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "n", true)
        local keys
        if curly == nil then
          curly = true
        end
        if is_code_chunk(lang) then
          if curly then
            keys = [[o```<cr><cr>```{]] .. lang .. [[}<esc>o]]
          else
            keys = [[o```<cr><cr>```]] .. lang .. [[<esc>o]]
          end
        else
          if curly then
            keys = [[o```{]] .. lang .. [[}<cr>```<esc>O]]
          else
            keys = [[o```]] .. lang .. [[<cr>```<esc>O]]
          end
        end
        keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
        vim.api.nvim_feedkeys(keys, "n", false)
      end

      local insert_code_chunk = function(lang)
        insert_a_code_chunk(lang, true)
      end

      local insert_py_chunk = function()
        insert_code_chunk "python"
      end

      vim.keymap.set("n", "<leader>qic", insert_py_chunk, { silent = true, noremap = true })
    end,
  },

  { -- directly open ipynb files as quarto docuements
    -- and convert back behind the scenes
    "GCBallesteros/jupytext.nvim",
    opts = {
      custom_language_formatting = {
        python = {
          extension = "qmd",
          style = "quarto",
          force_ft = "quarto",
        },
        r = {
          extension = "qmd",
          style = "quarto",
          force_ft = "quarto",
        },
      },
    },
  },

  { -- send code from python/r/qmd documets to a terminal or REPL
    -- like ipython, R, bash
    "jpalardy/vim-slime",
    dev = false,
    init = function()
      vim.b["quarto_is_python_chunk"] = false
      Quarto_is_in_python_chunk = function()
        require("otter.tools.functions").is_otter_language_context "python"
      end

      vim.cmd [[
      let g:slime_dispatch_ipython_pause = 100
      function SlimeOverride_EscapeText_quarto(text)
      call v:lua.Quarto_is_in_python_chunk()
      if exists('g:slime_python_ipython') && len(split(a:text,"\n")) > 1 && b:quarto_is_python_chunk && !(exists('b:quarto_is_r_mode') && b:quarto_is_r_mode)
      return ["%cpaste -q\n", g:slime_dispatch_ipython_pause, a:text, "--", "\n"]
      else
      if exists('b:quarto_is_r_mode') && b:quarto_is_r_mode && b:quarto_is_python_chunk
      return [a:text, "\n"]
      else
      return [a:text]
      end
      end
      endfunction
      ]]

      vim.g.slime_target = "neovim"
      vim.g.slime_no_mappings = true
      vim.g.slime_python_ipython = 1
    end,
    config = function()
      vim.g.slime_input_pid = false
      vim.g.slime_suggest_default = true
      vim.g.slime_menu_config = false
      vim.g.slime_neovim_ignore_unlisted = true

      local function mark_terminal()
        local job_id = vim.b.terminal_job_id
        vim.print("job_id: " .. job_id)
      end

      local function set_terminal()
        vim.fn.call("slime#config", {})
      end
      vim.keymap.set("n", "<leader>cm", mark_terminal, { desc = "[m]ark terminal" })
      vim.keymap.set("n", "<leader>cs", set_terminal, { desc = "[s]et terminal" })
    end,
  },

  { -- paste an image from the clipboard or drag-and-drop
    "HakonHarnes/img-clip.nvim",
    event = "BufEnter",
    ft = { "markdown", "quarto", "latex" },
    opts = {
      default = {
        dir_path = "img",
        drag_and_drop = {
          enabled = false,
          insert_mode = false,
        },
      },
      filetypes = {
        markdown = {
          url_encode_path = true,
          template = "![$CURSOR]($FILE_PATH)",
          drag_and_drop = {
            download_images = false,
          },
        },
        quarto = {
          url_encode_path = true,
          template = "![$CURSOR]($FILE_PATH)",
          drag_and_drop = {
            download_images = false,
          },
        },
      },
    },
    config = function(_, opts)
      require("img-clip").setup(opts)
      vim.keymap.set("n", "<leader>ii", ":PasteImage<cr>", { desc = "insert [i]mage from clipboard" })
    end,
  },

  { -- preview equations
    "jbyuki/nabla.nvim",
    keys = {
      { "<leader>qm", ':lua require"nabla".toggle_virt()<cr>', desc = "toggle [m]ath equations" },
    },
  },
}

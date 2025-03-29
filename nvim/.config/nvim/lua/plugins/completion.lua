return {
  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets", "xzbdmw/colorful-menu.nvim" },
    version = "*",

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { preset = "default" },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      signature = { enabled = true, window = { show_documentation = false } },
      completion = {
        ghost_text = {
          enabled = false,
        },
        documentation = { auto_show = true },
        menu = {
          auto_show = true,
          draw = {
            columns = { { "kind_icon" }, { "label", gap = 1 } },
            components = {
              label = {
                text = function(ctx)
                  return require("colorful-menu").blink_components_text(ctx)
                end,
                highlight = function(ctx)
                  return require("colorful-menu").blink_components_highlight(ctx)
                end,
              },
            },
          },
        },
      },
    },
  },
}

return {
  "akinsho/bufferline.nvim",
  config = function()
    require("bufferline").setup({
      options = {
        style = "minimal",
        indicator = {
          style = "none",
        },
        buffer_close_icon = "",
        close_icon = "",
        diagnostics = false,
        always_show_bufferide = true,
        separator_style = "thin",
      },
      highlights = {
        buffer_selected = {
          bg = "green",
          fg = "black",
          bold = false,
          italic = false,
        },
        buffer_visible = {
          bg = "normal",
          fg = "gray",
        },
        separator = {
          fg = "bg",
          bg = "bg",
        },
        separator_selected = {
          fg = "bg",
          bg = "bg",
        },
        separator_visible = {
          fg = "bg",
          bg = "bg",
        },
        fill = {
          bg = "bg",
        },
      },
    })
  end,
}
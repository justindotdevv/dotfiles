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
          fg = "#6b7280",
        },
      },
    })
  end,
}
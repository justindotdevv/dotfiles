return {
  "akinsho/bufferline.nvim",
  config = function()
    require("bufferline").setup({
      options = {
        separator_style = { "", "" },
        show_close_icon = false,
        show_buffer_close_icons = false,
        indicator = { style = "none" },
      },
      highlights = function()
        return {
          fill = { bg = fg },
        }
      end,
    })
  end,
}

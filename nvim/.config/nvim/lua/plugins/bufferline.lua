return {
  "akinsho/bufferline.nvim",
  config = function()
    require("bufferline").setup({
      options = {
        style = "minimal",
      },
      highlights = {
        buffer_selected = {
          bg = "green",
          fg = "black",
        },
      },
    })
  end,
}


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
      highlights = {
        fill = { bg = "NONE" },
        background = { bg = "NONE", bold = false, italic = false },
        buffer_selected = { bg = { attribute = "bg", highlight = "Visual" }, bold = true, italic = false },
        tab = { bg = "NONE" },
        tab_selected = { bg = { attribute = "bg", highlight = "Visual" }, bold = true },
        tab_separator = { fg = "NONE", bg = "NONE" },
        tab_separator_selected = { fg = "NONE", bg = { attribute = "bg", highlight = "Visual" } },
        separator = { fg = "NONE", bg = "NONE" },
        separator_selected = { fg = "NONE", bg = { attribute = "bg", highlight = "Visual" } },
        modified = { bg = "NONE" },
        modified_selected = { bg = { attribute = "bg", highlight = "Visual" } },
        duplicate = { bg = "NONE", italic = true },
        duplicate_selected = { bg = { attribute = "bg", highlight = "Visual" }, italic = true },
      },
    })
  end,
}

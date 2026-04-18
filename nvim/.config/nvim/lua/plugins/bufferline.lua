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
        local accent = "#879a39"
        local fg = "#100f0f"
        local selected = { bg = accent, fg = fg, bold = true, italic = false }
        return {
          fill = { bg = fg },
          background = { bg = { attribute = "bg", highlight = "Normal" }, bold = false, italic = false },
          buffer_selected = selected,
          tab = { bg = { attribute = "bg", highlight = "Normal" } },
          tab_selected = selected,
          tab_separator = { fg = { attribute = "bg", highlight = "Normal" }, bg = { attribute = "bg", highlight = "Normal" } },
          tab_separator_selected = { fg = accent, bg = accent },
          separator = { fg = { attribute = "bg", highlight = "Normal" }, bg = { attribute = "bg", highlight = "Normal" } },
          separator_selected = { fg = accent, bg = accent },
          modified = { bg = { attribute = "bg", highlight = "Normal" } },
          modified_selected = { bg = accent, fg = fg },
          duplicate = { bg = { attribute = "bg", highlight = "Normal" }, italic = true },
          duplicate_selected = { bg = accent, fg = fg, italic = true },
        }
      end,
    })
  end,
}

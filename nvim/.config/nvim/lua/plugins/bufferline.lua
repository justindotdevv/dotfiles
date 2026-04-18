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
        local accent_bg = { attribute = "fg", highlight = "Function" }
        local accent_fg = { attribute = "bg", highlight = "Normal" }
        local selected = { bg = accent_bg, fg = accent_fg, bold = true, italic = false }
        return {
          fill = { bg = { attribute = "bg", highlight = "Normal" } },
          background = { bg = { attribute = "bg", highlight = "Normal" }, bold = false, italic = false },
          buffer_selected = selected,
          tab = { bg = { attribute = "bg", highlight = "Normal" } },
          tab_selected = selected,
          tab_separator = { fg = { attribute = "bg", highlight = "Normal" }, bg = { attribute = "bg", highlight = "Normal" } },
          tab_separator_selected = { fg = accent_bg, bg = accent_bg },
          separator = { fg = { attribute = "bg", highlight = "Normal" }, bg = { attribute = "bg", highlight = "Normal" } },
          separator_selected = { fg = accent_bg, bg = accent_bg },
          modified = { bg = { attribute = "bg", highlight = "Normal" } },
          modified_selected = { bg = accent_bg, fg = accent_fg },
          duplicate = { bg = { attribute = "bg", highlight = "Normal" }, italic = true },
          duplicate_selected = { bg = accent_bg, fg = accent_fg, italic = true },
        }
      end,
    })
  end,
}

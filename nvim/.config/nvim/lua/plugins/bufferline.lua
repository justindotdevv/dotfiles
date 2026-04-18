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
        local normal_bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg or 0
        local fn_fg = vim.api.nvim_get_hl(0, { name = "Function" }).fg or 0
        local function blend(fg, bg, alpha)
          local r = math.floor(bit.rshift(fg, 16) * alpha + bit.rshift(bg, 16) * (1 - alpha))
          local g = math.floor(bit.band(bit.rshift(fg, 8), 0xFF) * alpha + bit.band(bit.rshift(bg, 8), 0xFF) * (1 - alpha))
          local b = math.floor(bit.band(fg, 0xFF) * alpha + bit.band(bg, 0xFF) * (1 - alpha))
          return string.format("#%02x%02x%02x", r, g, b)
        end
        local muted = blend(fn_fg, normal_bg, 0.25)
        local accent_fg = { attribute = "fg", highlight = "Normal" }
        local selected = { bg = muted, fg = accent_fg, bold = true, italic = false }
        return {
          fill = { bg = { attribute = "bg", highlight = "Normal" } },
          background = { bg = { attribute = "bg", highlight = "Normal" }, bold = false, italic = false },
          buffer_selected = selected,
          tab = { bg = { attribute = "bg", highlight = "Normal" } },
          tab_selected = selected,
          tab_separator = { fg = { attribute = "bg", highlight = "Normal" }, bg = { attribute = "bg", highlight = "Normal" } },
          tab_separator_selected = { fg = muted, bg = muted },
          separator = { fg = { attribute = "bg", highlight = "Normal" }, bg = { attribute = "bg", highlight = "Normal" } },
          separator_selected = { fg = muted, bg = muted },
          modified = { bg = { attribute = "bg", highlight = "Normal" } },
          modified_selected = { bg = muted, fg = accent_fg },
          duplicate = { bg = { attribute = "bg", highlight = "Normal" }, italic = true },
          duplicate_selected = { bg = muted, fg = accent_fg, italic = true },
        }
      end,
    })
  end,
}

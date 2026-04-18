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
        local function blend(c1, c2, alpha)
          local r = math.floor(bit.rshift(c1, 16) * alpha + bit.rshift(c2, 16) * (1 - alpha))
          local g = math.floor(bit.band(bit.rshift(c1, 8), 0xFF) * alpha + bit.band(bit.rshift(c2, 8), 0xFF) * (1 - alpha))
          local b = math.floor(bit.band(c1, 0xFF) * alpha + bit.band(c2, 0xFF) * (1 - alpha))
          return string.format("#%02x%02x%02x", r, g, b)
        end
        local accent = blend(fn_fg, normal_bg, 0.25)
        local nbg = string.format("#%06x", normal_bg)
        local selected = { bg = accent, fg = { attribute = "fg", highlight = "Normal" }, bold = true, italic = false }
        return {
          fill = { bg = nbg },
          background = { bg = nbg, bold = false, italic = false },
          buffer_selected = selected,
          tab = { bg = nbg },
          tab_selected = selected,
          tab_separator = { fg = nbg, bg = nbg },
          tab_separator_selected = { fg = accent, bg = accent },
          separator = { fg = nbg, bg = nbg },
          separator_selected = { fg = accent, bg = accent },
          modified = { bg = nbg },
          modified_selected = { bg = accent, fg = { attribute = "fg", highlight = "Normal" } },
          duplicate = { bg = nbg, italic = true },
          duplicate_selected = { bg = accent, fg = { attribute = "fg", highlight = "Normal" }, italic = true },
        }
      end,
    })
  end,
}

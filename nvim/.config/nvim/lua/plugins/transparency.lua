-- transparent backgrounds for all UI elements
return {
  {
    "LazyVim/LazyVim",
    opts = function()
      -- set transparent backgrounds after colorscheme loads
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          local groups = {
            -- core
            "Normal",
            "NormalFloat",
            "FloatBorder",
            "Pmenu",
            "Terminal",
            "EndOfBuffer",
            "FoldColumn",
            "Folded",
            "SignColumn",
            "LineNr",
            "CursorLineNr",
            "NormalNC",
            -- which-key
            "WhichKeyFloat",
            -- telescope
            "TelescopeBorder",
            "TelescopeNormal",
            "TelescopePromptBorder",
            "TelescopePromptTitle",
            -- neo-tree
            "NeoTreeNormal",
            "NeoTreeNormalNC",
            "NeoTreeVertSplit",
            "NeoTreeWinSeparator",
            "NeoTreeEndOfBuffer",
            -- nvim-tree
            "NvimTreeNormal",
            "NvimTreeVertSplit",
            "NvimTreeEndOfBuffer",
            -- notify
            "NotifyINFOBody",
            "NotifyERRORBody",
            "NotifyWARNBody",
            "NotifyTRACEBody",
            "NotifyDEBUGBody",
            "NotifyINFOTitle",
            "NotifyERRORTitle",
            "NotifyWARNTitle",
            "NotifyTRACETitle",
            "NotifyDEBUGTitle",
            "NotifyINFOBorder",
            "NotifyERRORBorder",
            "NotifyWARNBorder",
            "NotifyTRACEBorder",
            "NotifyDEBUGBorder",
          }
          for _, group in ipairs(groups) do
            vim.api.nvim_set_hl(0, group, { bg = "none" })
          end
        end,
      })
    end,
  },
}

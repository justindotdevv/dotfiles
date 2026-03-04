return {
  -- Noice uses nui.nvim and doesn't read vim.o.winborder,
  -- so we enable the lsp_doc_border preset explicitly.
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        lsp_doc_border = true,
      },
    },
  },
}

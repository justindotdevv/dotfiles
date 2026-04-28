-- Disable diagnostics for markdown files (e.g. noisy MD013/line-length warnings)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "markdown.mdx" },
  callback = function(args)
    vim.diagnostic.enable(false, { bufnr = args.buf })
  end,
})

return {}

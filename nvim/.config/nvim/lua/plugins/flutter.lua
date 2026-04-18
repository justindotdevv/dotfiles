return {
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
    },
    opts = {
      ui = {
        border = "rounded",
      },
      decorations = {
        statusline = {
          app_version = true,
          device = true,
        },
      },
      widget_guides = {
        enabled = true,
      },
      closing_tags = {
        enabled = true,
      },
      lsp = {
        color = {
          enabled = true,
          virtual_text = true,
        },
        settings = {
          showTodos = true,
          completeFunctionCalls = true,
          renameFilesWithClasses = "prompt",
          enableSnippets = true,
          updateImportsOnRename = true,
        },
      },
      debugger = {
        enabled = false,
        run_via_dap = false,
      },
    },
    keys = {
      { "<leader>Fl", "<cmd>FlutterLogClear<cr>", desc = "Flutter Log Clear" },
      { "<leader>Fc", "<cmd>FlutterCopyProfilerUrl<cr>", desc = "Flutter Copy Profiler Url" },
      { "<leader>Fd", "<cmd>FlutterDevices<cr>", desc = "Flutter Devices" },
      { "<leader>Fe", "<cmd>FlutterEmulators<cr>", desc = "Flutter Emulators" },
      { "<leader>FR", "<cmd>FlutterReload<cr>", desc = "Flutter Reload" },
      { "<leader>Fr", "<cmd>FlutterRestart<cr>", desc = "Flutter Restart" },
      { "<leader>Fq", "<cmd>FlutterQuit<cr>", desc = "Flutter Quit" },
      { "<leader>Fn", "<cmd>FlutterRun<cr>", desc = "Flutter Run" },
      { "<leader>Ft", "<cmd>FlutterDevTools<cr>", desc = "Flutter Dev Tools" },
      { "<leader>Fo", "<cmd>FlutterOutlineToggle<cr>", desc = "Flutter Outline" },
    },
  },

  -- Dart syntax highlighting via treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "dart" },
    },
  },

  -- Add Dart to conform formatters (uses dart format)
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        dart = { "dart_format" },
      },
    },
  },
}

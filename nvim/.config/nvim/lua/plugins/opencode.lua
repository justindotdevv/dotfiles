return {
  {
    "nickjvandyke/opencode.nvim",
    version = "*", -- Latest stable release
    dependencies = {
      {
        -- `snacks.nvim` integration is recommended, but optional
        ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
        "folke/snacks.nvim",
        optional = true,
        opts = {
          input = {}, -- Enhances `ask()`
          picker = { -- Enhances `select()`
            actions = {
              opencode_send = function(...)
                return require("opencode").snacks_picker_send(...)
              end,
            },
            win = {
              input = {
                keys = {
                  ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
                },
              },
            },
          },
        },
      },
    },
    config = function()
      local opencode_port = 4892
      local opencode_pane_id = nil

      ---@type opencode.Opts
      vim.g.opencode_opts = {
        server = {
          port = opencode_port,
          start = function()
            local pane =
              vim.fn.system("tmux split-window -h -l 35% -P -F '#{pane_id}' 'opencode --port " .. opencode_port .. "'")
            opencode_pane_id = vim.trim(pane)
          end,
          stop = function()
            if opencode_pane_id then
              vim.fn.system("tmux kill-pane -t " .. opencode_pane_id)
              opencode_pane_id = nil
            end
          end,
          toggle = function()
            if opencode_pane_id then
              -- Check if pane still exists
              local exists = vim.fn.system("tmux has-session -t " .. opencode_pane_id .. " 2>/dev/null; echo $?")
              if vim.trim(exists) ~= "0" then
                opencode_pane_id = nil
              end
            end

            if opencode_pane_id then
              vim.fn.system("tmux kill-pane -t " .. opencode_pane_id)
              opencode_pane_id = nil
            else
              local pane = vim.fn.system(
                "tmux split-window -h -l 35% -P -F '#{pane_id}' 'opencode --port " .. opencode_port .. "'"
              )
              opencode_pane_id = vim.trim(pane)
            end
          end,
        },
      }

      vim.o.autoread = true -- Required for `opts.events.reload`

      -- Recommended/example keymaps
      vim.keymap.set({ "n", "x" }, "<leader>oa", function()
        require("opencode").ask("@this: ", { submit = true })
      end, { desc = "Ask opencode…" })
      vim.keymap.set({ "n", "x" }, "<leader>ox", function()
        require("opencode").select()
      end, { desc = "Execute opencode action…" })
      vim.keymap.set({ "n", "t" }, "<leader>.", function()
        require("opencode").toggle()
      end, { desc = "Toggle opencode" })

      -- vim.keymap.set({ "n", "x" }, "go", function()
      --   return require("opencode").operator("@this ")
      -- end, { desc = "Add range to opencode", expr = true })
      -- vim.keymap.set("n", "goo", function()
      --   return require("opencode").operator("@this ") .. "_"
      -- end, { desc = "Add line to opencode", expr = true })
      --
      -- vim.keymap.set("n", "<S-C-u>", function()
      --   require("opencode").command("session.half.page.up")
      -- end, { desc = "Scroll opencode up" })
      -- vim.keymap.set("n", "<S-C-d>", function()
      --   require("opencode").command("session.half.page.down")
      -- end, { desc = "Scroll opencode down" })
      --
      -- You may want these if you use the opinionated `<C-a>` and `<C-x>` keymaps above — otherwise consider `<leader>o…` (and remove terminal mode from the `toggle` keymap)
      -- vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
      -- vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
    end,
  },
}

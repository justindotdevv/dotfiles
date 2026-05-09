return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = function()
    local harpoon = require("harpoon")

    return {
      {
        "<leader>ha",
        function()
          harpoon:list():add()
        end,
        desc = "Harpoon add file",
      },
      {
        "<leader>hh",
        function()
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "Harpoon menu",
      },
      {
        "<leader>hr",
        function()
          harpoon:list():remove()
        end,
        desc = "Harpoon remove current file",
      },
      {
        "<leader>hc",
        function()
          harpoon:list():clear()
        end,
        desc = "Harpoon clear list",
      },
      {
        "<leader>hp",
        function()
          harpoon:list():prev()
        end,
        desc = "Harpoon previous file",
      },
      {
        "<leader>hn",
        function()
          harpoon:list():next()
        end,
        desc = "Harpoon next file",
      },
      {
        "<leader>1",
        function()
          harpoon:list():select(1)
        end,
        desc = "Harpoon file 1",
      },
      {
        "<leader>2",
        function()
          harpoon:list():select(2)
        end,
        desc = "Harpoon file 2",
      },
      {
        "<leader>3",
        function()
          harpoon:list():select(3)
        end,
        desc = "Harpoon file 3",
      },
      {
        "<leader>4",
        function()
          harpoon:list():select(4)
        end,
        desc = "Harpoon file 4",
      },
    }
  end,
  config = function()
    require("harpoon"):setup()
  end,
}

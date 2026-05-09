return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  keys = function()
    local harpoon = require("harpoon")

    local function toggle_telescope(harpoon_files)
      local conf = require("telescope.config").values
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers")
        .new({}, {
          prompt_title = "Harpoon",
          finder = require("telescope.finders").new_table({
            results = file_paths,
          }),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
        })
        :find()
    end

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
          toggle_telescope(harpoon:list())
        end,
        desc = "Harpoon menu (telescope)",
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

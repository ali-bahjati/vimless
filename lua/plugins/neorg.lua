return function(config)
    if type(config.plugins.neorg) == 'boolean' and not config.plugins.neorg then
        return {}
    end

    return {
      "nvim-neorg/neorg",
      lazy = false,
      dependencies = { "luarocks.nvim" },
      config = function()
        require("neorg").setup {
          load = {
            ["core.defaults"] = {}, -- Loads default behaviour
            ["core.concealer"] = {}, -- Adds pretty icons to your documents
            ['core.export'] = {},
            ["core.dirman"] = { -- Manages Neorg workspaces
              config = {
                workspaces = {
                  notes = "~/notes",
                },
                default_workspace = "notes",
              },
            },
            -- The following plugins require nvim 0.10.0+
            -- ["core.tempus"] = {},
            -- ["core.ui.calendar"] = {},
            ["core.completion"] = {
                config = {
                    engine = "nvim-cmp"
                }
            }
          },
        }

        local keymap = require 'keymap'

        keymap:registerLanguage('Neorg',  'norg')

        _G.HydraMappings.Neorg.Tasks.d = { 'Mark as Done',      function() vim.cmd "Neorg keybind norg core.qol.todo_items.todo.task_done" end,      { exit = true } }
        _G.HydraMappings.Neorg.Tasks.u = { 'Mark as Undone',    function() vim.cmd "Neorg keybind norg core.qol.todo_items.todo.task_undone" end,    { exit = true } }
        _G.HydraMappings.Neorg.Tasks.p = { 'Mark as Pending',   function() vim.cmd "Neorg keybind norg core.qol.todo_items.todo.task_pending" end,   { exit = true } }
        _G.HydraMappings.Neorg.Tasks.h = { 'Mark as On Hold',   function() vim.cmd "Neorg keybind norg core.qol.todo_items.todo.task_on_hold" end,   { exit = true } }
        _G.HydraMappings.Neorg.Tasks.i = { 'Mark as Important', function() vim.cmd "Neorg keybind norg core.qol.todo_items.todo.task_important" end, { exit = true } }
        _G.HydraMappings.Neorg.Tasks.a = { 'Mark as Ambiguous', function() vim.cmd "Neorg keybind norg core.qol.todo_items.todo.task_ambiguous" end, { exit = true } }
      end
    }
end

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

        _G.HydraMappings.Neorg.Tasks.d = { 'Mark as Done',      "<Plug>(neorg.qol.todo-items.todo.task-done)",      { exit = true } }
        _G.HydraMappings.Neorg.Tasks.u = { 'Mark as Undone',    "<Plug>(neorg.qol.todo-items.todo.task-undone)",    { exit = true } }
        _G.HydraMappings.Neorg.Tasks.p = { 'Mark as Pending',   "<Plug>(neorg.qol.todo-items.todo.task-pending)",   { exit = true } }
        _G.HydraMappings.Neorg.Tasks.h = { 'Mark as On Hold',   "<Plug>(neorg.qol.todo-items.todo.task-on-hold)",   { exit = true } }
        _G.HydraMappings.Neorg.Tasks.i = { 'Mark as Important', "<Plug>(neorg.qol.todo-items.todo.task-important)", { exit = true } }
        _G.HydraMappings.Neorg.Tasks.a = { 'Mark as Ambiguous', "<Plug>(neorg.qol.todo-items.todo.task-ambiguous)", { exit = true } }
        _G.HydraMappings.Neorg.Tasks.j = { 'Journal (today)',   function() vim.cmd "Neorg journal today" end,           { exit = true } }
      end
    }
end

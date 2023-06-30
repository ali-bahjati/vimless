return function(config)
    if type(config.plugins.lazygit) == 'boolean' and not config.plugins.lazygit then
        return {}
    end

    return {
        'kdheepak/lazygit.nvim',
        dependencies = { 
            'nvim-lua/plenary.nvim' 
        },
        config = function()
            if config.plugins.lazygit and type(config.plugins.lazygit) == 'function' then
                config.plugins.lazygit()
                return
            end

            vim.g.lazygit_floating_window_winblend       = 0
            vim.g.lazygit_floating_window_scaling_factor = 1
            vim.g.lazygit_floating_window_border_chars   = {'','', '', '', '','', '', ''}
            vim.g.lazygit_floating_window_use_plenary    = 0
            vim.g.lazygit_use_neovim_remote              = 1
        end
    }
end

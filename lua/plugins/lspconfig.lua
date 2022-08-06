return function(use)
    -- Override LSP Configuration.
    vim.diagnostic.config({
        virtual_text = false,
        underline    = false,
    })

    -- LSP Configuration.
    use { 'neovim/nvim-lspconfig',
        requires = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
        },
        config = function()
            -- Load CMP capabilities for LSP.
            local capabilities = require('cmp_nvim_lsp').update_capabilities(
                vim.lsp.protocol.make_client_capabilities()
            )

            -- Setup Mason before LSPConfig.
            require 'mason'.setup {}
            require 'mason-lspconfig'.setup {}

            -- Setup LSPConfig itself.
            require 'lspconfig'.sumneko_lua.setup {
                capabilities = capabilities,
                on_attach    = function(_client, _buffer) end,
                settings     = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT',
                        },
                        diagnostics = {
                            globals = { 'use', 'vim' },
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file('', true),
                        },
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            }

            require 'lspconfig'.clangd.setup {
                capabilities = capabilities,
                on_attach    = function(client, buffer) end,
            }

            require 'lspconfig'.hls.setup {
                capabilities = capabilities,
                on_attach    = function(client, buffer) end,
            }

            require 'lspconfig'.jedi_language_server.setup {
                capabilities = capabilities,
                on_attach    = function(client, buffer) end,
            }

            -- Sign Overrides
            local signs = {
                Error = '•',
                Warn  = '•',
                Hint  = '•',
                Info  = '•',
            }

            for type, icon in pairs(signs) do
                local hl = 'DiagnosticSign' .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
            end
        end
    }

    -- Prettier LSP Diagnostics
    use { 'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
        config = function()
            require('lsp_lines').setup()
        end,
    }
end

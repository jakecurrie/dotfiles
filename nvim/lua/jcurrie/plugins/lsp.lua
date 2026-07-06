return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "stevearc/conform.nvim",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
        require("conform").setup({
            formatters_by_ft = {
            }
        })
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require("fidget").setup({})
        require("mason").setup({
            registries = {
                "github:mason-org/mason-registry",
                "github:Crashdummyy/mason-registry", -- provides the "roslyn" package (stable, matches vscode)
            },
        })

        -- Applies to every server enabled below unless overridden per-server.
        vim.lsp.config("*", {
            capabilities = capabilities,
        })

        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "gopls",
                "vtsls",
                "basedpyright",
                "ruff",
                -- "roslyn" is not listed here; mason-lspconfig has no mapping for packages
                -- from the Crashdummyy registry, so it must be installed manually with
                -- :MasonInstall roslyn and configured separately below.
            },
            automatic_enable = true,
        })

        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    runtime = {
                        version = 'LuaJIT',
                    },
                    diagnostics = {
                        globals = { 'vim' },
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                        checkThirdParty = false,
                    },
                    format = {
                        enable = true,
                        -- The value must be a string, not a number.
                        defaultConfig = {
                            indent_style = "space",
                            indent_size = "2",
                        }
                    },
                }
            }
        })

        vim.lsp.config("zls", {
            root_dir = require("lspconfig.util").root_pattern(".git", "build.zig", "zls.json"),
            settings = {
                zls = {
                    enable_inlay_hints = true,
                    enable_snippets = true,
                    warn_style = true,
                },
            },
        })
        vim.g.zig_fmt_parse_errors = 0
        vim.g.zig_fmt_autosave = 0

        vim.lsp.config("tailwindcss", {
            filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte", "heex" },
        })

        -- roslyn is installed from the Crashdummyy custom registry, which
        -- mason-lspconfig does not have a mapping for, so automatic_enable
        -- above will never enable it. Configure and enable it directly.
        vim.lsp.config("roslyn_ls", {
            filetypes = { "cs" },
            settings = {
                ["csharp|background_analysis"] = {
                    dotnet_analyzer_diagnostics_scope = "openFiles",
                    dotnet_compiler_diagnostics_scope = "openFiles",
                },
            },
        })
        vim.lsp.enable("roslyn_ls")

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = "copilot", group_index = 2 },
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
            }, {
                { name = 'buffer' },
            })
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            severity_sort = true,
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = "",
                    [vim.diagnostic.severity.WARN] = "",
                    [vim.diagnostic.severity.INFO] = "",
                    [vim.diagnostic.severity.HINT] = "",
                },
            },
            virtual_text = {
                prefix = "●",
                spacing = 2,
            },
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}

return {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup({ })

            vim.keymap.set("n", "<leader>tt", function()
                require("trouble").toggle({ focus = true })
            end, { desc = "Toggle Trouble" })

            vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle focus=true<cr>", { desc = "Workspace Diagnostics" })

            vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>", { desc = "Buffer Diagnostics" })

            vim.keymap.set("n", "[t", function()
                require("trouble").next({skip_groups = true, jump = true});
            end, { desc = "Next Trouble Item" })

            vim.keymap.set("n", "]t", function()
                require("trouble").previous({skip_groups = true, jump = true});
            end, { desc = "Previous Trouble Item" })

        end
}

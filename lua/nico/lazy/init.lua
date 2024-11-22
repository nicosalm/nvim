return {

    {
        "vhyrro/luarocks.nvim",
        priority = 1000,
        opts = {

        }
    },

    {
        "nvim-lua/plenary.nvim",
        name = "plenary"
    },

    "wakatime/vim-wakatime",
    "andweeb/presence.nvim",
    "tpope/vim-commentary",

    {
        "smjonas/inc-rename.nvim",
        config = function()
            require("inc_rename").setup()
        end,
    },

    vim.keymap.set("n", "<leader>rn", function()
        return ":IncRename " .. vim.fn.expand("<cword>")
    end, { expr = true })

}

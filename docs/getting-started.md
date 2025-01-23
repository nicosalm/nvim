# Getting Started with Neovim

So you want to customize Neovim? Let's dive in.

# Getting Started with Neovim

## Installation

On macOS:
```bash
brew install neovim
```

On Ubuntu/Debian:
```bash
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim
```

On Arch (btw):
```bash
pacman -S neovim
```

Create your config directory:
```bash
mkdir -p ~/.config/nvim
```

## What's What

Your Neovim config lives in a bunch of Lua files. Here's how I organize mine:

```
.
├── init.lua                # The starting point
├── lua
│   └── user                # Your stuff goes here
│       ├── lazy            # Plugin configs
│       │   └── *.lua       # One file per plugin
│       ├── init.lua        # Main config
│       ├── lazy_init.lua   # Plugin manager setup
│       ├── remap.lua       # Keymaps
│       └── set.lua         # Vim settings
```

## Bootstrap Your Config

First up, create `init.lua`:
```lua
require("user")  -- or whatever you named your config folder
```

Then `lua/user/init.lua`:
```lua
require("user.set")       -- vim settings
require("user.remap")     -- keymaps
require("user.lazy_init") -- plugin stuff
```

## Plugins with Lazy

Lazy is the new hotness for Neovim plugin management. Here's how to set it up (`lazy_init.lua`):

```lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = "user.lazy",  -- where your plugin configs live
    change_detection = { notify = false }
})
```

## Plugin Config Files

Each plugin gets its own file in `lua/user/lazy/`. Here's a real example with Telescope:

```lua
-- telescope.lua
return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local builtin = require('telescope.builtin')
        -- fuzzy find files
        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        -- search git files
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
    end
}
```

## LSP Setup

Mason makes LSP setup dead simple. Drop this in `lsp.lua`:

```lua
return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
            -- languages you want support for
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "gopls",
            },
            handlers = {
                -- auto-setup each LSP
                function(server_name)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,
            }
        })
    end
}
```

## Quick Tips

- `:Lazy` opens the plugin manager
- `:Mason` installs/manages language servers
- Keep plugin configs focused - one file per plugin
- Use `vim.keymap.set()` for mappings (it's the new way)
- Need language support? Add it to `ensure_installed` and restart

## Common Tasks

Adding a plugin? Create `lua/user/lazy/your-plugin.lua` with the config and restart.

Want LSP for a new language? Add it to `ensure_installed`, run `:Mason`, and you're set.

Need new keymaps? Global ones go in `remap.lua`, plugin-specific ones in their plugin files.

That's the basics! Check out the [Lazy docs](https://github.com/folke/lazy.nvim) and [Mason docs](https://github.com/williamboman/mason.nvim) for the nitty-gritty details.

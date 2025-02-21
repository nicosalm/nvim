# Plugin Guide

## Core Plugins

### Editor Enhancement
- Treesitter: Syntax highlighting and code understanding
- LSP: Language support and code intelligence
- Mason: Automatic LSP server installation
- Telescope: Fuzzy finder and searcher
- Harpoon: File navigation and marking
- Fugitive: Git integration

### UI
- Lualine: Status line
- ZenMode: Distraction-free coding
- Twilight: Focus mode with code dimming

### Coding
- LuaSnip: Snippet engine
- Autopairs: Auto bracket pairing
- Commentary: Easy commenting
- Surround: Bracket/quote manipulation

## Adding New Plugins

1. Create `lua/user/lazy/plugin-name.lua`
2. Add configuration:
```lua
return {
    "author/plugin-name",
    config = function()
        -- setup code
    end
}
```
3. Restart Neovim

## Troubleshooting

Check `:Lazy` for plugin status
Use `:checkhealth` for diagnostics

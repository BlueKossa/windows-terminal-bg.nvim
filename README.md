# Windows Terminal Background

Neovim plugin to change the background of the windows terminal background, from within a WSL.

## Setup

Install using packer.nvim
```lua
require("Bluekossa/windows-terminal-bg.nvim")
```

For setting this up, you can pass in 3 arguments
- terminal_conf: path to your windows terminal settings.json
- bg_path: path to your background images that you want to pick from
- windows_bg_path (optional): windows path to your background images, this should get automatically parsed from bg_path

Example:
```lua
wtbg = require("wt-bg")

wtbg:setup({
    terminal_conf = "/mnt/c/Users/<windows-user>/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json",
    bg_path = "/mnt/c/Users/<windows-user>/Pictures/Wallpapers/Backgrounds/",
    windows_bg_path = "c:/Users/<windows-user>/Pictures/Wallpapers/Backgrounds/",
})

vim.keymap.set("n", "<leader>bg", function()
    local bg = vim.fn.input("Background: ")
    wtbg:set_background(bg)
end)

vim.keymap.set("n", "<leader>bo", function()
    local opacity = vim.fn.input("Opacity: ")
    wtbg:set_opacity(opacity)
end)
```

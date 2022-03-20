local core = {}

local fn = vim.fn

core.first_start = false

-- Automatically install Packer if it has not been installed yet.
function core.bootstrap()
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        core.first_start = true
        fn.system {
            "git", "clone", "--depth", "1",
            "https://github.com/wbthomason/packer.nvim",
            install_path
        }
        vim.cmd "packadd packer.nvim"
    end
end

-- Initialize impatient module, which pre-compiles and caches Lua code.
function core.init_impatient()
    local ok, _ = pcall(require, "impatient")
    if ok then
        require("impatient").enable_profile()
    end
end

-- Automatically set up your configuration after cloning packer.nvim.
function core.init_packer()
    if core.first_start then
        require("packer").sync()
    end
end

-- Source core/options.lua.
function core.init_options()
    require "core.options"
end

-- Set target colorscheme if it exists, fallback to a default Vim colorscheme.
--
-- This exists because the default-default colorscheme is maybe not your
-- cup of tea.
function core.init_colorscheme(target, backup)
    local ok, _ = pcall(vim.cmd, "colorscheme "..target)
    if not ok then
        core.target_colorscheme = target
        vim.opt.termguicolors = false
        vim.cmd ("colorscheme "..backup)
    end
end

-- Source core/keymaps.lua.
function core.init_keymaps()
    require "core.keymaps"
end

-- Source user/init.lua
function core.init_user()
    require "user"
end

-- Return a keymapper, preferably which-key.
function core.keymapper()
    local ok, key = pcall(require, "which-key")
    if ok then
        return key
    else
        print("Warning: cannot load which-key, user-mappings disabled.")
        return {
            execute = function() end,
            load = function() end,
            register = function(_, _) end,
            reset = function() end,
            setup = function() end,
            show = function() end,
            show_command = function() end,
        }
    end
end

return core

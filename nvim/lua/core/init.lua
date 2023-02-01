local core = {}

local fn = vim.fn

core.first_start = false

-- Automatically install Lazy if it has not been installed yet.
function core.bootstrap()
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
      vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath })
      vim.fn.system({ "git", "-C", lazypath, "checkout", "tags/stable" })
    end
    vim.opt.rtp:prepend(lazypath)
end

-- Source core/options.lua.
function core.init_options()
    require "core.options"
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

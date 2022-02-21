local M = {}

local fn = vim.fn

M.first_start = false

function M.bootstrap()
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        M.first_start = true
        local packer_bootstrap = fn.system {
            "git", "clone", "--depth", "1",
            "https://github.com/wbthomason/packer.nvim",
            install_path
        }
        vim.cmd "packadd packer.nvim"
    end
end

-- Automatically set up your configuration after cloning packer.nvim
function M.initialize()
    if M.first_start then
        require("packer").sync()
    end
end

function M.impatient()
    local ok, _ = pcall(require, "impatient")
    if ok then
        require("impatient").enable_profile()
    end
end

function M.options()
    require "options"
end

function M.colorscheme(target, backup)
    ok, _ = pcall(vim.cmd, "colorscheme "..target)
    if not ok then
        M.target_colorscheme = target
        vim.opt.termguicolors = false
        vim.cmd ("colorscheme "..backup)
    end
end

function M.keymaps()
    require "keymaps"
end

function M.user()
    require "user"
end

return M

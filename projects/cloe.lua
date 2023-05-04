--[[ cloe/.nvim.lua ]]

local vim = _G["vim"] or {}
local M = {}

M.project_dir = function()
    local git_root = vim.fs.find(".git", {
        upward = true,
        stop = vim.loop.os_homedir(),
        path = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
    })[1]
    if not git_root then
        return nil
    end
    return vim.fs.dirname(git_root)
end

M.package_dir = function()
    local conanfile = vim.fs.find("conanfile.py", {
        upward = true,
        stop = vim.loop.os_homedir(),
        path = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
    })[1]
    if not conanfile then
        return nil
    end
    return vim.fs.dirname(conanfile)
end

M.find_cloe_engine = function()
    local project_dir = M.project_dir() or vim.fn.getcwd()
    local cloe_engine = vim.fs.find("cloe-engine", {
        upward = false,
        path = project_dir .. "/engine/build",
    })[1]
    if not cloe_engine then
        return M.input_cloe_engine()
    end
    return cloe_engine
end

M.input_cloe_engine = function()
    return vim.fn.input("Select cloe-engine: ", vim.fn.getcwd() .. "/", "file")
end

M.setup = function()
    vim.notify("Loaded Cloe Neovim settings.")

    local dap = require("dap")

    dap.configurations.cpp = {
        {
            name = "cloe-engine",
            type = "codelldb",
            request = "launch",
            program = M.find_cloe_engine,
            cwd = function() return M.project_dir() .. "/engine" end,
            stopOnEntry = false,
            args = vim.fn.input("cloe-engine ", "-l debug run tests/"),
            runInTerminal = true,
        },

        {
            name = "cloe-engine run",
            type = "codelldb",
            request = "launch",
            program = M.find_cloe_engine,
            cwd = function() return M.project_dir() .. "/engine" end,
            stopOnEntry = false,
            args = function()
                local testfile = vim.fn.input("Select test ", M.project_dir() .. "/engine/tests/", "file")
                return { "run", testfile }
            end,
            runInTerminal = true,
        },

        {
            name = "cloe-engine version",
            type = "codelldb",
            request = "launch",
            program = M.find_cloe_engine,
            cwd = function() return M.project_dir() .. "/engine" end,
            stopOnEntry = false,
            args = { "version" },
            runInTerminal = true,
        },

        {
            name = "cloe-engine usage",
            type = "codelldb",
            request = "launch",
            program = M.find_cloe_engine,
            cwd = function() return M.project_dir() .. "/engine" end,
            stopOnEntry = false,
            args = { "usage" },
            runInTerminal = true,
        },
    }

end

if not vim.g.cloe then
    vim.g.cloe = M
    M.setup()
end

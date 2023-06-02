--[[ cloe/.nvim.lua ]]
local vim = _G["vim"] or {}
local M = {}

M.find_dir_containing = function(filename, path)
    path = path or vim.fs.dirname(vim.api.nvim_buf_get_name(0))
	local target = vim.fs.find(filename, {
		upward = true,
		stop = vim.loop.os_homedir(),
		path = path,
	})[1]
	if not target then
		return nil
	end
	return vim.fs.dirname(target)
end

-- Return the path to the most likely alternate file.
M.find_alternate_file = function(file, path)
    file = file or vim.api.nvim_buf_get_name(0)
    path = path or M.find_package_dir(vim.fs.dirname(file))

    local src_ext = file:match("[^.]+$")
    local dst_ext = ({ ["hpp"] = "cpp", ["cpp"] = "hpp" })[src_ext]
    if not dst_ext then
        return nil
    end
    local target = vim.fs.basename(file:gsub("[^.]+$", dst_ext))
    return vim.fs.find(target, { path = path })[1]
end

M.find_test_file = function(file, path)
    file = file or vim.api.nvim_buf_get_name(0)
    path = path or M.find_package_dir(vim.fs.dirname(file))

    local test_ext = file:match("_test[.]cpp$")
    local target = ""
    if test_ext then
        target = vim.fs.basename(file:gsub("_test[.]cpp", ".hpp"))
    else
        target = vim.fs.basename(file:gsub("[.][^.]+$", "_test.cpp"))
    end
    return vim.fs.find(target, { path = path })[1]
end

M.edit_alternate_file = function(opts)
    opts = opts or {}
    opts.file = opts.file or nil
    opts.split = opts.split or false
    opts.vert = opts.vert or false
    opts.finder = opts.finder or M.find_alternate_file

    local alternate = opts.finder(opts.file)
    if not alternate then
        vim.notify("No alternate file found.")
        return
    end

    if opts.split then
        if opts.vert then
            vim.cmd("vert split")
        else
            vim.cmd("split")
        end
    end
    vim.cmd.edit(alternate)
end

M.find_project_dir = function(path)
	return M.find_dir_containing(".git", path)
end

M.find_package_dir = function(path)
	return M.find_dir_containing("conanfile.py", path)
end

M.find_cloe_engine = function()
	local project_dir = M.find_project_dir() or vim.fn.getcwd()
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

M.setup_dap = function()
	local dap = require("dap")

	dap.configurations.cpp = {
		{
			name = "cloe-engine",
			type = "codelldb",
			request = "launch",
			program = M.find_cloe_engine,
			cwd = function()
				return M.find_project_dir() .. "/engine"
			end,
			stopOnEntry = false,
			args = function()
                local cmd = vim.fn.input("cloe-engine ", "-l debug run tests/")
				local args = vim.gsplit(cmd, " ")
                print(vim.inspect(args))
                return args
			end,
			runInTerminal = true,
		},

		{
			name = "cloe-engine shell",
			type = "codelldb",
			request = "launch",
			program = M.find_cloe_engine,
			cwd = function()
				return M.find_project_dir() .. "/engine"
			end,
			stopOnEntry = false,
			args = { "shell" },
			runInTerminal = true,
		},

		{
			name = "cloe-engine run",
			type = "codelldb",
			request = "launch",
			program = M.find_cloe_engine,
			cwd = function()
				return M.find_project_dir() .. "/engine"
			end,
			stopOnEntry = false,
			args = function()
				local testfile = vim.fn.input("Select test: ", M.find_project_dir() .. "/engine/tests/", "file")
				return { "run", "--allow-empty", testfile }
			end,
			runInTerminal = true,
		},

		{
			name = "cloe-engine version",
			type = "codelldb",
			request = "launch",
			program = M.find_cloe_engine,
			cwd = function()
				return M.find_project_dir() .. "/engine"
			end,
			stopOnEntry = false,
			args = { "version" },
			runInTerminal = true,
		},

		{
			name = "cloe-engine usage",
			type = "codelldb",
			request = "launch",
			program = M.find_cloe_engine,
			cwd = function()
				return M.find_project_dir() .. "/engine"
			end,
			stopOnEntry = false,
			args = { "usage" },
			runInTerminal = true,
		},
	}
end

M.setup_alternate_file = function()
    vim.api.nvim_create_user_command("CloeAlternate", M.edit_alternate_file, {})
    vim.keymap.set("n", ",a", function() M.edit_alternate_file() end, { desc = "Edit alternate file" })
    vim.keymap.set("n", ",A", function() M.edit_alternate_file({ split = true, vert = true }) end, { desc = "Edit alternate file in split" })
    vim.keymap.set("n", ",x", function() M.edit_alternate_file({ finder = M.find_test_file }) end, { desc = "Edit test file" })
    vim.keymap.set("n", ",X", function() M.edit_alternate_file({ finder = M.find_test_file, split = true, vert = true }) end, { desc = "Edit test file" })

end

M.setup_compile_commands = function(path)
    local package_dir = M.find_package_dir(path)
    if not package_dir then
        return
    end
    if vim.fn.filereadable(package_dir .. "/compile_commands.json") == 1 then
        return
    end

    -- Define a function to handle the job's output
    local function handle_output(job_id, data, event)
        if event == "exit" then
            -- Handle job exit
            -- `data` contains the exit code
        end
    end

    -- Run a system command in the background
    local command = string.format("make -C '%s' configure", package_dir)
    vim.fn.jobstart(command, {
        on_exit = function(_, data, _)
            if data ~= 0 then
                vim.notify("Package configuration failed: " .. command)
            else
                vim.notify("Package configuration complete: " .. package_dir)
            end
        end,
    })
end

M.setup_makeprg = function(path)
	local make_dir = M.find_dir_containing("Makefile", path) or "."
	vim.bo.makeprg = string.format("make -C '%s' all", make_dir)
end

M.setup = function()
    M.setup_dap()
    M.setup_alternate_file()

    M.setup_makeprg()
    M.setup_compile_commands()
	vim.api.nvim_create_autocmd({ "FileType" }, {
		pattern = { "c", "cpp" },
		callback = function()
            M.setup_makeprg()
            M.setup_compile_commands()
        end,
	})

	vim.notify("Loaded Cloe Neovim settings.")
end

if not vim.g.cloe then
	vim.g.cloe = M
	M.setup()
end

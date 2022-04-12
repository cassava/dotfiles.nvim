local utils = {}

-- @brief Return the current project directory, which is the toplevel of a Git
-- project if we are in a git project, or the CWD if not in a git project.
-- @param cwd Optional directory to start from.
utils.project_dir = function(cwd)
  local stdout, ret, _ = require("telescope.utils").get_os_command_output({"git", "rev-parse", "--show-toplevel"}, cwd)
  if ret == 0 then
    print(stdout[1])
    return stdout[1]
  else
    print(vim.fn.getcwd())
    return vim.fn.getcwd()
  end
end

utils.get_visual_selection = function()
  local mode = vim.fn.mode()
  if mode ~= "v" or mode ~= "V" or mode ~= "CTRL-V" then
    return nil
  end
  vim.cmd [[visual]]
  local _, start_row, start_col, _ = unpack(vim.fn.getpos "'<")
  local _, end_row, end_col, _ = unpack(vim.fn.getpos "'>")
  if start_row > end_row or (start_row == end_row and start_col > end_col) then
    start_row, end_row = end_row, start_row
    start_col, end_col = end_col, start_col
  end
  local lines = vim.fn.getline(start_row, end_row)
  local n = 0
  for _ in pairs(lines) do
    n = n + 1
  end
  if n <= 0 then
    return nil
  end
  lines[n] = string.sub(lines[n], 1, end_col)
  lines[1] = string.sub(lines[1], start_col)
  return table.concat(lines, "\n")
end

return utils

-- Set cursorline in insert mode and unset it when leaving.
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
    callback = function() vim.wo.cursorline = false end,
})
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
    callback = function() vim.wo.cursorline = true end,
})

-- Set redact options when editing passwords
vim.api.nvim_create_autocmd({ "VimEnter" }, {
    pattern = {
        "/dev/shm/pass.?*/?*.txt",
        "/tmp/pass.?*/?*.txt",
        vim.env.TMPDIR or "" .. "/pass.?*/?*.txt",
    },
    callback = function()
        vim.opt.backup = false
        vim.opt.writebackup = false
        vim.opt.swapfile = false
        vim.opt.viminfo = ""
        vim.opt.undofile = false

        vim.api.nvim_echo("Password redaction options set.")
        vim.g.password_redaction = 1
    end
})

-- autocmd FileType help wincmd L

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = { "Dockerfile.*" },
    callback = function() vim.bo.filetype = "dockerfile" end,
})

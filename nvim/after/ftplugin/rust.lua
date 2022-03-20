local key = require("core").keymapper()
key.register({
  [","] = {
    f = { "<cmd>RustFmt<cr>", "Format file" },
    t = { "<cmd>RustTest<cr>", "Run test under cursor" },
    T = { "<cmd>RustTest!<cr>", "Run all tests" },
  }
})

-- vim: set ts=2 sw=2:
--

local ls = require "luasnip"
local s = ls.snippet
local f = ls.function_node
local i = ls.insert_node
local fmt = require"luasnip.extras.fmt".fmt
local rep = require"luasnip.extras".rep

ls.snippets = {
  all = {
    s("uuid", {
      f(function(args) return vim.fn.trim(vim.fn.system({"uuidgen"})) end, {}),
    }),
  },

  lua = {
    s("req", fmt("local {} = require(\"{}\")", { i(1), rep(1) })),
  },
}

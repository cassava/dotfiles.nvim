-- vim: set ts=2 sw=2:
--

local ok, ls = pcall(require, "luasnip")
if not ok then
  return
end

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

  cpp = {
    s("if", fmt("if ({}) {{\n  {}\n}}\n{}", { i(1), i(2), i(0) })),
    s("ifelse", fmt("if ({}) {{\n  {}\n}} else {{\n  {}\n}}\n{}", { i(1), i(2), i(3), i(0) })),

    s("for", fmt("for ({}) {{\n  {}\n}}", { i(1), i(0) })),

    s("while", fmt("while ({}) {{\n  {}\n}}", { i(1), i(0) })),

    s("class", fmt(
      [[
        class {} {{
         public:
          {}() = default;
          ~{}() = default;
          {}
         private:
          {}
        }};
        {}
      ]],
      { i(1), rep(1), rep(1), i(2), i(3), i(0) }
    )),

    s("/**", fmt(
      [[
        /**
         * {}
         */
        {}
      ]],
      { i(1), i(0) }
    )),

    s("Apache-2.0", fmt(
      [[
        /*
         * Copyright {} {}
         *
         * Licensed under the Apache License, Version 2.0 (the "License");
         * you may not use this file except in compliance with the License.
         * You may obtain a copy of the License at
         *
         *     http://www.apache.org/licenses/LICENSE-2.0
         *
         * Unless required by applicable law or agreed to in writing, software
         * distributed under the License is distributed on an "AS IS" BASIS,
         * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
         * See the License for the specific language governing permissions and
         * limitations under the License.
         *
         * SPDX-License-Identifier: Apache-2.0
         */
         {}
      ]],
      { f(function() return os.date "%Y" end), i(1), i(0) }
    )),
  },

  lua = {
    s("req", fmt("local {} = require(\"{}\")", { i(1), rep(1) })),
  },
}

require("luasnip.session.snippet_collection").clear_snippets "python"

local ls = require "luasnip"

local s = ls.snippet
local i = ls.insert_node

local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("python", {
    s("def", fmt("def {}({}) -> {}:\n\t{}", { i(1), i(2), i(3), i(0) })),
})

return {
	s("ternary", {
		-- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
		i(1, "cond"), t(" ? "), i(2, "then"), t(" : "), i(3, "else")
	}),
}
--https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#functionnode
--https://cj.rs/blog/generating-snippets-with-luasnip/

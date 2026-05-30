return {
	s({ trig = "(", snippetType = "autosnippet", condition = tex_utils.in_mathzone },
		fmta("\\left( <> \\right)", { i(1) })
	),
	s({ trig = "[", snippetType = "autosnippet", condition = tex_utils.in_mathzone },
		fmta("\\left[ <> \\right]", { i(1) })
	),
}

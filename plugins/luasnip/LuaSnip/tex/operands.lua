return {
	s({ trig = "@.", snippetType = "autosnippet", condition = tex_utils.in_mathzone }, { t("{\\cdot}") }),
	s({ trig = "xx", snippetType = "autosnippet", condition = tex_utils.in_mathzone }, { t("{\\times}") }),
	s({ trig = ";.", snippetType = "autosnippet", condition = tex_utils.in_mathzone }, { t("{\\cdot}") }),
	s({ trig = ";>", snippetType = "autosnippet", condition = tex_utils.in_mathzone }, { t("\\rightarrow") }),
	s({ trig = ";<", snippetType = "autosnippet", condition = tex_utils.in_mathzone }, { t("\\leftarrow") }),
	s({ trig = "ss", snippetType = "autosnippet", condition = tex_utils.in_mathzone }, { t("^*") }),
	s({ trig = "'", snippetType = "snippet", condition = tex_utils.in_mathzone }, { t("^{\\prime}") }),
	s({ trig = "2'", snippetType = "autosnippet", condition = tex_utils.in_mathzone }, { t("^{\\prime\\prime}") }),
	s({ trig = "3'", snippetType = "autosnippet", condition = tex_utils.in_mathzone }, { t("^{\\prime\\prime\\prime}") }),
	s({ trig = "^", snippetType = "autosnippet", condition = tex_utils.in_mathzone },
		fmta("^{<>}", { i(1) })
	),
	s({ trig = "_", snippetType = "autosnippet", condition = tex_utils.in_mathzone },
		fmta("_{<>}", { i(1) })
	),
	s({ trig = "'u", snippetType = "autosnippet", condition = tex_utils.in_mathzone },
		fmta("\\underline{<>}", { d(1, get_visual) })
	),
	s({ trig = ";u", snippetType = "autosnippet", condition = tex_utils.in_mathzone },
		fmta("\\underline{<>}", { i(1) })
	),
	s({ trig = "'t", snippetType = "autosnippet", condition = tex_utils.in_mathzone },
		fmta("\\text{<>}", { d(1, get_visual) })
	),
	s({ trig = "tilde", snippetType = "autosnippet", condition = tex_utils.in_mathzone },
		fmta("\\tilde{<>}", { i(1) })
	),
	s({ trig = "'o", snippetType = "autosnippet", condition = tex_utils.in_mathzone },
		fmta("\\overline{<>}", { d(1, get_visual) })
	),
	s({ trig = ";o", snippetType = "autosnippet", condition = tex_utils.in_mathzone },
		fmta("\\overline{<>}", { i(1) })
	),
	s({ trig = "'c", snippetType = "autosnippet", condition = tex_utils.in_mathzone },
		fmta("\\cancel{<>}", { d(1, get_visual) })
	),
	s({ trig = "cc", condition = tex_utils.in_mathzone },
		fmta("\\cancel{<>}", { i(1) })
	),
	s({ trig = "ff", snippetType = "autosnippet", condition = tex_utils.in_mathzone },
		fmta("\\frac{<>}{<>}", { i(1), i(2) })
	),
	s({ trig = "fi", condition = tex_utils.in_mathzone },
		fmta("\\frac{<>}{<>}", { d(1, get_visual), i(2) })
	),
	s({ trig = "df", snippetType = "autosnippet", condition = tex_utils.in_mathzone },
		fmta("\\frac{\\diff <>}{\\diff <>}", { i(1), i(2) })
	),
	s({ trig = "DD", snippetType = "autosnippet", condition = tex_utils.in_mathzone },
		fmta("\\dermat{<>}{t}", { i(1) })
	),
	s({ trig = "dd", snippetType = "autosnippet", condition = tex_utils.in_mathzone }, { t("{\\diff}") }),
	s({ trig = "pp", snippetType = "autosnippet", condition = tex_utils.in_mathzone },
		fmta("\\pdev{<>}{<>}", { i(1), i(2) })
	),
	s({ trig = "dpp", snippetType = "autosnippet", condition = tex_utils.in_mathzone },
		fmta("\\pdev{^2<>}{<>^2}", { i(1), i(2) })
	),
	s({ trig = "sq", snippetType = "autosnippet", condition = tex_utils.in_mathzone },
		fmta("\\sqrt{<>}", { i(1) })
	),
	s({ trig = "'q", snippetType = "autosnippet", condition = tex_utils.in_mathzone },
		fmta("\\sqrt{<>}", { d(1, get_visual) })
	),
	s({ trig = "in", snippetType = "snippet", condition = tex_utils.in_mathzone },
		fmta("\\integral{<>}{<>}{<>}{<>}", { i(1), i(2), i(3), i(4) })
	),
	s({ trig = "sum", snippetType = "snippet", condition = tex_utils.in_mathzone },
		fmta("\\sum_{<>}^{<>}", { i(1), i(2) })
	),
	s({ trig = "cos", snippetType = "snippet", condition = tex_utils.in_mathzone },
		fmta("\\cos {<>}", { i(1) })
	),
	s({ trig = "sin", snippetType = "autosnippet", condition = tex_utils.in_mathzone },
		fmta("\\sin {<>}", { i(1) })
	),
	s({ trig = "nrmm", snippetType = "autosnippet", condition = tex_utils.in_mathzone },
		fmta("\\| <> \\|", { i(1) })
	),
	s({ trig = "dot", snippetType = "autosnippet", condition = tex_utils.in_mathzone },
		fmta("\\dot{<>}", { i(1) })
	),
}

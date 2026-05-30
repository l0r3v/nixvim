return {
	s({ trig = "ux", snippetType = "autosnippet", condition = tex_utils.in_mathzone }, { t("{u_x}") }),
	s({ trig = "uy", snippetType = "autosnippet", condition = tex_utils.in_mathzone }, { t("{u_y}") }),
	s({ trig = "uz", snippetType = "autosnippet", condition = tex_utils.in_mathzone }, { t("{u_z}") }),
	s({ trig = "ui", snippetType = "autosnippet", condition = tex_utils.in_mathzone }, { t("{u_i}") }),
	s({ trig = "uj", snippetType = "autosnippet", condition = tex_utils.in_mathzone }, { t("{u_j}") }),
	s({ trig = "xi", snippetType = "autosnippet", condition = tex_utils.in_mathzone }, { t("{x_i}") }),
	s({ trig = "xj", snippetType = "autosnippet", condition = tex_utils.in_mathzone }, { t("{x_j}") }),
	s({ trig = "tij", snippetType = "autosnippet", condition = tex_utils.in_mathzone }, { t("\\tau_{ij}") }),
	s({ trig = "dij", snippetType = "autosnippet", condition = tex_utils.in_mathzone }, { t("\\delta_{ij}") }),
	s({ trig = "sij", snippetType = "autosnippet", condition = tex_utils.in_mathzone }, { t("\\sigma_{ij}") }),
	s({ trig = "eijk", snippetType = "autosnippet", condition = tex_utils.in_mathzone }, { t("\\varepsilon_{ijk}") }),
}

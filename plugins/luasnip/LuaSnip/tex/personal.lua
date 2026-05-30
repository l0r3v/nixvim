return {
	s(
		{ trig = "fn", name = "footnote", dscr = "Footnote with optional visual text" },
		fmta("\\footnote{<>}", {
			d(1, get_visual),
		}),
		{ condition = tex_utils.in_text }
	),
	s(
		{ trig = "defb", dscr = "definitionbox environment" },
		fmta(
			[[
\begin{definitionbox}
  <>
\end{definitionbox}
]],
			{ i(1, "Definizione...") }
		)
	),
	s(
		{ trig = "exb", dscr = "examplebox environment" },
		fmta(
			[[
\begin{examplebox}
  <>
\end{examplebox}
]],
			{ i(1, "Esempio...") }
		)
	),
	s(
		{ trig = "todob", dscr = "todobox environment" },
		fmta(
			[[
\begin{todobox}
  <>
\end{todobox}
]],
			{ i(1, "TODO: ...") }
		)
	),
	s({ trig = "myn", dscr = "\\mynote{} comment" }, fmta("\\mynote{<>}", { i(1, "note...") })),
	s(
		{ trig = "sii", snippetType = "autosnippet" },
		fmta([[\si{<>}]], {
			i(1),
		})
	),
	s(
		{ trig = "SI" },
		fmta([[\SI{<>}{<>}]], {
			i(1),
			i(2),
		})
	),
	s(
		{ trig = "udd" },
		fmta([[\underline{<>}]], {
			d(1, get_visual),
		})
	),
	s(
		{ trig = "vs" },
		fmta([[\vspace{<>}]], {
			d(1, get_visual),
		})
	),
	s(
		{ trig = "h1", snippetType = "autosnippet" },
		fmta(
			[[\section{<>}
        <>]],
			{
				d(1, get_visual),
				i(2),
			}
		)
	),
	s(
		{ trig = "h2", snippetType = "autosnippet" },
		fmta(
			[[\subsection{<>}
        <>]],
			{
				d(1, get_visual),
				i(2),
			}
		)
	),
	s(
		{ trig = "h3", snippetType = "autosnippet" },
		fmta(
			[[\subsubsection{<>}
        <>]],
			{
				d(1, get_visual),
				i(2),
			}
		)
	),
	s({ trig = "pogn", snippetType = "autosnippet", condition = tex_utils.in_mathzone }, { t("\\forall") }),
	s(
		{ trig = "norm", snippetType = "autosnippet", condition = tex_utils.in_mathzone },
		fmta([[||<>||]], {
			d(1, get_visual),
		})
	),
	s({ trig = "check", snippetType = "autosnippet", condition = tex_utils.in_mathzone }, { t("\\checkmark") }),
	s({ trig = "~", snippetType = "autosnippet", condition = tex_utils.in_mathzone }, { t("\\sim") }),
	s({ trig = "cst", snippetType = "autosnippet", condition = tex_utils.in_mathzone }, { t("\\costante") }),
	s({ trig = "sr", snippetType = "autosnippet" }, { t("^2") }),
	s({ trig = "@8", snippetType = "autosnippet", condition = tex_utils.in_mathzone }, { t("\\infty") }),
	s({ trig = "ittt", snippetType = "autosnippet", condition = tex_utils.in_itemize }, { t("\\item") }),
	s(
		{ trig = "benum", dscr = "A LaTeX enumerate environment", snippetType = "autosnippet" },
		fmt(
			[[
	\begin{enumerate}
		\item <>
	\end{enumerate}
	]],
			{ i(1) },
			{ delimiters = "<>" }
		)
	),
	s(
		{ trig = "bitem", dscr = "A LaTeX itemize environment", snippetType = "autosnippet" },
		fmt(
			[[
	\begin{itemize}
		\item <>
	\end{itemize}
	]],
			{ i(1) },
			{ delimiters = "<>" }
		)
	),
	s(
		{ trig = "beq", dscr = "A LaTeX equation environment", snippetType = "autosnippet" },
		fmt(
			[[
	\begin{equation}
	  <>
	\end{equation}
	]],
			{ i(1) },
			{ delimiters = "<>" }
		)
	),
	s(
		{ trig = "gt", snippetType = "autosnippet" },
		fmta(
			[[
	\begin{gather*}
	  <>
	\end{gather*}
	]],
			{
				i(1),
			}
		)
	),
	s(
		{ trig = "env", snippetType = "autosnippet" },
		fmta(
			[[
	\begin{<>}
	  <>
	\end{<>}
	]],
			{
				i(1),
				i(2),
				rep(1),
			}
		)
	),
	s(
		{ trig = "tbb", dscr = "Expands 'tbb' into LaTeX's textbf{} command.", snippetType = "autosnippet" },
		fmta("\\textbf{<>}", {
			d(1, get_visual),
		})
	),
	s(
		{ trig = "tii", dscr = "Expands 'tii' into LaTeX's textit{} command.", snippetType = "autosnippet" },
		fmta("\\textit{<>}", {
			d(1, get_visual),
		})
	),
	s(
		{ trig = "enf", dscr = "Expands 'enf' into LaTeX's emph{} command.", snippetType = "autosnippet" },
		fmta("\\emph{<>}", {
			d(1, get_visual),
		})
	),
	s(
		{ trig = "mk", snippetType = "autosnippet" },
		fmta("$ <> $ ", {
			i(1),
		})
	),
	s(
		{ trig = "dm", snippetType = "autosnippet" },
		fmta(
			[[
	\[
	  <>
	\]
	]],
			{
				i(1),
			}
		),
		{ condition = line_begin }
	),
	s(
		{ trig = "new", dscr = "A generic new environmennt" },
		fmta(
			[[
	\begin{<>}
	  <>
	\end{<>}
	]],
			{
				i(1),
				i(2),
				rep(1),
			}
		),
		{ condition = line_begin }
	),
}

local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local get_visual = function(args, parent)
  if (#parent.snippet.env.LS_SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else  -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

-- Some LaTeX-specific conditional expansion functions (requires VimTeX)

local tex_utils = {}
tex_utils.in_mathzone = function()  -- math context detection
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end
tex_utils.in_text = function()
  return not tex_utils.in_mathzone()
end
tex_utils.in_comment = function()  -- comment detection
  return vim.fn['vimtex#syntax#in_comment']() == 1
end
tex_utils.in_env = function(name)  -- generic environment detection
    local is_inside = vim.fn['vimtex#env#is_inside'](name)
    return (is_inside[1] > 0 and is_inside[2] > 0)
end
-- A few concrete environments---adapt as needed
tex_utils.in_equation = function()  -- equation environment detection
    return tex_utils.in_env('equation')
end
tex_utils.in_itemize = function()  -- itemize environment detection
    return tex_utils.in_env('itemize')
end
tex_utils.in_tikz = function()  -- TikZ picture environment detection
    return tex_utils.in_env('tikzpicture')
end

local function make_snippet(entry)
  local snippet_opts = { trig = entry.trig, dscr = entry.dscr }
  if entry.name then
    snippet_opts.name = entry.name
  end
  if entry.snippetType then
    snippet_opts.snippetType = entry.snippetType
  end
  if entry.wordTrig ~= nil then
    snippet_opts.wordTrig = entry.wordTrig
  end
  if entry.regTrig ~= nil then
    snippet_opts.regTrig = entry.regTrig
  end
  if entry.priority ~= nil then
    snippet_opts.priority = entry.priority
  end
  if entry.hidden ~= nil then
    snippet_opts.hidden = entry.hidden
  end

  local body
  if entry.formatter then
    body = entry.formatter(entry.template, entry.nodes, entry.format_opts or {})
  else
    body = entry.nodes
  end

  local context_opts
  if entry.opts then
    context_opts = {}
    for key, value in pairs(entry.opts) do
      context_opts[key] = value
    end
  end

  if entry.condition then
    context_opts = context_opts or {}
    context_opts.condition = entry.condition
  end

  if entry.show_condition then
    context_opts = context_opts or {}
    context_opts.show_condition = entry.show_condition
  end

  if context_opts then
    return s(snippet_opts, body, context_opts)
  end

  return s(snippet_opts, body)
end

local snippet_entries = {
  {
    trig = "sii",
    dscr = "Insert a si{} command",
    snippetType = "autosnippet",
    formatter = fmta,
    template = "\si{<>}",
    nodes = {
      i(1),
    },
  },
  {
    trig = "SI",
    dscr = "Insert an SI value with units",
    formatter = fmta,
    template = "\SI{<>}{<>}",
    nodes = {
      i(1),
      i(2),
    },
  },
  {
    trig = "udd",
    dscr = "Underline selected text",
    formatter = fmta,
    template = "\underline{<>}",
    nodes = {
      d(1, get_visual),
    },
  },
  {
    trig = "vs",
    dscr = "Insert a vspace command",
    formatter = fmta,
    template = "\vspace{<>}",
    nodes = {
      d(1, get_visual),
    },
  },
  {
    trig = "h1",
    dscr = "Create a section heading",
    snippetType = "autosnippet",
    formatter = fmta,
    template = "\section{<>}\n<>",
    nodes = {
      d(1, get_visual),
      i(2),
    },
  },
  {
    trig = "h2",
    dscr = "Create a subsection heading",
    snippetType = "autosnippet",
    formatter = fmta,
    template = "\subsection{<>}\n<>",
    nodes = {
      d(1, get_visual),
      i(2),
    },
  },
  {
    trig = "h3",
    dscr = "Create a subsubsection heading",
    snippetType = "autosnippet",
    formatter = fmta,
    template = "\subsubsection{<>}\n<>",
    nodes = {
      d(1, get_visual),
      i(2),
    },
  },
  {
    trig = "pogn",
    dscr = "Insert the universal quantifier",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    nodes = {
      t("\forall"),
    },
  },
  {
    trig = "norm",
    dscr = "Create a norm with visual content",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    formatter = fmta,
    template = "||<>||",
    nodes = {
      d(1, get_visual),
    },
  },
  {
    trig = "check",
    dscr = "Insert a checkmark symbol",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    nodes = {
      t("\checkmark"),
    },
  },
  {
    trig = "~",
    dscr = "Insert a similarity symbol",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    nodes = {
      t("\sim"),
    },
  },
  {
    trig = "cst",
    dscr = "Insert the custom costante macro",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    nodes = {
      t("\costante"),
    },
  },
  {
    trig = "sr",
    dscr = "Append a squared exponent",
    snippetType = "autosnippet",
    nodes = {
      t("^2"),
    },
  },
  {
    trig = "@8",
    dscr = "Insert the infinity symbol",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    nodes = {
      t("\infty"),
    },
  },
  {
    trig = "ittt",
    dscr = "Insert a new item in itemize",
    snippetType = "autosnippet",
    condition = tex_utils.in_itemize,
    nodes = {
      t("\item"),
    },
  },
  {
    trig = "benum",
    dscr = "A LaTeX enumerate environment",
    snippetType = "autosnippet",
    formatter = fmt,
    template = "\begin{enumerate}\n        \item <>\n\end{enumerate}",
    nodes = {
      i(1),
    },
    format_opts = { delimiters = "<>" },
  },
  {
    trig = "bitem",
    dscr = "A LaTeX itemize environment",
    snippetType = "autosnippet",
    formatter = fmt,
    template = "\begin{itemize}\n        \item <>\n\end{itemize}",
    nodes = {
      i(1),
    },
    format_opts = { delimiters = "<>" },
  },
  {
    trig = "beq",
    dscr = "A LaTeX equation environment",
    snippetType = "autosnippet",
    formatter = fmt,
    template = "\begin{equation}\n  <>\n\end{equation}",
    nodes = {
      i(1),
    },
    format_opts = { delimiters = "<>" },
  },
  {
    trig = "gt",
    dscr = "A gather* environment",
    snippetType = "autosnippet",
    formatter = fmta,
    template = "\begin{gather*}\n  <>\n\end{gather*}",
    nodes = {
      i(1),
    },
  },
  {
    trig = "env",
    dscr = "A generic environment with repetition",
    snippetType = "autosnippet",
    formatter = fmta,
    template = "\begin{<>}\n  <>\n\end{<>}",
    nodes = {
      i(1),
      i(2),
      rep(1),
    },
  },
  {
    trig = "tbb",
    dscr = "Expands 'tbb' into LaTeX's textbf{} command.",
    snippetType = "autosnippet",
    formatter = fmta,
    template = "\textbf{<>}",
    nodes = {
      d(1, get_visual),
    },
  },
  {
    trig = "tii",
    dscr = "Expands 'tii' into LaTeX's textit{} command.",
    snippetType = "autosnippet",
    formatter = fmta,
    template = "\textit{<>}",
    nodes = {
      d(1, get_visual),
    },
  },
  {
    trig = "enf",
    dscr = "Expands 'enf' into LaTeX's emph{} command.",
    snippetType = "autosnippet",
    formatter = fmta,
    template = "\emph{<>}",
    nodes = {
      d(1, get_visual),
    },
  },
  {
    trig = "mk",
    dscr = "Inline math delimiters",
    snippetType = "autosnippet",
    formatter = fmta,
    template = "$ <> $ ",
    nodes = {
      i(1),
    },
  },
  {
    trig = "dm",
    dscr = "Display math environment",
    snippetType = "autosnippet",
    formatter = fmta,
    template = "\[\n  <>\n\]",
    nodes = {
      i(1),
    },
  },
  {
    trig = "new",
    dscr = "A generic new environment",
    formatter = fmta,
    template = "\begin{<>}\n  <>\n\end{<>}",
    nodes = {
      i(1),
      i(2),
      rep(1),
    },
  },
}

local snippets = {}
for _, entry in ipairs(snippet_entries) do
  table.insert(snippets, make_snippet(entry))
end

return snippets

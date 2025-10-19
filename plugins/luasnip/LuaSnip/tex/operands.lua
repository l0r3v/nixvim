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
    trig = "@.",
    dscr = "Insert a centered dot",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    nodes = {
      t("{\\cdot}"),
    },
  },
  {
    trig = "xx",
    dscr = "Insert a multiplication sign",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    nodes = {
      t("{\\times}"),
    },
  },
  {
    trig = ";.",
    dscr = "Insert a centered dot",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    nodes = {
      t("{\\cdot}"),
    },
  },
  {
    trig = ";>",
    dscr = "Insert a right arrow",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    nodes = {
      t("\\rightarrow"),
    },
  },
  {
    trig = ";<",
    dscr = "Insert a left arrow",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    nodes = {
      t("\\leftarrow"),
    },
  },
  {
    trig = "ss",
    dscr = "Insert a superscript star",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    nodes = {
      t("^*"),
    },
  },
  {
    trig = "'",
    dscr = "Insert a prime superscript",
    snippetType = "snippet",
    condition = tex_utils.in_mathzone,
    nodes = {
      t("^{\\prime}"),
    },
  },
  {
    trig = "2'",
    dscr = "Insert a double prime superscript",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    nodes = {
      t("^{\\prime\\prime}"),
    },
  },
  {
    trig = "3'",
    dscr = "Insert a triple prime superscript",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    nodes = {
      t("^{\\prime\\prime\\prime}"),
    },
  },
  {
    trig = "^",
    dscr = "Insert a superscript block",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    formatter = fmta,
    template = "^{<>}",
    nodes = {
      i(1),
    },
  },
  {
    trig = "_",
    dscr = "Insert a subscript block",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    formatter = fmta,
    template = "_{<>}",
    nodes = {
      i(1),
    },
  },
  {
    trig = "'u",
    dscr = "Underline the current selection",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    formatter = fmta,
    template = "\\underline{<>}",
    nodes = {
      d(1, get_visual),
    },
  },
  {
    trig = ";u",
    dscr = "Underline the next text",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    formatter = fmta,
    template = "\\underline{<>}",
    nodes = {
      i(1),
    },
  },
  {
    trig = "'t",
    dscr = "Wrap selection in \\text{}",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    formatter = fmta,
    template = "\\text{<>}",
    nodes = {
      d(1, get_visual),
    },
  },
  {
    trig = "tilde",
    dscr = "Insert a tilde accent",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    formatter = fmta,
    template = "\\tilde{<>}",
    nodes = {
      i(1),
    },
  },
  {
    trig = "'o",
    dscr = "Overline the current selection",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    formatter = fmta,
    template = "\\overline{<>}",
    nodes = {
      d(1, get_visual),
    },
  },
  {
    trig = ";o",
    dscr = "Overline the next text",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    formatter = fmta,
    template = "\\overline{<>}",
    nodes = {
      i(1),
    },
  },
  {
    trig = "'c",
    dscr = "Strike out the current selection",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    formatter = fmta,
    template = "\\cancel{<>}",
    nodes = {
      d(1, get_visual),
    },
  },
  {
    trig = "cc",
    dscr = "Strike out the next text",
    condition = tex_utils.in_mathzone,
    formatter = fmta,
    template = "\\cancel{<>}",
    nodes = {
      i(1),
    },
  },
  {
    trig = "ff",
    dscr = "Insert a fraction",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    formatter = fmta,
    template = "\\frac{<>}{<>}",
    nodes = {
      i(1),
      i(2),
    },
  },
  {
    trig = "fi",
    dscr = "Insert a fraction with the selection in the numerator",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    formatter = fmta,
    template = "\\frac{<>}{<>}",
    nodes = {
      d(1, get_visual),
      i(2),
    },
  },
  {
    trig = "df",
    dscr = "Insert a derivative fraction",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    formatter = fmta,
    template = "\\frac{\\diff <>}{\\diff <>}",
    nodes = {
      i(1),
      i(2),
    },
  },
  {
    trig = "DD",
    dscr = "Insert a total derivative with respect to t",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    formatter = fmta,
    template = "\\dermat{<>}{t}",
    nodes = {
      i(1),
    },
  },
  {
    trig = "dd",
    dscr = "Insert a differential operator",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    nodes = {
      t("{\\diff}"),
    },
  },
  {
    trig = "pp",
    dscr = "Insert a partial derivative",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    formatter = fmta,
    template = "\\pdev{<>}{<>}",
    nodes = {
      i(1),
      i(2),
    },
  },
  {
    trig = "dpp",
    dscr = "Insert a second-order partial derivative",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    formatter = fmta,
    template = "\\pdev{^2<>}{<>^2}",
    nodes = {
      i(1),
      i(2),
    },
  },
  {
    trig = "sq",
    dscr = "Insert a square root",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    formatter = fmta,
    template = "\\sqrt{<>}",
    nodes = {
      i(1),
    },
  },
  {
    trig = "'q",
    dscr = "Insert a square root around the selection",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    formatter = fmta,
    template = "\\sqrt{<>}",
    nodes = {
      d(1, get_visual),
    },
  },
  {
    trig = "in",
    dscr = "Insert an integral with limits",
    snippetType = "snippet",
    condition = tex_utils.in_mathzone,
    formatter = fmta,
    template = "\\integral{<>}{<>}{<>}{<>}",
    nodes = {
      i(1),
      i(2),
      i(3),
      i(4),
    },
  },
  {
    trig = "sum",
    dscr = "Insert a summation with limits",
    snippetType = "snippet",
    condition = tex_utils.in_mathzone,
    formatter = fmta,
    template = "\\sum_{<>}^{<>}",
    nodes = {
      i(1),
      i(2),
    },
  },
  {
    trig = "cos",
    dscr = "Insert a cosine expression",
    snippetType = "snippet",
    condition = tex_utils.in_mathzone,
    formatter = fmta,
    template = "\\cos {<>}",
    nodes = {
      i(1),
    },
  },
  {
    trig = "sin",
    dscr = "Insert a sine expression",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    formatter = fmta,
    template = "\\sin {<>}",
    nodes = {
      i(1),
    },
  },
  {
    trig = "nrmm",
    dscr = "Insert norm delimiters",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    formatter = fmta,
    template = "\\| <> \\|",
    nodes = {
      i(1),
    },
  },
  {
    trig = "dot",
    dscr = "Insert a dotted variable",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    formatter = fmta,
    template = "\\dot{<>}",
    nodes = {
      i(1),
    },
  },
}

local snippets = {}
for _, entry in ipairs(snippet_entries) do
  table.insert(snippets, make_snippet(entry))
end

return snippets

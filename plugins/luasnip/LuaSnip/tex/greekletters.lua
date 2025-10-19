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
    trig = "@a",
    dscr = "Insert lowercase alpha",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    priority = 100,
    regTrig = false,
    nodes = {
      t("{\\alpha}"),
    },
  },
  {
    trig = "@b",
    dscr = "Insert lowercase beta",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    nodes = {
      t("{\\beta}"),
    },
  },
  {
    trig = "@q",
    dscr = "Insert lowercase theta",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    nodes = {
      t("{\\theta}"),
    },
  },
  {
    trig = "@g",
    dscr = "Insert lowercase gamma",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    nodes = {
      t("{\\gamma}"),
    },
  },
  {
    trig = "@G",
    dscr = "Insert uppercase Gamma",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    nodes = {
      t("{\\Gamma}"),
    },
  },
  {
    trig = "@s",
    dscr = "Insert lowercase sigma",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    nodes = {
      t("{\\sigma}"),
    },
  },
  {
    trig = "@S",
    dscr = "Insert uppercase Sigma",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    nodes = {
      t("{\\Sigma}"),
    },
  },
  {
    trig = "@p",
    dscr = "Insert lowercase pi",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    nodes = {
      t("{\\pi}"),
    },
  },
  {
    trig = "@P",
    dscr = "Insert uppercase Pi",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    nodes = {
      t("{\\Pi}"),
    },
  },
  {
    trig = "@h",
    dscr = "Insert lowercase eta",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    nodes = {
      t("{\\eta}"),
    },
  },
  {
    trig = "@r",
    dscr = "Insert lowercase rho",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    nodes = {
      t("{\\rho}"),
    },
  },
  {
    trig = "@D",
    dscr = "Insert uppercase Delta",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    nodes = {
      t("{\\Delta}"),
    },
  },
  {
    trig = "@d",
    dscr = "Insert lowercase delta",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    nodes = {
      t("{\\delta}"),
    },
  },
  {
    trig = "@t",
    dscr = "Insert lowercase tau",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    nodes = {
      t("{\\tau}"),
    },
  },
  {
    trig = "@v",
    dscr = "Insert lowercase nu",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    nodes = {
      t("{\\nu}"),
    },
  },
  {
    trig = "@w",
    dscr = "Insert lowercase psi",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    nodes = {
      t("{\\psi}"),
    },
  },
  {
    trig = "@o",
    dscr = "Insert lowercase omega",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    nodes = {
      t("{\\omega}"),
    },
  },
  {
    trig = "@O",
    dscr = "Insert uppercase Omega",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    nodes = {
      t("{\\Omega}"),
    },
  },
  {
    trig = "@e",
    dscr = "Insert lowercase varepsilon",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    nodes = {
      t("{\\varepsilon}"),
    },
  },
  {
    trig = "@f",
    dscr = "Insert lowercase phi",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    nodes = {
      t("{\\phi}"),
    },
  },
  {
    trig = "@x",
    dscr = "Insert lowercase xi",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    nodes = {
      t("{\\xi}"),
    },
  },
}

local snippets = {}
for _, entry in ipairs(snippet_entries) do
  table.insert(snippets, make_snippet(entry))
end

return snippets
	s({trig="@c",snippetType="autosnippet",condition=tex_utils.in_mathzone},
	{t("{\\chi}"),}
	),

	-- Snippet
	s({trig="@l",snippetType="autosnippet",condition=tex_utils.in_mathzone},
	{t("{\\lambda}"),}
	),

	-- Snippet
	s({trig="@m",snippetType="autosnippet",condition=tex_utils.in_mathzone},
	{t("{\\mu}"),}
	),

	-- Snippet
	s({trig="nab",snippetType="autosnippet",condition=tex_utils.in_mathzone},
	{t("{\\nabla}"),}
	),

	-- Snippet
	s({trig="grad",snippetType="autosnippet",condition=tex_utils.in_mathzone},
	{t("\\underline{\\nabla}"),}
	),

}

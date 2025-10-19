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
    trig = "ux",
    dscr = "Insert u sub x",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    nodes = {
      t("{u_x}"),
    },
  },
  {
    trig = "uy",
    dscr = "Insert u sub y",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    nodes = {
      t("{u_y}"),
    },
  },
  {
    trig = "uz",
    dscr = "Insert u sub z",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    nodes = {
      t("{u_z}"),
    },
  },
  {
    trig = "ui",
    dscr = "Insert u sub i",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    nodes = {
      t("{u_i}"),
    },
  },
  {
    trig = "uj",
    dscr = "Insert u sub j",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    nodes = {
      t("{u_j}"),
    },
  },
  {
    trig = "xi",
    dscr = "Insert x sub i",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    nodes = {
      t("{x_i}"),
    },
  },
  {
    trig = "xj",
    dscr = "Insert x sub j",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    nodes = {
      t("{x_j}"),
    },
  },
  {
    trig = "tij",
    dscr = "Insert tau_{ij}",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    nodes = {
      t("\\tau_{ij}"),
    },
  },
  {
    trig = "dij",
    dscr = "Insert delta_{ij}",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    nodes = {
      t("\\delta_{ij}"),
    },
  },
  {
    trig = "sij",
    dscr = "Insert sigma_{ij}",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    nodes = {
      t("\\sigma_{ij}"),
    },
  },
  {
    trig = "eijk",
    dscr = "Insert varepsilon_{ijk}",
    snippetType = "autosnippet",
    condition = tex_utils.in_mathzone,
    nodes = {
      t("\\varepsilon_{ijk}"),
    },
  },
}

local snippets = {}
for _, entry in ipairs(snippet_entries) do
  table.insert(snippets, make_snippet(entry))
end

return snippets

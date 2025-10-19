local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local r = ls.restore_node
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

-- Generating functions for Matrix/Cases - thanks L3MON4D3!
local generate_matrix = function(args, snip)
        local rows = tonumber(snip.captures[2])
        local cols = tonumber(snip.captures[3])
        local nodes = {}
        local ins_indx = 1
        for j = 1, rows do
                table.insert(nodes, r(ins_indx, tostring(j) .. "x1", i(1)))
                ins_indx = ins_indx + 1
                for k = 2, cols do
                        table.insert(nodes, t(" & "))
                        table.insert(nodes, r(ins_indx, tostring(j) .. "x" .. tostring(k), i(1)))
                        ins_indx = ins_indx + 1
                end
                table.insert(nodes, t({ "\\\\", "" }))
        end
        -- fix last node.
        nodes[#nodes] = t("\\\\")
        return sn(nil, nodes)
end

local snippet_entries = {
  {
    trig = "([bBpvV])mat(%d+)x(%d+)([ar])",
    name = "[bBpvV]matrix",
    dscr = "Generate matrices from pattern",
    regTrig = true,
    hidden = true,
    condition = tex_utils.in_mathzone,
    show_condition = tex_utils.in_mathzone,
    formatter = fmta,
    template = [[
    \begin{<>}<>
        <>
    \end{<>}]],
    nodes = {
      f(function(_, snip)
        return snip.captures[1] .. "matrix"
      end),
      f(function(_, snip)
        if snip.captures[4] == "a" then
            local out = string.rep("c", tonumber(snip.captures[3]) - 1)
            return "[" .. out .. "|c]"
        end
        return ""
      end),
      d(1, generate_matrix),
      f(function(_, snip)
        return snip.captures[1] .. "matrix"
      end),
    },
  },
}

local snippets = {}
for _, entry in ipairs(snippet_entries) do
  table.insert(snippets, make_snippet(entry))
end

return snippets

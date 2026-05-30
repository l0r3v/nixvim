_: {
  plugins.friendly-snippets.enable = true;
  plugins.luasnip = {
    enable = true;
    fromLua = [{} {paths = ./LuaSnip;}];
    settings = {
      enable_autosnippets = true;
    };
  };
  extraConfigLuaPre = ''
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

    _G.get_visual = function(args, parent)
    	if #parent.snippet.env.LS_SELECT_RAW > 0 then
    		return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
    	else
    		return sn(nil, i(1))
    	end
    end

    _G.tex_utils = {}
    tex_utils.in_mathzone = function()
    	return vim.fn["vimtex#syntax#in_mathzone"]() == 1
    end
    tex_utils.in_text = function()
    	return not tex_utils.in_mathzone()
    end
    tex_utils.in_comment = function()
    	return vim.fn["vimtex#syntax#in_comment"]() == 1
    end
    tex_utils.in_env = function(name)
    	local is_inside = vim.fn["vimtex#env#is_inside"](name)
    	return (is_inside[1] > 0 and is_inside[2] > 0)
    end
    tex_utils.in_equation = function()
    	return tex_utils.in_env("equation")
    end
    tex_utils.in_itemize = function()
    	return tex_utils.in_env("itemize")
    end
    tex_utils.in_tikz = function()
    	return tex_utils.in_env("tikzpicture")
    end

    _G.line_begin = function()
    	return vim.fn.col(".") == 1
    end
  '';
}

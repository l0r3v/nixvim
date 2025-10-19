{...}: {
  plugins.friendly-snippets.enable = true;
  plugins.luasnip = {
    enable = true;
    fromLua = [{} {paths = ./LuaSnip;}];
    settings = {
      enable_autosnippets = true;
      #store_selection_keys = "<Tab>";
    };
  };
}

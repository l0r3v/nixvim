{pkgs, ...}: {
  plugins.luasnip = {
    enable = true;
    fromLua = [{} {paths = ../../config/nvim/LuaSnip;}];
    settings = {
      enable_autosnippets = true;
      store_selection_keys = "<Tab>";
    };
  };
}

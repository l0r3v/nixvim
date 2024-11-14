{lib, ...} : let

  # Load plugins filenames in list
  definitions = lib.traceSeq "definitions" lib.attrNames (
    lib.filterAttrs
    (
      filename: kind:
        filename
        != "default.nix"
        && (kind == "regular" || kind == "directory")
        # If file is an LSP plugin, respect withLSP flag
    )
    (builtins.readDir ./.)
  );
in
  lib.mkMerge (
    map
    (
      file: let
        pluginName = lib.elemAt (lib.splitString "." file) 0;
        plugin = import ./${file};
      in
        lib.mkMerge [
          (lib.optionalAttrs (plugin ? opts) {
            plugins.${pluginName} = plugin.opts;
          })
          (lib.optionalAttrs (plugin ? extra) {
            extraConfigLua = plugin.extra.config or "";
            extraPlugins = plugin.extra.packages;
          })
          (plugin.rootOpts or {})
        ]
    )
    definitions
  )

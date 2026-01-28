{...}: {
  plugins.obsidian = {
    enable = true;
    settings = {
      completion = {
        min_chars = 2;
        blink = true;
      };
      new_notes_location = "current_dir";
      workspaces = [
        {
          name = "Studio";
          path = "~/Studio";
        }
      ];
    };
  };
}

# Godot iOS Location plugins

<!-- [`master` branch](https://github.com/godotengine/godot-ios-plugins/tree/master) is the current development branch and can introduce breaking changes to plugin's public interface.
[`3.3` branch](https://github.com/godotengine/godot-ios-plugins/tree/3.3)'s aim is to provide same public interface as it was before the switch to new iOS plugin system. -->

Based on [godot-ios-plugins](https://github.com/godotengine/godot-ios-plugins?tab=readme-ov-file). Also see [iOS Plugin template](https://github.com/naithar/godot_ios_plugin).

## Building the plugin .xcframework
- Place Godot headers from [Godot repo](https://github.com/godotengine/godot-ios-plugins/tree/master) at extracted_headers/godot_4.x. Make sure to follow steps [here](https://github.com/godotengine/godot-ios-plugins?tab=readme-ov-file).

- Run the script below with any Godot version as input to produce plugin debug and release .xcframework fils that're compatible with the target Godot version. Example:

```bash
./compileLocationPlugin.sh 4.3
```

This command will produce .xcframework plugin files for Godot 4.3. The result will be at bin/Godot_4.3



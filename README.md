# Godot iOS Location plugins

<!-- [`master` branch](https://github.com/godotengine/godot-ios-plugins/tree/master) is the current development branch and can introduce breaking changes to plugin's public interface.
[`3.3` branch](https://github.com/godotengine/godot-ios-plugins/tree/3.3)'s aim is to provide same public interface as it was before the switch to new iOS plugin system. -->

Based on [godot-ios-plugins](https://github.com/godotengine/godot-ios-plugins?tab=readme-ov-file). Also see [iOS Plugin template](https://github.com/naithar/godot_ios_plugin).

## Building the plugin .xcframework

- run the script below with Godot version `4.2` or `4.3`to produce plugin .xcframework fils that's compatible the target Godot version. Example:

```bash
./compileLocationPlugin.sh 4.3
```

This command will produce .xcframework plugin files for Godot 4.3. The result will be at bin/Godot_4.3



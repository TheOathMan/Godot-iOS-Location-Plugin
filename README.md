# Godot iOS Location plugins

<!-- [`master` branch](https://github.com/godotengine/godot-ios-plugins/tree/master) is the current development branch and can introduce breaking changes to plugin's public interface.
[`3.3` branch](https://github.com/godotengine/godot-ios-plugins/tree/3.3)'s aim is to provide same public interface as it was before the switch to new iOS plugin system. -->

Based on [godot-ios-plugins](https://github.com/godotengine/godot-ios-plugins?tab=readme-ov-file). Also see [iOS Plugin template](https://github.com/naithar/godot_ios_plugin).

## Building the plugin .xcframework
- Place Godot headers from [Godot repo](https://github.com/godotengine/godot-ios-plugins/tree/master) at extracted_headers/godot_4.x. Make sure to follow steps [here](https://github.com/godotengine/godot-ios-plugins?tab=readme-ov-file) for more details on how to compile the Godot headers.

- Run the script below with any Godot 4.X version as an input to produce debug and release plugin(`.xcframework`) files that are compatible with the target Godot version. Example:

```bash
./compileLocationPlugin.sh 4.3
```

This command will produce plugin(`.xcframework`) files for Godot 4.3. The result will be at bin/Godot_4.3. To use the plugin, Copy the resulting files and also copy Location.gdip into your Godot project `res://ios/plugins/`, copy the addons folder to `res://addons`. Don't forget to enable the plugin from project->plugins and from Export settings.



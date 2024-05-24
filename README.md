# Godot iOS Location plugins

<!-- [`master` branch](https://github.com/godotengine/godot-ios-plugins/tree/master) is the current development branch and can introduce breaking changes to plugin's public interface.
[`3.3` branch](https://github.com/godotengine/godot-ios-plugins/tree/3.3)'s aim is to provide same public interface as it was before the switch to new iOS plugin system. -->

Godot iOS Plugin for Location Service. Retrieve user coordinates and handle client interactions seamlessly. based on Godot [`Android Plugin Template`](https://github.com/m4gr3d/Godot-Android-Plugin-Template). Also see [`Creating Android plugins`](https://docs.godotengine.org/en/4.0/tutorials/platform/android/android_plugin.html). To download the release, ready to use files go to the [`Release section`](https://github.com/TheOathMan/Godot-Android-Location-Plugin/releases).

## How to setup
* Make sure the addons and ios folder plugins are at `res://addons` and  `res://ios`.
* Go to Project -> Project settings -> Plugins.
* Enable `LocationIOS` plugin.
* Go to Project then click Reload Current Project.
* Also enable the plugin from Project -> Export. From options tab Plugins -> Location Plugin
* Now add `LocationIOS` node using the plus add-node button in the scene tab.

## How to use
Once the `LocationIOS` node has been added to the scene. You can:
* reference it from any script and start location service by calling `begin_ios_location_serivce()` method
```
$LocationIOS.begin_ios_location_serivce()
```
* Connect to its signals by clicking connect from the Node tab. For example, connecting to location_updated(Latitude:float,Longitude:float) to receive location updates, or from code as follows

```
$LocationIOS.location_updated.connect(update_pin_position)
```

## Building the plugin .xcframework
- In order to build the plugin, we need Godot headers. For more details on how to get Godot headers see [Godot repo](https://github.com/godotengine/godot-ios-plugins/tree/master). Place the headers at extracted_headers/godot_4.x. Make sure to follow steps [here](https://github.com/godotengine/godot-ios-plugins?tab=readme-ov-file) for more details on how to compile the Godot headers.

- Run the script below with any Godot 4.X version as an input to produce debug and release plugin(`.xcframework`) files that are compatible with the target Godot version. Example:

```
./compileLocationPlugin.sh 4.3
```

This command will produce plugin(`.xcframework`) files for Godot 4.3. The result will be at bin/Godot_4.3. To use the plugin, Copy the resulting files and also copy Location.gdip into your Godot project `res://ios/plugins/`, copy the addons folder to `res://addons`. Don't forget to enable the plugin from project->plugins and from Export settings.


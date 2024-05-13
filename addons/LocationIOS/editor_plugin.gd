@tool
class_name EditorIosLocationPlugin
extends EditorPlugin

const node_name = "LocationIOS"
const plugin_name: String = "LocationPlugin"
static var export_path:String =""

var export_plugin: IosExportPlugin

func _enter_tree() -> void:
	add_custom_type(node_name, "Node", preload("Location.gd"), preload("pindrop.svg"))
	export_plugin = IosExportPlugin.new()
	add_export_plugin(export_plugin)


func _exit_tree() -> void:
	remove_custom_type(node_name)
	remove_export_plugin(export_plugin)
	#(time_sec: float, process_always: bool = true, process_in_physics: bool = false, ignore_time_scale: bool = false)	
	export_plugin = null


class IosExportPlugin extends EditorExportPlugin:
	var _plugin_name = plugin_name	
	
	func _supports_platform(platform: EditorExportPlatform) -> bool:
		if platform is EditorExportPlatformIOS:
			return true
		return false
	
	func _get_name() -> String:
		return _plugin_name
	
	
	func _export_begin(features: PackedStringArray, is_debug: bool, path: String, flags: int) -> void:
		EditorIosLocationPlugin.export_path = path

	func _export_end() -> void:
		# As of godot 4.3, exporting your project might result in
		# invalid path to the plugin. This temporary fix/hack ensures
		# the path to the plugin is valid in the exported xcode project.
		# if this bug is fixed, then this function can be removed.
		EditorIosLocationPlugin.correct_xcframework_path()
		pass

const plugin_path: String = "/dylibs/ios/plugins/LocationPlugin/Location.xcframework"
static func correct_xcframework_path():
	var pbxproj_path = export_path + "/project.pbxproj";
	if FileAccess.file_exists(pbxproj_path):
		var fr = FileAccess.open(pbxproj_path,FileAccess.READ_WRITE)
		if fr.get_error()==OK:
			var content:String = ""
			var count:int=1
			while fr.get_position() < fr.get_length():
				var line:String = fr.get_line()
				var pos:int=line.rfind(plugin_path)
				if(pos!=-1):
					while (line[pos-count]!='"'):
						line[pos-count]='$'
						count+=1
					line=line.replace("$".repeat(count-1),export_path.get_file().get_basename())
				content += line+'\n'
			#pass
			fr.seek(0)
			fr.store_string(content)
			fr.close()
			print("======== correction Applied ========")




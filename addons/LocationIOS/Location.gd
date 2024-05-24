class_name LocationIOS
extends Node

signal location_updated(Latitude:float,Longitude:float)
signal location_status_updated(location_status:LocationServiceStatus)
signal authorization_status_updated(authorization_status:AuthorizationStatus)
signal dialogue_appeal_result(result:int)#0=cancel  1=ok

enum AuthorizationStatus{
		Not_Determend =0,
		WhenInUse     =1<<0,
		Always        =1<<1,
		Denied        =1<<2,
		Restricted    =1<<3,
		Authorizied   = WhenInUse | Always
}

enum LocationServiceStatus{
	idle=0,
	InUse,
	NotEnabled,
	Stopped
}

static var current_authorization_status: AuthorizationStatus
static var current_location_service_status: LocationServiceStatus

# Main method to call to start location service and handle results.
#   - If user allowed location access, coordinates will be sent to signal location_updated
#   - If user denied location access, an appeal dialogue will be showen 
func begin_ios_location_serivce():
	if current_authorization_status & AuthorizationStatus.Authorizied:
		StartLocationSerivce()
	else:
		authorization_status_changed.connect(func(s:AuthorizationStatus):
			if s & AuthorizationStatus.Authorizied:
				StartLocationSerivce()
			)
		AskLocationPermission()

var location_plugin
func get_plugin():
	if OS.get_name() != "iOS":
		printerr("Wrong operating system for iosLocation Plugin")
		return dummy;
	return location_plugin


func _ready():
	print(ProjectSettings.get_setting("application/config/name"))
	if Engine.has_singleton("LocationPlugin"):
		location_plugin = Engine.get_singleton("LocationPlugin")
		location_plugin.connect("LocationUpdated",_location_updated)
		location_plugin.connect("AuthorizationStatusUpdated",_authorization_status_updated)
		location_plugin.connect("LocationStatusUpdated",_location_status_updated)
		location_plugin.connect("DialogueResult",_dialogue_appeal_result)

		#optional: show Location Permission Appeal dialogue if the user denied location access.
		authorization_status_changed.connect(func(s:AuthorizationStatus):
			if s == AuthorizationStatus.Denied:
				ShowLocationPermissionAppeal()
		)
		#---------
	else:
		printerr("Failed to initialization IOS Location Plugin")
	pass # Replace with function body.
	
func _location_updated(lat:float,lon:float):
	location_updated.emit(lat,lon)

func _authorization_status_updated(status:int):
	authorization_status_updated.emit(status)
	current_authorization_status=status

func _location_status_updated(status:int):
	location_status_updated.emit(status)
	
func _dialogue_appeal_result(result:int):
	dialogue_appeal_result.emit(result)
	

#-------raw calls. Results are sent to signals but unhandled

# The resulting signal of this call will be sent to location_status_changed.
# also call to get the current_location_service_status 
func StartLocationSerivce():
	get_plugin().StartLocationService()

# The resulting signal of this call will be sent to location_status_changed.
func StopLocationSerivce() -> void:
	get_plugin().StopLocationService()

# The resulting signal of this call will be sent to authorization_status_changed.
# also call to get the current_location_service_status as a signal update
func AskLocationPermission() -> void:
	get_plugin().AskLocationAccess()

func ShowLocationPermissionAppeal() -> void:
	get_plugin().ShowLocationAlert("Locatoin Access",
	"Please enable location access from settings to allow "+ ProjectSettings.get_setting("application/config/name") +" to provide location-based features and services")
	

class dummy:
	static func StartLocationService() -> void:pass
	static func StopLocationService()  -> void:pass
	static func AskLocationAccess()    -> void:pass
	static func ShowLocationAlert(l,r) -> void:pass


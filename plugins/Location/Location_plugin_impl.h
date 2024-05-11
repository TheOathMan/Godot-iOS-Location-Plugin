#ifndef godot_plugin_implementation_h
#define godot_plugin_implementation_h


#include "core/object/object.h"
#include "core/object/ref_counted.h"
#include "bind_config.h"

class LocationPlugin :  public RefCounted {
  	GDCLASS(LocationPlugin, RefCounted);
    
    static void _bind_methods();
    static LocationPlugin *singleton;
    
public:
    static LocationPlugin *get_singleton();
    void AskLocationAccess();
    void StartLocationService();
    void StopLocationService();
    void ShowLocationAlert(String tile,String message);
    LocationPlugin();
    ~LocationPlugin();
};

#endif /* godot_plugin_implementation_h */

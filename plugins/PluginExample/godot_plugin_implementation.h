#ifndef godot_plugin_implementation_h
#define godot_plugin_implementation_h

//#define DISABLE_DEPRECATED
//#define DEBUG_METHODS_ENABLED

#include "core/object/object.h"

#include "core/object/ref_counted.h"


class PluginExample :  public RefCounted {
  	GDCLASS(PluginExample, RefCounted);
    
    static void _bind_methods();
    
public:
    
    Error foo();
    
    PluginExample();
    ~PluginExample();
};

#endif /* godot_plugin_implementation_h */

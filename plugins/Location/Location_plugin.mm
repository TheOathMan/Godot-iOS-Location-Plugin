
#import <Foundation/Foundation.h>
#import "Location_plugin.h"
#import "Location_plugin_impl.h"
#include "core/config/engine.h"


static LocationPlugin *plugin = nullptr;

void location_plugin_init() {
    NSLog(@"init Location plugin");
    plugin = memnew(LocationPlugin);
    Engine::get_singleton()->add_singleton(Engine::Singleton("LocationPlugin", LocationPlugin::get_singleton()));
}

void location_plugin_deinit() {
    NSLog(@"deinit Location plugin");
    if (plugin) {
       memdelete(plugin);
   }
}

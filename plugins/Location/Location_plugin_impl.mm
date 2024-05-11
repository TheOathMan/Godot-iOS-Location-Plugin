//
//  godot_plugin_implementation.m
//  godot_plugin
//
//  Created by Sergey Minakov on 14.08.2020.
//  Copyright © 2020 Godot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location_plugin_impl.h"
#import "LocationService.h"
#import <UIKit/UIKit.h>

static LocationService* location_service=nullptr;

void LocationPlugin::_bind_methods() {
    ClassDB::bind_method(D_METHOD("AskLocationAccess"), &LocationPlugin::AskLocationAccess);
    ClassDB::bind_method(D_METHOD("StartLocationService"), &LocationPlugin::StartLocationService);
    ClassDB::bind_method(D_METHOD("StopLocationService"), &LocationPlugin::StopLocationService);
    ClassDB::bind_method(D_METHOD("ShowLocationAlert"), &LocationPlugin::ShowLocationAlert);
    ADD_SIGNAL(MethodInfo(SIGNAL_LOCATION_UPDATED,PropertyInfo(Variant::FLOAT, "Latitude"),PropertyInfo(Variant::FLOAT, "Longitude")));
    ADD_SIGNAL(MethodInfo(SIGNAL_AUTH_CHANGED,PropertyInfo(Variant::INT, "AuthStat")));
    ADD_SIGNAL(MethodInfo(SIGNAL_LOCATION_SERVICE_STATUS,PropertyInfo(Variant::INT, "LocStat")));
    ADD_SIGNAL(MethodInfo(SIGNAL_DIALOGUE_RESULT,PropertyInfo(Variant::INT, "dialogue_Result")));
}


void LocationPlugin::AskLocationAccess(){
    if(location_service){
        [location_service requestLocationAuthorization];
    }
}

void LocationPlugin::StartLocationService() {
    if(location_service){
        [location_service startUpdatingLocation];
    }
}

void LocationPlugin::StopLocationService() {
    if(location_service){
        [location_service stopUpdatingLocation];
    }
}

void LocationPlugin::ShowLocationAlert(String tile,String message){
    if(location_service){
        
        NSString *c_title = [NSString stringWithUTF8String:tile.utf8().get_data()];
        NSString *c_message = [NSString stringWithUTF8String:message.utf8().get_data()];

        [location_service alertview:c_title addMessage:c_message];
    }
}

LocationPlugin *LocationPlugin::singleton = nullptr;

LocationPlugin *LocationPlugin::get_singleton() {
    return singleton;
}

LocationPlugin::LocationPlugin() {
    singleton = this;
    location_service = [[LocationService alloc] init];
}

LocationPlugin::~LocationPlugin() {
    NSLog(@"Location Plugin deinitialize");
}

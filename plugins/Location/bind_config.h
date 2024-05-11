//
//  bind_config.h
//  testingg.ipa.xcodeproj.ipa.xcodeproj.ipa
//
//  Created by Othman Alzahrani on 08/05/2024.
//  Copyright © 2024 GodotEngine. All rights reserved.
//

#ifndef bind_config_h
#define bind_config_h

#define SIGNAL_LOCATION_UPDATED "LocationUpdated"
#define SIGNAL_LOCATION_SERVICE_STATUS "LocationStatusUpdated"
#define SIGNAL_AUTH_CHANGED "AuthorizationStatusUpdated"
#define SIGNAL_DIALOGUE_RESULT "DialogueResult"

enum AuthorizationStatus{
		Not_Determend =0,
		WhenInUse     =1<<0,
		Always        =1<<1,
		Denied        =1<<2,
		Restricted    =1<<3,
		Authorizied   = WhenInUse | Always
};

enum LocationStatus{
    Idel=0,
    InUse,
    NotEnabled,
    Stopped
};


#endif /* bind_config_h */

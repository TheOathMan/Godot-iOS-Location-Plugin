
#import "LocationService.h"
#import <UIKit/UIKit.h>
#include "Location_plugin_impl.h"


@implementation LocationService

- (void)requestLocationAuthorization {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
}

- (void)startUpdatingLocation {
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [self.locationManager startUpdatingLocation];
        LocationPlugin::get_singleton()->emit_signal(SIGNAL_LOCATION_SERVICE_STATUS,LocationStatus::InUse);
        return;
    }
    LocationPlugin::get_singleton()->emit_signal(SIGNAL_LOCATION_SERVICE_STATUS,LocationStatus::NotEnabled);
}

- (void)stopUpdatingLocation {
    [self.locationManager stopUpdatingLocation];
    LocationPlugin::get_singleton()->emit_signal(SIGNAL_LOCATION_SERVICE_STATUS,LocationStatus::Stopped);
}


- (void)directToLocationPermissionSettings {
    
    //As of April 2023, iOS 8 has a usage share of less than 0.1% according to Apple's developer statistics. But no one predicted covid-19, so who knows.
    if (@available(iOS 8.0, *)) {
        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:settingsURL]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]
                                             options:@{}
                                   completionHandler:nil];
        } else {
            // Fallback on earlier versions
            NSURL *locationPermissionURL = [NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"];
            if ([[UIApplication sharedApplication] canOpenURL:locationPermissionURL]) {
                [[UIApplication sharedApplication] openURL:locationPermissionURL
                                                   options:@{}
                                         completionHandler:nil];
            } else {
                // Handle the case where the device doesn't support the specific URL scheme
                NSLog(@"Device doesn't support location permission settings URL");
            }
        }
    } else {
        // Fallback on earlier versions
        NSURL *locationPermissionURL = [NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"];
        if ([[UIApplication sharedApplication] canOpenURL:locationPermissionURL]) {
            [[UIApplication sharedApplication] openURL:locationPermissionURL];
        } else {
            // Handle the case where the device doesn't support the specific URL scheme
            NSLog(@"Device doesn't support location permission settings URL");
        }
    }
}

-(void)alertview:(NSString*)title addMessage:(NSString*) message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert ];
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault
      handler:^(UIAlertAction *action){ [self directToLocationPermissionSettings];
        LocationPlugin::get_singleton()->emit_signal(SIGNAL_DIALOGUE_RESULT,1);
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleDefault
    handler:^(UIAlertAction *action){
        LocationPlugin::get_singleton()->emit_signal(SIGNAL_DIALOGUE_RESULT,0);
    }];

    [alert addAction:defaultAction];
    [alert addAction:cancel];

    UIViewController *currentViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    
    [currentViewController presentViewController:alert animated:YES completion:nil];
}


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *currentLocation = locations.lastObject;
    self.currentLocation = currentLocation.coordinate;
    LocationPlugin::get_singleton()->emit_signal(SIGNAL_LOCATION_UPDATED, self.currentLocation.latitude, self.currentLocation.longitude);
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Error: %@", error.localizedDescription);
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            LocationPlugin::get_singleton()->emit_signal(SIGNAL_AUTH_CHANGED,AuthorizationStatus::Not_Determend); //AUTH_NONE
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            LocationPlugin::get_singleton()->emit_signal(SIGNAL_AUTH_CHANGED,AuthorizationStatus::WhenInUse);//AUTH_OK
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
            LocationPlugin::get_singleton()->emit_signal(SIGNAL_AUTH_CHANGED,AuthorizationStatus::Always);
            break;
        case kCLAuthorizationStatusDenied:
            LocationPlugin::get_singleton()->emit_signal(SIGNAL_AUTH_CHANGED,AuthorizationStatus::Denied);
            break;
        case kCLAuthorizationStatusRestricted:
            LocationPlugin::get_singleton()->emit_signal(SIGNAL_AUTH_CHANGED,AuthorizationStatus::Restricted);
            break;
        default:
            break;
    }
}

@end

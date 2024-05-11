#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocationService : NSObject <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, assign) CLLocationCoordinate2D currentLocation;

- (void)requestLocationAuthorization;
- (void)startUpdatingLocation;
- (void)stopUpdatingLocation;
- (void)directToLocationPermissionSettings;
- (void)alertview:(NSString*)title addMessage:(NSString*) message;

@end

NS_ASSUME_NONNULL_END

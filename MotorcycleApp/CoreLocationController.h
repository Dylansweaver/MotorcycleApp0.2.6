//
//  CoreLocationController.h
//  MotorcycleApp
//
//  Created by Dylan Sebastian Weaver on 4/17/17.
//  Copyright © 2017 Dylan Sebastian Weaver. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreLocation/CoreLocation.h"

@protocol CoreLocationControllerDelegate
@required
- (void)update:(CLLocation *)location;
- (void)locationError:(NSError *)error;
@end

@interface CoreLocationController : NSObject <CLLocationManagerDelegate>

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) id delegate;

@end

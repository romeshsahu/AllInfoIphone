//
//  AppDelegate.h
//  All Info
//
//  Created by Mahendra Suryavanshi on 3/3/16.
//  Copyright © 2016 PS.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <GoogleSignIn/GoogleSignIn.h>
#import <UserNotifications/UserNotifications.h>
#import "TWMessageBarManager.h"


#define  kAppDelegate  ((AppDelegate *) [UIApplication sharedApplication].delegate)

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate,UNUserNotificationCenterDelegate>
{
    NSSet *categories;
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}


@property float averageRating;
@property BOOL flagIsShowAverageRating;
@property (strong, nonatomic) NSString * strShareLink, * strDeviceId, * strSelectedLatitude, * strSelectedLongitude;
@property (strong, nonatomic) UIImage * imgSubCategory, * imgCategory;
@property (strong, nonatomic) NSString * strSubCategory, * strCategory;
@property (strong, nonatomic) NSString * strSubCategoryDate, * strCategoryDate;
@property (strong, nonatomic) UIWindow *window;
+(AppDelegate*)SharedInstance;
@property (retain, nonatomic) NSURLConnection *connection;
@property (retain, nonatomic) NSMutableData *receivedData;
-(void)getselectedTab:(NSInteger)selectedTabIndex;
@end


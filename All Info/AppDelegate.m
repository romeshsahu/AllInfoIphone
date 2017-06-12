//
//  AppDelegate.m
//  All Info
//
//  Created by Mahendra Suryavanshi on 3/3/16.
//  Copyright © 2016 PS.com. All rights reserved.
//

#import "AppDelegate.h"
#import "MenuViewController.h"
#import "ViewController.h"
#import "SelectLanguageViewController.h"
#import "BundleLocalization.h"
#import "WSOperationInEDUApp.h"


#define  kAppDelegate  ((AppDelegate *) [UIApplication sharedApplication].delegate)

@interface AppDelegate ()
{
    UINavigationController *nav;
    NSString* deviceid;
}

@end




@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSString *uniqueIdentifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    if([def objectForKey:@"DeviceId"] == nil) {
        [def setObject:uniqueIdentifier forKey:@"DeviceId"];
        [def synchronize];
    }
    
    kAppDelegate.strDeviceId = [def objectForKey:@"DeviceId"];
    
    
   kAppDelegate.strShareLink = @"http://onelink.to/spudpu";
        ///check last update
    
        // [self checkLastUpdate];
//    if([[[UIView alloc] init] respondsToSelector:@selector(setSemanticContentAttribute:)]) {
//        [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceLeftToRight];
//    }
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
    
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")) {
        [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceLeftToRight];
    }
    
    /*
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
#ifdef __IPHONE_8_0
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIRemoteNotificationTypeSound
                                                                                             |UIRemoteNotificationTypeAlert) categories:nil];
        [application registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication]registerForRemoteNotifications];
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"in if" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        // [alert show];
#endif
    } else {
        UIRemoteNotificationType myTypes =  UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        [application registerForRemoteNotificationTypes:myTypes];
    }
        */

    locationManager = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [locationManager requestAlwaysAuthorization];
    }
     [locationManager startUpdatingLocation];
     [[BundleLocalization sharedInstance] setLanguage:@"he"];
     [[NSUserDefaults standardUserDefaults] setInteger:2 forKey:@"SelectedLanguage"];
   
    
    UIStoryboard *MainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    UINavigationController *controller = (UINavigationController*)[MainStoryboard
                                                                   instantiateViewControllerWithIdentifier: @"RootNavigationController"];
    
    
    UITabBarController *tabar = controller.viewControllers[0];
    [tabar setSelectedIndex:3];
    
    self.window.rootViewController=controller;
    
    [self checkLastUpdate];
    //RootNavigationController
    [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    [FBSDKLoginButton class];

    
    [GIDSignIn sharedInstance].clientID = @"658798455181-0ja0a73n7ubc4h0drp1spq0uedr57qrn.apps.googleusercontent.com";
    [GIDSignIn sharedInstance].allowsSignInWithBrowser=YES;
    
    return YES;
}

- (void) checkLastUpdate {
    WSOperationInEDUApp *ws=[[WSOperationInEDUApp alloc]initWithDelegate:self callback:@selector(getLastUpdateData:)];
    [ws getLastUpdate];
}


- (void) getLastUpdateData :(id)response {
    NSMutableDictionary *responseDic=response;
    NSLog(@"responseDic = %@", responseDic);
    if ([response isKindOfClass:[NSDictionary class]]) {
        if ([[responseDic objectForKey:@"message"]isEqualToString:@"success"]) {
            
            NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
            
            if([defaults objectForKey:@"cat_last_update"] != nil && [defaults objectForKey:@"subcat_last_update"] != nil){
                
                if(![[defaults objectForKey:@"cat_last_update"] isEqualToString:responseDic[@"cat_last_update"]]) {
                    [defaults setObject:responseDic[@"cat_last_update"] forKey:@"cat_last_update"];
                    kAppDelegate.strCategoryDate = [defaults objectForKey:@"cat_last_update"];//responseDic[@"cat_last_update"];
                } else {
                    kAppDelegate.strCategoryDate = responseDic[@"cat_last_update"];
                }
                
                if(![[defaults objectForKey:@"subcat_last_update"] isEqualToString:responseDic[@"subcat_last_update"]]) {
                    [defaults setObject:responseDic[@"subcat_last_update"] forKey:@"subcat_last_update"];
                    kAppDelegate.strSubCategoryDate = [defaults objectForKey:@"subcat_last_update"];//responseDic[@"subcat_last_update"];
                } else {
                    kAppDelegate.strSubCategoryDate = responseDic[@"subcat_last_update"];
                }
            } else {
                    ///Means first time these are nil
                [defaults setObject:responseDic[@"cat_last_update"] forKey:@"cat_last_update"];
                [defaults setObject:responseDic[@"subcat_last_update"] forKey:@"subcat_last_update"];
                    //  kAppDelegate.strCategoryDate = responseDic[@"cat_last_update"];
                    // kAppDelegate.strSubCategoryDate = responseDic[@"subcat_last_update"];
            }
            
            [defaults synchronize];
            
            
            UIStoryboard *MainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                                     bundle: nil];
            UINavigationController *controller = (UINavigationController*)[MainStoryboard
                                                                           instantiateViewControllerWithIdentifier: @"RootNavigationController"];
            
            
            UITabBarController *tabar = controller.viewControllers[0];
            [tabar setSelectedIndex:3];
            
            self.window.rootViewController=controller;
            
        }
    } else {
        UIStoryboard *MainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                                 bundle: nil];
        UINavigationController *controller = (UINavigationController*)[MainStoryboard
                                                                       instantiateViewControllerWithIdentifier: @"RootNavigationController"];
        
        
        UITabBarController *tabar = controller.viewControllers[0];
        [tabar setSelectedIndex:3];
        
        self.window.rootViewController=controller;
    }
}

-(void)getselectedTab:(NSInteger)selectedTabIndex{
    
    UIStoryboard *MainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    UINavigationController *controller = (UINavigationController*)[MainStoryboard
                                                                   instantiateViewControllerWithIdentifier: @"RootNavigationController"];
    
    
    UITabBarController *tabar = controller.viewControllers[0];
    [tabar setSelectedIndex:selectedTabIndex];
    
    self.window.rootViewController=controller;

}
+(AppDelegate*)SharedInstance{
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
}
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
     deviceid = [[[[deviceToken description]
                            stringByReplacingOccurrencesOfString: @"<" withString: @""]
                           stringByReplacingOccurrencesOfString: @">" withString: @""]
                          stringByReplacingOccurrencesOfString: @" " withString: @""];
    [self Getnotifiction];
    
    //NSLog(@"My token is: %@", deviceid);
    //UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:@"Device token" message:deviceid delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //[Alert show];
    [[NSUserDefaults standardUserDefaults]setValue:deviceid forKey:@"DevieceId"];
}

-(void)Getnotifiction{
    
    
    
    [self.connection cancel];
    
    //initialize new mutable data
    NSMutableData *data = [[NSMutableData alloc] init];
    self.receivedData = data;
    // [data release];
    UIDevice *device = [UIDevice currentDevice];
    
    NSString  *currentDeviceId = [[device identifierForVendor]UUIDString];
    
    NSString *device_type=@"1";
    NSString *urlStr=[NSString stringWithFormat:@"http://allinfo.co.il/all_info/webservice/master.php?action=AddDeviceInfo&device_type=%@&device_id=%@&device_gcm_id=%@",device_type,currentDeviceId,deviceid];
    
    //passcode
    
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    //initialize a request from url
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[url standardizedURL]];
    
    //set http method
    [request setHTTPMethod:@"POST"];
    
    
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    self.connection = connection;
    //[connection release];
    
    //start the connection
    [connection start];
    
    
    
}





-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    //initialize convert the received data to string with UTF8 encoding
    NSString *response=[[NSString alloc]initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    NSDictionary *responseDic =[NSJSONSerialization JSONObjectWithData:self.receivedData options:kNilOptions error:nil];
    if ([responseDic isKindOfClass:[NSDictionary class]]) {
        if ([[responseDic objectForKey:@"message"]isEqualToString:@"success"]) {
            
        }
    }
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.receivedData appendData:data];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    // [HUD hide:YES];
    NSLog(@"%@" , error);
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBSDKAppEvents activateApp];
    [self.window endEditing:YES];
    
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [[FBSDKApplicationDelegate sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
    
    return [[GIDSignIn sharedInstance] handleURL:url sourceApplication:sourceApplication annotation:annotation];
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [UIApplication sharedApplication].applicationIconBadgeNumber = [[[userInfo objectForKey:@"aps"] objectForKey: @"badge"] intValue];
    UIStoryboard *MainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    UINavigationController *controller = (UINavigationController*)[MainStoryboard
                                                                   instantiateViewControllerWithIdentifier: @"RootNavigationController"];
    
    
    UITabBarController *tabar = controller.viewControllers[0];
    [tabar setSelectedIndex:3];
    
    self.window.rootViewController=controller;
    
    
}

@end

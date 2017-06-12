//
//  MapListViewController.m
//  All Info
//
//  Created by Mahendra Suryavanshi on 3/5/16.
//  Copyright © 2016 PS.com. All rights reserved.
//

#import "MapListViewController.h"
#import "UIImage+animatedGIF.h"
#import <AudioToolbox/AudioToolbox.h>
#import "WSOperationInEDUApp.h"
#import "UIImageView+WebCache.h"
#import "BusinessdetailsViewController.h"
#import "MenuViewController.h"
#import "RegistrationViewController.h"
#import "Allinfo.h"
#import "AddbusinessViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "HelpViewController.h"
#import "ContectUsViewController.h"
#import "MapViewController.h"
@interface MapListViewController ()<MenuViewControllerDelegates,UITabBarControllerDelegate>
{

    NSString*Userlat;
    NSMutableDictionary *BussnessDic;
    NSString*Userlong;
    NSMutableArray *serchListArr;
    UINavigationController *nav;
    MenuViewController * sample;
    Allinfo *HistoryInfo;

    UIView *footerView;
     UIActivityIndicatorView * actInd;
    CGPoint lastContentOffset;
    
    
    float longitude;
    float latitude;
    CLLocationCoordinate2D cord_Current;
    mapClass *shop1;
    CLLocation *location ;

    
}

@end

@implementation MapListViewController
bool isShowngif1 = false;
@synthesize mapView,locationManager;

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
}
- (void)viewWillAppear:(BOOL)animated {
    serchListArr = [[NSMutableArray alloc] init];
    
    if (self.issearch==YES) {
        
        [self performSelector:@selector(serchByprodect) withObject:nil afterDelay:1.0f];
    }else{
        [self performSelector:@selector(GetprodectList) withObject:nil afterDelay:1.0f];
        
    }

    [super viewWillAppear:animated];
    HistoryInfo=[[Allinfo alloc]init];
    [sample.view removeFromSuperview];
    
    self.tabBarController.tabBar.hidden=NO;
    
    
}

-(void) tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSLog(@"working");
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    serchListArr = [[NSMutableArray alloc]init];
    
    classUnicode=[[UnicodeConversionClass alloc]init];

    if (self.issearch==YES) {
        serchListArr=[[NSMutableArray alloc]init];
        //self.ShowTitalLabe.text=[self.getSubcategryDic objectForKey:@"sub_category_name"];
        //self.ShowTitalLabe.textAlignment=NSTextAlignmentCenter;
        [self initFooterView];
        
    }else{
        serchListArr=[[NSMutableArray alloc]init];
       // self.ShowTitalLabe.text=[self.getSubcategryDic objectForKey:@"sub_category_name"];
       // self.ShowTitalLabe.textAlignment=NSTextAlignmentCenter;

        [self initFooterView];
    }
    
    [self fetchLocation];

}


-(void)initFooterView
{
    footerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 40.0)];
    //    footerView.backgroundColor = [UIColor blueColor];
    actInd = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    actInd.tag = 10;
    actInd.frame = CGRectMake(footerView.frame.size.width/2, 5.0, 20.0, 20.0);
    
    actInd.hidesWhenStopped = YES;
    actInd.hidden = NO;
    [footerView addSubview:actInd];
    //    actInd = nil;
    
}


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
        // NSLog(@"didUpdateToLocation: %f, long = %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    CLLocation *currentLocation = newLocation;
    if (currentLocation != nil) {
        
        if (![Userlat isEqualToString:[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude]] && ![Userlong isEqualToString:[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude]]) {
            if (self.issearch==YES) {
                
                if (Userlat == nil || [Userlat isKindOfClass:[NSNull class]] ||  Userlong == nil || [Userlong isKindOfClass:[NSNull class]] ) {
                    //do something
                }else{
                    [self serchByprodect];

                }
                
            }else{
                if (Userlat == nil || [Userlat isKindOfClass:[NSNull class]] ||  Userlong == nil || [Userlong isKindOfClass:[NSNull class]] ) {
                    //do something
                }else{
                    [self GetprodectList];

                }
                
            }
            NSString * Userlong1
            = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
            [[NSUserDefaults standardUserDefaults] setObject:Userlong1 forKey:@"Userlong"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            NSString *Userlat2= [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
            [[NSUserDefaults standardUserDefaults] setObject:Userlat2 forKey:@"Userlat"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            NSLog(@"currentLocation.coordinate.longitude = %f, currentLocation.coordinate.latitude = %f", currentLocation.coordinate.longitude, currentLocation.coordinate.latitude);
            
            Userlong= [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"Userlong"];
            Userlat = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"Userlat"];
        }
       
    }
}

/*- (IBAction)ActionOnMapView:(id)sender {
    [self performSegueWithIdentifier:@"MapView" sender:self];
}*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"MapView"]) {
        MapViewController *MapView = segue.destinationViewController;
        MapView.delegates = self;
        MapView.isaddnew=YES;
    }

    if ([segue.identifier isEqualToString:@"Details"]) {
        
        NSMutableDictionary * dictBD = [[NSMutableDictionary alloc] init];
        dictBD = [BussnessDic mutableCopy];
        [dictBD setObject:kAppDelegate.strSubCategory forKey:@"subcategory_image"];
        
        
        kAppDelegate.flagIsShowAverageRating = NO;
        BusinessdetailsViewController *Bissnesdetails=segue.destinationViewController;
        Bissnesdetails.getBussnessDic=[dictBD mutableCopy];
        Bissnesdetails.isserchsetview=true;
    }
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{

 if (connection==self.connection) {
    if (self.receivedData != nil) {
        NSDictionary *responseDic =[NSJSONSerialization JSONObjectWithData:self.receivedData options:kNilOptions error:nil];
        if ([responseDic isKindOfClass:[NSDictionary class]]) {
            if ([[responseDic objectForKey:@"message"]isEqualToString:@"success"]) {
                if (![[responseDic objectForKey:@"result"] isKindOfClass:[NSNull class]]) {
                    
                    NSArray *responseArr = [responseDic objectForKey:@"result"];
                    for (NSDictionary *dic in responseArr) {
                        [serchListArr addObject:dic];
                    }
            }
                
                
                [self map_pinAnnotation];
                NSLog(@"serchListArr = %@", serchListArr);
                
                
        }else {
            
        }
    }
    }
 }else  if (connection==self.connectionnew){
     
     if (self.receivedDatanew != nil) {
        NSDictionary *responseDic =[NSJSONSerialization JSONObjectWithData:self.receivedDatanew options:kNilOptions error:nil];
        if ([responseDic isKindOfClass:[NSDictionary class]]) {
            if ([[responseDic objectForKey:@"message"]isEqualToString:@"success"]) {
                if (![[responseDic objectForKey:@"result"] isKindOfClass:[NSNull class]]) {
                    
                    NSArray *responseArr = [responseDic objectForKey:@"result"];
                    
                    for (NSDictionary *dic in responseArr) {
                        [serchListArr addObject:dic];
                    }
                }
                
            }else {
                
                //            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"No data found",nil) message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                //            [alert show];
            }
        }
     }
    }

    
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
     [HUD hide:YES];
   
    if (connection==self.connection) {
        [self.receivedData appendData:data];
    }else if (connection==self.connectionnew) {
        [self.receivedDatanew appendData:data];
    }
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [HUD hide:YES];
    NSLog(@"error....%@" , error);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)BackBtn:(id)sender {
    [self .navigationController popViewControllerAnimated:YES];
}
- (IBAction)ActionOnHome:(id)sender {
    UIStoryboard *MainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    UINavigationController *controller = (UINavigationController*)[MainStoryboard
                                                                   instantiateViewControllerWithIdentifier: @"RootNavigationController"];
    
    
    UITabBarController *tabar = controller.viewControllers[0];
    [tabar setSelectedIndex:3];
    
    [AppDelegate SharedInstance].window.rootViewController=controller;
    [[AppDelegate SharedInstance].window makeKeyAndVisible];
     //[self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)ActionOnmenu:(id)sender {
    if (!isShowngif1) {
        
        sample = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
        sample.delegate = self;
        // nav=[[UINavigationController alloc]init:ll];
        sample.view.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height);
        
        CATransition *transition = [CATransition animation];
        transition.duration = 0.5;
        transition.type = kCATransitionPush;
       
         transition.subtype = kCATransitionFromLeft;
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [sample.view.layer addAnimation:transition forKey:nil];
        [self.view addSubview:sample.view];
        
        isShowngif1 = true;
        
    } else {
        
        
        CATransition *transition = [CATransition animation];
        transition.duration =0.5;
        transition.type = kCATransitionReveal;
        transition.subtype = kCATransitionFromRight;
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [sample.view.layer addAnimation:transition forKey:nil];
        [sample.view performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.5];
        
        isShowngif1 = false;
    }

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==1) {
        if (buttonIndex == 0){
            
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"login"];
            
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"userdata"];
            
            
            //login
            
        }
        
        
    }
}

#pragma mark - Menu delegates

-(void)PushViewControllersOnSelFView:(int)View {
    [sample.view removeFromSuperview];
    
    switch (View) {
        case 1:
            
            break;
        case 2:
        {
            RegistrationViewController *registerView = [self.storyboard instantiateViewControllerWithIdentifier:@"RegistrationViewController"];
            registerView.tabBarController.tabBar.hidden = YES;
            [self.navigationController pushViewController:registerView animated:YES];
        }
            break;
        case 3:
        {
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"login"]isEqualToString:@"Yes"]) {
                AddbusinessViewController *AddbusinessView = [self.storyboard instantiateViewControllerWithIdentifier:@"AddbusinessViewController"];
                //AddbusinessView.tabBarController.tabBar.hidden = YES;
                [self.navigationController pushViewController:AddbusinessView animated:YES];
            }else{
                
                LoginViewController *LoginView = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
                LoginView.tabBarController.tabBar.hidden = YES;
                [self.navigationController pushViewController:LoginView animated:YES];
            }
            
            
            
        }
            
            break;
        case 4:
        {
            HelpViewController*HelpView = [self.storyboard instantiateViewControllerWithIdentifier:@"HelpViewController"];
            HelpView.tabBarController.tabBar.hidden = YES;
            [self.navigationController pushViewController:HelpView animated:YES];
        }
            
            break;
        case 5:
        {
            ContectUsViewController*ContectUsView = [self.storyboard instantiateViewControllerWithIdentifier:@"ContectUsViewController"];
            ContectUsView.tabBarController.tabBar.hidden = YES;
            [self.navigationController pushViewController:ContectUsView animated:YES];
        }

            break;
        case 6:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:NSLocalizedString(@"Are you sure you want to logout?",nil) delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
            alert.tag=1;
            [alert show];
        }
            break;
        default:
            break;
    }
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    
    CATransition *transition = [CATransition animation];
    transition.duration = 1;
    transition.type = kCATransitionReveal;
    
     transition.subtype = kCATransitionFromRight;
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [sample.view.layer addAnimation:transition forKey:nil];
    [sample.view removeFromSuperview];
    
    
    isShowngif1 = false;
}

- (IBAction)btn_Share:(id)sender {
    NSString *textToShare = @"Share link using";
    NSURL *myWebsite = [NSURL URLWithString:kAppDelegate.strShareLink];
    
    NSArray *objectsToShare = @[textToShare, myWebsite];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    NSArray *excludeActivities = @[UIActivityTypeAirDrop,
                                   UIActivityTypePrint,
                                   UIActivityTypeAssignToContact,
                                   UIActivityTypeSaveToCameraRoll,
                                   UIActivityTypeAddToReadingList,
                                   UIActivityTypePostToFlickr,
                                   UIActivityTypePostToVimeo];
    
    activityVC.excludedActivityTypes = excludeActivities;
    
    [self presentViewController:activityVC animated:YES completion:nil];
}

-(void)serchByprodect{
    
    [self.connectionnew cancel];
    
    //initialize new mutable data
    NSMutableData *data = [[NSMutableData alloc] init];
    self.receivedDatanew = data;
    //[data release];
    HUD.delegate = self;
    HUD.labelText = @"Loading";
    [HUD show:NO];
    //initialize url that is going to be fetched.
    //NSString *urlStr=[NSString stringWithFormat:@"http://allinfo.co.il/all_info/webservice/master.php?action=searchBusiness&sub_cat_id=%@&language_id=%@&latitude=%@&longitude=%@&page_no=%@&limit=%@",[self.getSubcategryDic objectForKey:@"sub_cat_id"] ,@"2",lat,latonh,@"1",[NSString stringWithFormat:@"%li",(long)pageNo]];
    
    NSString *urlStr=[NSString stringWithFormat:@"http://allinfo.co.il/all_info/webservice/master.php?action=search&string=%@&latitude=%@&longitude=%@&page_no=%@&limit=%@",self.serchByName ,Userlat,Userlong,[NSString stringWithFormat:@"%li",(long)1],@"10"];
    
    //passcode
    
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    //initialize a request from url
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[url standardizedURL]];
    
    //set http method
    [request setHTTPMethod:@"POST"];
    
    
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    self.connectionnew = connection;
    //[connection release];
    
    //start the connection
    [self.connectionnew start];
    
}


-(void)GetprodectList{
    
    [self.connection cancel];
    
    //initialize new mutable data
    NSMutableData *data = [[NSMutableData alloc] init];
    self.receivedData = data;
    //[data release];
    HUD.delegate = self;
    HUD.labelText = @"Loading";
    [HUD show:NO];
    /// dynamic
    NSString *urlStr=[NSString stringWithFormat:@"http://allinfo.co.il/all_info/webservice/master.php?action=searchBusiness&sub_cat_id=%@&language_id=%@&latitude=%@&longitude=%@&page_no=%@&limit=%@",[self.getSubcategryDic objectForKey:@"sub_cat_id"] ,@"2",Userlat,Userlong,[NSString stringWithFormat:@"%li",(long)1],@"10"];
    // http://allinfo.co.il/all_info/webservice/master.php?action=searchBusiness&sub_cat_id=98&latitude=33.02519&longitude=35.25392&language_id=2&page_no=1&limit=10
    ///Static
    
    //   NSString *urlStr=[NSString stringWithFormat:@"http://allinfo.co.il/all_info/webservice/master.php?action=searchBusiness&sub_cat_id=%@&language_id=%@&latitude=%@&longitude=%@&page_no=%@&limit=%@",[self.getSubcategryDic objectForKey:@"sub_cat_id"] ,@"2", @"31.789520", @"35.185456", [NSString stringWithFormat:@"%li",(long)pageNo],@"10"];
    
    NSLog(@"urlStr = %@", urlStr);
    
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
    [self.connection start];
    
}



#pragma mark mapView Stuff
-(void)fetchLocation
{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    NSLog(@" [systemVersion];.....%@", [[UIDevice currentDevice] systemVersion]);
    if([[[UIDevice currentDevice] systemVersion] integerValue] >= 8)
    {
        [locationManager requestWhenInUseAuthorization];
    }
    [locationManager startUpdatingLocation];
    
    longitude=locationManager.location.coordinate.longitude;
    latitude=locationManager.location.coordinate.latitude;
    
    
    location = [locationManager location];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
     {
         
         if (error){
             NSLog(@"Geocode failed with error::::: %@", error);
             return;
         }
         CLPlacemark *placemark = [placemarks objectAtIndex:0];
         //         _strAddress = [NSString stringWithFormat:@"%@ %@, %@ %@, %@",
         //                          placemark.subThoroughfare, placemark.thoroughfare,
         //                          placemark.postalCode, placemark.locality,
         //                          placemark.country];
         
         //         NSArray *lines = placemark.addressDictionary[ @"FormattedAddressLines"];
         //         _strAddress = [lines componentsJoinedByString:@", "];
         
         NSString *strCountry = placemark.country;
         NSString *strCity = placemark.locality;
         
     }];
    
    
}

-(void)removeAllAnnotations
{
    id userAnnotation = self.mapView.userLocation;
    
    NSMutableArray *annotations = [NSMutableArray arrayWithArray:self.mapView.annotations];
    [annotations removeObject:userAnnotation];
    
    [self.mapView removeAnnotations:annotations];
}

-(void)map_pinAnnotation
{
    @try {
        
        [self removeAllAnnotations];
        cord_Current=CLLocationCoordinate2DMake(latitude,longitude);
        mapView.delegate=self;
        
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(cord_Current, 100000, 1000000);
        MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
        [self.mapView setRegion:adjustedRegion animated:YES];
        self.mapView.showsUserLocation = YES;
        
        //  MKCoordinateRegion region=MKCoordinateRegionMakeWithDistance(cord_Current,100,100);
        //  [mapView setRegion:region animated:true];
        
        // arrUser_detail=[arrAdsList valueForKey:@"user_detail"];
        
        
        NSMutableArray *arr_lat=[[NSMutableArray alloc]init];//WithObjects:@"22.1196",@"22.0196",@"21.7196", nil];
        NSMutableArray *arr_long=[[NSMutableArray alloc]init];//WithObjects:@"75.0577",@"75.0577",@"74.8577", nil];
        NSMutableArray *arr_AnnoText=[[NSMutableArray alloc]init];//WithObjects:@"22.7196",@"22.0196",@"21.7196", nil];
        NSMutableArray *arr_AnnoPrice=[[NSMutableArray alloc]init];
        
        
        arr_lat=[serchListArr valueForKey:@"latitude"];
        arr_long=[serchListArr valueForKey:@"longitude"];
        arr_AnnoText=[serchListArr valueForKey:@"category_name"];
        arr_AnnoPrice=[serchListArr valueForKey:@"phone"];
        
        NSLog(@"arrAdsList.count.....%lu",(unsigned long)arr_lat.count);
        
        for (int i=0; i<arr_lat.count; i++)
        {
            NSString *str;
            NSString *currency  = [NSString stringWithFormat:@"%@",[serchListArr [i] valueForKey:@"currency"]];
            if ([currency isEqualToString:@"0"]) {
                str=[NSString stringWithFormat:@"%@-%@ SAR",arr_AnnoText[i], arr_AnnoPrice[i]];
            }
            else
            {
                str=[NSString stringWithFormat:@"%@-$ %@",arr_AnnoText[i], arr_AnnoPrice[i]];
            }
            
            
            CLLocationCoordinate2D cord1=CLLocationCoordinate2DMake([arr_lat[i] floatValue],[arr_long[i] floatValue]);
            shop1=[[mapClass alloc]initWithTitle:str andCoordinate:cord1 andFlavours: @"Name" SubTitle: [classUnicode StringToConvert:arr_AnnoText[i]] selectedID:[NSString stringWithFormat:@"%d",i]];
            [mapView addAnnotation:shop1];
            
        }
        
        
    }
    @catch (NSException *exception)
    {
        NSLog(@"exception map_pin....%@",exception);
    }
}


#pragma mark mapView Delegates
/*
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
}*/

//if user location is updated
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [self.locationManager stopUpdatingLocation];
    self.locationManager.delegate = nil;
    
    location = [locationManager location];
    longitude=manager.location.coordinate.longitude;
    latitude=manager.location.coordinate.latitude;
    NSLog(@"dLongitude :::: %f", longitude);
    NSLog(@"dLatitude :::: %f", latitude);
    
    
    
    
    //   if ([StrLogUsertype isEqualToString:@"3"]||StrLogUsertype == NULL)//User
    //   {
    //   [self getAddressFromLatLon:manager.location];
    //   }
}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    NSLog(@"didSelectAnnotationView.....%@",view);
}

-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation
{
    @try {
        
        MKAnnotationView *pinView = nil;
        if(annotation != mapView.userLocation)
        {
            static NSString *defaultPinID = @"com.invasivecode.pin";
            pinView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
            if ( pinView == nil )
            {
                pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:defaultPinID];
            }
            pinView.canShowCallout = YES;
            
            pinView.image = [UIImage imageNamed:@"map2.png"];
            
        }
        else {
            [mapView.userLocation setTitle:@"Current Location"];
        }
        
        pinView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        pinView.canShowCallout = YES;
        
        
        return pinView;
        
    }
    @catch (NSException *exception) {
        NSLog(@"exception pin.....%@",exception);
        
    }
}
- (void)locationManager:(CLLocationManager*)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status)
    {
        case kCLAuthorizationStatusNotDetermined:
        {
            
            
        } break;
        case kCLAuthorizationStatusDenied:
        {
            [locationManager stopUpdatingLocation];
            
            UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Access denied",@"") message:NSLocalizedString(@"Access denied for location service to re-enable, please go to Settings and turn on Location Service for this app.",@"")  delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",@"")otherButtonTitles:nil];
            [errorAlert show];
            
            
        } break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {
            
        }
        case kCLAuthorizationStatusAuthorizedAlways:
        {
            
            
            
        }
            break;
        default:
            break;
    }
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    NSLog(@"calloutAccessoryControlTapped.....");
    
    @try {
        NSLog(@"didSelectAnnotationView.....%@",view);
        NSArray *selectedAnnotations = self.mapView.selectedAnnotations;
        int ii = 0;
        for (mapClass *annotationView in selectedAnnotations)
        {
            [self.mapView deselectAnnotation:annotationView animated:YES];
            ii++;
            BussnessDic = [serchListArr objectAtIndex:ii];
            
            NSLog(@"BussnessDic = %@", BussnessDic);
            NSMutableDictionary * dictBD = [[NSMutableDictionary alloc] init];
            dictBD = [BussnessDic mutableCopy];
            [dictBD setObject:kAppDelegate.strSubCategory forKey:@"subcategory_image"];
            
            self.isserchsetview=true;
            FMDBManager *fm = [[FMDBManager alloc] init];
            [fm openDataBase];
            [fm saveTude:[dictBD mutableCopy]];
            [self performSegueWithIdentifier:@"Details" sender:self];
        }
        NSLog(@"selectedAnnotations.....%@",selectedAnnotations);

    }
    @catch (NSException *exception) {
        NSLog(@"exception.....%@",exception);
    }
}




@end

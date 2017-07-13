//
//  MapListViewController.m
//  All Info
//
//  Created by Mahendra Suryavanshi on 3/5/16.
//  Copyright © 2016 PS.com. All rights reserved.
//
#import "LocationViewController.h"
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
//#import <GoogleMaps/GoogleMaps.h>
//#import "SMCalloutView.h"

static const CGFloat CalloutYOffset = 50.0f;

@interface MapListViewController ()<MenuViewControllerDelegates,UITabBarControllerDelegate> {
    
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
   // GMS
   // GMSMapView * gMapView;
    
}
//@property (strong, nonatomic) SMCalloutView *calloutView;
@property (strong, nonatomic) UIView *emptyCalloutView;
@end

@implementation MapListViewController
bool isShowngif1 = false;
@synthesize mapView,locationManager, intLimit, strSCName;

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
}
- (void)viewWillAppear:(BOOL)animated {
    _lbl_SubCategoryName.text = strSCName;
    [super viewWillAppear:animated];
    viewSearch.hidden=YES;
    HistoryInfo=[[Allinfo alloc]init];
    [sample.view removeFromSuperview];
    self.tabBarController.tabBar.hidden=NO;
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * sLat, * sLong;
    if([defaults objectForKey:@"SelectedLatitude"] != nil) {
        sLat = [defaults objectForKey:@"SelectedLatitude"];
    }
    if([defaults objectForKey:@"SelectedLongitude"] != nil) {
        sLong = [defaults objectForKey:@"SelectedLongitude"];
    }
    
    CLLocationCoordinate2D userLocation =CLLocationCoordinate2DMake([sLat floatValue],[sLong floatValue]);
    //[gMapView animateToLocation:userLocation];

}

-(void) tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    NSLog(@"working");
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
  
    classUnicode=[[UnicodeConversionClass alloc]init];
    [self initFooterView];
    [self fetchLocation];
    
    serchListArr = [[NSMutableArray alloc] init];
    if (self.issearch==YES) {
        [self performSelector:@selector(serchByprodect) withObject:nil afterDelay:1.0f];
    }else{
        [self performSelector:@selector(GetprodectList) withObject:nil afterDelay:1.0f];
    }
 //   [self loadGMapView];
}


- (void)initFooterView {
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

- (void) loadGMapView {
  //  GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude
                                                        //    longitude:longitude
                                                        //         zoom:12];
   // CGRect gFrame = CGRectMake(0, 74, self.view.frame.size.width, self.view.frame.size.height);
    //gMapView = [GMSMapView mapWithFrame:gFrame camera:camera];
    //  gMapView.delegate = self;
   // [self.view addSubview:gMapView];
}


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:NSLocalizedString(@"Error",nil) message:NSLocalizedString(@"Failed to Get Your Location",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
   // [errorAlert show];
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
    } else if ([segue.identifier isEqualToString:@"Details"]) {
        
        NSMutableDictionary * dictBD = [[NSMutableDictionary alloc] init];
        dictBD = [BussnessDic mutableCopy];
        [dictBD setObject:kAppDelegate.strSubCategory forKey:@"subcategory_image"];
        kAppDelegate.flagIsShowAverageRating = NO;
        BusinessdetailsViewController *Bissnesdetails=segue.destinationViewController;
        Bissnesdetails.getBussnessDic=[dictBD mutableCopy];
        Bissnesdetails.isserchsetview=true;
    } else if ([segue.identifier isEqualToString:@"search"]){
        GifFileViewController *gif=segue.destinationViewController;
        //gif.serchnamearr=BissArr;
        gif.serchByName=textSearch.text;
        gif.issearch=YES;
        [textSearch resignFirstResponder];
        textSearch.text=@"";
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
                    NSLog(@"serchListArr = %d", (int)serchListArr.count);
                    
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

- (IBAction)ActionOnmenu:(id)sender {
   /* if (!isShowngif1) {
        
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
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromRight;
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [sample.view.layer addAnimation:transition forKey:nil];
        [sample.view performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.5];
        
        isShowngif1 = false;
    } */
    [self .navigationController popViewControllerAnimated:NO];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==1) {
        if (buttonIndex == 0){
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"login"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"userdata"];
        }
    }
}

- (IBAction)btn_Share:(id)sender {
    viewSearch.hidden=NO;
    
}

- (IBAction)btn_SearchClose:(id)sender {
    viewSearch.hidden=YES;
    
    
    if (textSearch.text.length==0) {}
    else{
        [textSearch resignFirstResponder];
        [self performSegueWithIdentifier:@"search" sender:self];
    }
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
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Are you sure you want to logout?",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK" ,nil)otherButtonTitles:NSLocalizedString(@"Cancel",nil), nil];
            alert.tag=1;
            [alert show];
        }
            break;
        case 7:
        {
            NSDictionary *UserDict =[[NSUserDefaults standardUserDefaults] objectForKey:@"userdata"];
            if (UserDict == nil) {
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"" message:NSLocalizedString(@"Please login first",nil) preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* yesButton = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                    
                    LoginViewController *LoginView = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
                    LoginView.tabBarController.tabBar.hidden = YES;
                    [self.navigationController pushViewController:LoginView animated:YES];
                    
                }];
                UIAlertAction* CancelButton = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                }];
                
                [alert addAction:yesButton];
                [alert addAction:CancelButton];
                
                [self presentViewController:alert animated:YES completion:nil];
            } else {
                IntrestCatViewController *price1=[self.storyboard instantiateViewControllerWithIdentifier:@"IntrestCatViewController"];
               // price1.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
               // price1.modalPresentationStyle = UIModalPresentationFormSheet;
                [self presentViewController:price1 animated:true completion:nil];
            }
            
        }
            break;
        case 8:
        {
            LocationViewController*vcLocationViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LocationViewController"];
            vcLocationViewController.tabBarController.tabBar.hidden = YES;
            [self.navigationController pushViewController:vcLocationViewController animated:YES];
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
    
    NSString *urlStr=[NSString stringWithFormat:@"http://allinfo.co.il/all_info/webservice/master.php?action=search&string=%@&latitude=%@&longitude=%@&page_no=%@&limit=%@",self.serchByName ,Userlat,Userlong,[NSString stringWithFormat:@"%li",(long)1],@"100"];
    
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
    NSLog(@"intLimit = %d", intLimit);
    //pp here
    /// dynamic
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * strLat = @"", * strLong = @"";
    if([defaults objectForKey:@"SelectedLatitude"] != nil) {
        Userlat = [defaults objectForKey:@"SelectedLatitude"];
        
    }
    if([defaults objectForKey:@"SelectedLongitude"] != nil) {
        Userlong = [defaults objectForKey:@"SelectedLongitude"];
    }
    
    
    NSString *urlStr=[NSString stringWithFormat:@"http://allinfo.co.il/all_info/webservice/master.php?action=searchBusiness&sub_cat_id=%@&language_id=%@&latitude=%@&longitude=%@&page_no=%@&limit=%d",[self.getSubcategryDic objectForKey:@"sub_cat_id"] ,@"2",Userlat,Userlong,[NSString stringWithFormat:@"%li",(long)1],intLimit];

    ///Static
    //   NSString *urlStr=[NSString stringWithFormat:@"http://allinfo.co.il/all_info/webservice/master.php?action=searchBusiness&sub_cat_id=%@&language_id=%@&latitude=%@&longitude=%@&page_no=%@&limit=%@",[self.getSubcategryDic objectForKey:@"sub_cat_id"] ,@"2", @"31.789520", @"35.185456", [NSString stringWithFormat:@"%li",(long)1],@"100"];
    
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
    if([[[UIDevice currentDevice] systemVersion] integerValue] >= 8) {
        [locationManager requestWhenInUseAuthorization];
    }
    [locationManager startUpdatingLocation];
    longitude=locationManager.location.coordinate.longitude;
    latitude=locationManager.location.coordinate.latitude;
    
    location = [locationManager location];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
         if (error){
             NSLog(@"Geocode failed with error::::: %@", error);
             return;
         }
     }];
}

-(void)removeAllAnnotations {
    id userAnnotation = self.mapView.userLocation;
    NSMutableArray *annotations = [NSMutableArray arrayWithArray:self.mapView.annotations];
    [annotations removeObject:userAnnotation];
    [self.mapView removeAnnotations:annotations];
}

-(void)map_pinAnnotation {
    @try {

        //// Hre is my logic
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSString * strLat = @"", * strLong = @"";
        if([defaults objectForKey:@"SelectedLatitude"] != nil) {
            strLat = [defaults objectForKey:@"SelectedLatitude"];
            latitude = strLat.floatValue;
        }
        if([defaults objectForKey:@"SelectedLongitude"] != nil) {
            strLong = [defaults objectForKey:@"SelectedLongitude"];
            longitude = strLong.floatValue;
        }
        
        [self removeAllAnnotations];
        cord_Current=CLLocationCoordinate2DMake(latitude,longitude);
        mapView.delegate=self;
        
//        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(cord_Current, 200000, 200000);
//        MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
//        [self.mapView setRegion:adjustedRegion animated:YES];
        self.mapView.showsUserLocation = YES;

        NSMutableArray *arr_lat=[[NSMutableArray alloc]init];
        NSMutableArray *arr_long=[[NSMutableArray alloc]init];
        NSMutableArray *arr_AnnoText=[[NSMutableArray alloc]init];
        NSMutableArray *arr_AnnoPrice=[[NSMutableArray alloc]init];

        arr_lat=[serchListArr valueForKey:@"latitude"];
        arr_long=[serchListArr valueForKey:@"longitude"];
        arr_AnnoText=[serchListArr valueForKey:@"business_name"];
        arr_AnnoPrice=[serchListArr valueForKey:@"phone"];
        NSLog(@"arr_AnnoText....%@",arr_AnnoText);
        
        
        
        CLLocation * loc1 = [[CLLocation alloc] initWithLatitude:[arr_lat[0] floatValue] longitude:[arr_long[0] floatValue]];
        // CLLocation * loc1 = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
        CLLocation * loc2 = [[CLLocation alloc] initWithLatitude:[arr_lat[arr_lat.count - 1] floatValue] longitude:[arr_long[arr_long.count - 1] floatValue]];
        CLLocationDistance distance = [loc1 distanceFromLocation:loc2];
        NSLog(@"distance = %f", distance / 1000);
        
        float multiplier = (intLimit/ 10) * 2.5;
        
        NSLog(@"distance * multiplier = %f", multiplier);
        NSLog(@"distance * multiplier = %f", (distance / 1500) - (multiplier * multiplier));
        
        //[gMapView setMinZoom:1.0 maxZoom:(distance / 1500) - (multiplier * multiplier)];
       // [gMapView setMinZoom:5.0 maxZoom:10.0];
      //  [gMapView animateToZoom:8.5];
     //   [gMapView setMyLocationEnabled:YES];
        
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(cord_Current, distance * multiplier, distance * multiplier);
        MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
        
        [self.mapView setRegion:adjustedRegion animated:YES];
        
        for (int i=0; i<arr_lat.count; i++) {

            CLLocationCoordinate2D position = CLLocationCoordinate2DMake([arr_lat[i] floatValue], [arr_long[i] floatValue]);
         //   GMSMarker *london = [GMSMarker markerWithPosition:position];
         //   london.title = [classUnicode StringToConvert:arr_AnnoText[i]];
         //   london.icon = [UIImage imageNamed:@"map2.png"];
        //    london.accessibilityLabel = [NSString stringWithFormat:@"%d", i];
        //    london.userData = serchListArr[i];
        //    london.map = gMapView;
            //london.
            
            NSString *imageToLoad = [serchListArr[i] objectForKey:@"product_image1"];
            NSString *imageToLoad2 = [serchListArr[i] objectForKey:@"product_image2"];
            NSString *imageToLoad3 = [serchListArr[i] objectForKey:@"product_image3"];
            NSString *imageToLoad4 = [serchListArr[i] objectForKey:@"product_image4"];
            NSString *imageToLoad5 = [serchListArr[i] objectForKey:@"product_image5"];
            NSString *imageToLoad6 = [serchListArr[i] objectForKey:@"product_image6"];
            NSString *imageToLoad7 = [serchListArr[i] objectForKey:@"product_image7"];
            NSString *imageToLoad8 = [serchListArr[i] objectForKey:@"product_image8"];
            NSString *imageToLoad9 = [serchListArr[i] objectForKey:@"product_image9"];
            NSString *imageToLoad10 = [serchListArr[i] objectForKey:@"product_image10"];
            NSString *strImgUrl;
            if(imageToLoad.length > 0) {
                strImgUrl=imageToLoad;
            } else if(imageToLoad2.length > 0) {
                strImgUrl=imageToLoad2;
            } else if(imageToLoad3.length > 0) {
                strImgUrl=imageToLoad3;
            } else if(imageToLoad4.length > 0) {
                strImgUrl=imageToLoad4;
            } else if(imageToLoad5.length > 0) {
                strImgUrl=imageToLoad5;
            } else if(imageToLoad6.length > 0) {
                strImgUrl=imageToLoad6;
            } else if(imageToLoad7.length > 0) {
                strImgUrl=imageToLoad7;
            } else if(imageToLoad8.length > 0) {
                strImgUrl=imageToLoad8;
            } else if(imageToLoad9.length > 0) {
                strImgUrl=imageToLoad9;
            } else if(imageToLoad10.length > 0) {
                strImgUrl=imageToLoad10;
            } else {
                strImgUrl=kAppDelegate.strSubCategory;
            }
            CLLocationCoordinate2D cord1=CLLocationCoordinate2DMake([arr_lat[i] floatValue],[arr_long[i] floatValue]);
            shop1=[[mapClass alloc]initWithTitle:@"                  "
                    andCoordinate:cord1
                    andFlavours: strImgUrl
                    selectedID:[NSString stringWithFormat:@"%d",i]
                    subTitle1:[classUnicode StringToConvert:arr_AnnoText[i]]
                   ];
            [mapView addAnnotation:shop1];
        }
    }  @catch (NSException *exception)  {
        NSLog(@"exception map_pin....%@",exception);
    }
}

#pragma mark mapView Delegates

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    [self.locationManager stopUpdatingLocation];
    self.locationManager.delegate = nil;
    location = [locationManager location];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    self.locationManager.distanceFilter = 5;
    longitude=manager.location.coordinate.longitude;
    latitude=manager.location.coordinate.latitude;
    
    NSLog(@"dLongitude :::: %f", longitude);
    NSLog(@"dLatitude :::: %f", latitude);
    
}

-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation {
    @try {
        mapClass *m=(mapClass*)annotation;
        MKAnnotationView *pinView = nil;
        if(annotation != mapView.userLocation) {
            static NSString *defaultPinID = @"com.invasivecode.pin";
            pinView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
            if ( pinView == nil ) {
                pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:defaultPinID];
            }
            pinView.canShowCallout = YES;
            pinView.image = [UIImage imageNamed:@"map2.png"];
            viewMapTap=[[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, 125.0, 90.0)];
            [viewMapTap setBackgroundColor:[UIColor whiteColor]];

            imgMapTap=[[UIImageView alloc]initWithFrame:CGRectMake(0.0, -20.0, 115.0, 90.0)];
            [imgMapTap sd_setImageWithURL:[NSURL URLWithString:m.flavours] placeholderImage:[UIImage imageNamed:@"map_icon2@3x.png"]];
            [viewMapTap addSubview:imgMapTap];
            
            lblMapTap=[[UILabel alloc]initWithFrame:CGRectMake(0.0, 70.0, 125.0, 30.0)];
            lblMapTap.text=m.subTitle1;
            lblMapTap.numberOfLines=2;
            lblMapTap.textAlignment=NSTextAlignmentCenter;
            [lblMapTap setFont:[UIFont systemFontOfSize:10.0]];
            
            UIButton * btnTapped = [[UIButton alloc] init];
            btnTapped.frame = viewMapTap.frame;
            btnTapped.tag = m.selectedID.integerValue;
            [btnTapped addTarget:self action:@selector(tappedForDetail:) forControlEvents:UIControlEventTouchUpInside];
            [btnTapped setBackgroundColor:[UIColor clearColor]];
            [viewMapTap addSubview:lblMapTap];
            [viewMapTap addSubview:btnTapped];
            pinView.detailCalloutAccessoryView = viewMapTap;
            
            NSLayoutConstraint *width = [NSLayoutConstraint
                  constraintWithItem:viewMapTap
                  attribute:NSLayoutAttributeWidth
                  relatedBy:NSLayoutRelationLessThanOrEqual
                  toItem:nil
                  attribute:NSLayoutAttributeNotAnAttribute
                  multiplier:1
                  constant:80];
            
            NSLayoutConstraint *height = [NSLayoutConstraint
                  constraintWithItem:viewMapTap
                  attribute:NSLayoutAttributeHeight
                  relatedBy:NSLayoutRelationGreaterThanOrEqual
                  toItem:nil
                  attribute:NSLayoutAttributeNotAnAttribute
                  multiplier:1
                  constant:90];
            
             [viewMapTap addConstraint:width];
             [viewMapTap addConstraint:height];
             viewMapTap.backgroundColor = [UIColor clearColor];
            pinView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            pinView.canShowCallout = YES;
        } else {
            [mapView.userLocation setTitle:@"Current Location"];
        }
        return pinView;
    }
    @catch (NSException *exception) {
        NSLog(@"exception pin.....%@",exception);
    }
}

- (void)tappedForDetail:(id)sender
{
    
    BussnessDic = [serchListArr objectAtIndex:[sender tag]];
    NSMutableDictionary * dictBD = [[NSMutableDictionary alloc] init];
    dictBD = [BussnessDic mutableCopy];
    [dictBD setObject:kAppDelegate.strSubCategory forKey:@"subcategory_image"];
    
    self.isserchsetview=true;
    FMDBManager *fm = [[FMDBManager alloc] init];
    [fm openDataBase];
    [fm saveTude:[dictBD mutableCopy]];
    [self performSegueWithIdentifier:@"Details" sender:self];
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    NSLog(@"calloutAccessoryControlTapped.....");
    
    @try {
        
        NSArray *selectedAnnotations = self.mapView.selectedAnnotations;
        for (mapClass *annotationView in selectedAnnotations)
        {
            [self.mapView deselectAnnotation:annotationView animated:YES];
            
            BussnessDic = [serchListArr objectAtIndex:[annotationView.selectedID integerValue]];
            NSMutableDictionary * dictBD = [[NSMutableDictionary alloc] init];
            dictBD = [BussnessDic mutableCopy];
            [dictBD setObject:kAppDelegate.strSubCategory forKey:@"subcategory_image"];
            
            self.isserchsetview=true;
            FMDBManager *fm = [[FMDBManager alloc] init];
            [fm openDataBase];
            [fm saveTude:[dictBD mutableCopy]];
            [self performSegueWithIdentifier:@"Details" sender:self];
            //break;
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"exception.....%@",exception);
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
        case kCLAuthorizationStatusAuthorizedAlways: {
            
        }
            break;
        default:
            break;
    }
}

#pragma mark - GMSMapViewDelegate
/*
- (UIView *)mapView:(GMSMapView *)mapViewG markerInfoWindow:(GMSMarker *)marker {
    CLLocationCoordinate2D anchor = marker.position;
    
    int indexVal = (int) marker.accessibilityLabel;
    
    CGPoint point = [mapViewG.projection pointForCoordinate:anchor];
    
    self.calloutView.title = marker.title;
    
    self.calloutView.calloutOffset = CGPointMake(0, -CalloutYOffset);
    
    self.calloutView.hidden = NO;
    
    CGRect calloutRect = CGRectZero;
    calloutRect.origin = point;
    calloutRect.size = CGSizeMake(200, 150);
    
    [self.calloutView presentCalloutFromRect:calloutRect
                                      inView:mapViewG
                           constrainedToView:mapViewG
                                    animated:YES];
    
    return self.emptyCalloutView;
}

- (void)mapView:(GMSMapView *)pMapView didChangeCameraPosition:(GMSCameraPosition *)position {
    / move callout with map drag /
    /*if (pMapView.selectedMarker != nil && !self.calloutView.hidden) {
        CLLocationCoordinate2D anchor = [pMapView.selectedMarker position];
        
        CGPoint arrowPt = self.calloutView.backgroundView.arrowPoint;
        
        CGPoint pt = [pMapView.projection pointForCoordinate:anchor];
        pt.x -= arrowPt.x;
        pt.y -= arrowPt.y + CalloutYOffset;
        
        self.calloutView.frame = (CGRect) {.origin = pt, .size = self.calloutView.frame.size };
    } else {
        self.calloutView.hidden = YES;
    }
}

- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate {
    self.calloutView.hidden = YES;
}

- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker {
    /* don't move map camera to center marker on tap *
    
    
    
//    [gMapView animateToLocation:marker.position];
    NSLog(@"marker = %d", (int)marker.zIndex);
    //gMapView.selectedMarker = marker;
    return YES;
}
*/
@end

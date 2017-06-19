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
    [super viewWillAppear:animated];

    viewSearch.hidden=YES;

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
    classUnicode=[[UnicodeConversionClass alloc]init];
    [self initFooterView];
    [self fetchLocation];
    
    serchListArr = [[NSMutableArray alloc] init];
    if (self.issearch==YES) {
        [self performSelector:@selector(serchByprodect) withObject:nil afterDelay:1.0f];
    }else{
        [self performSelector:@selector(GetprodectList) withObject:nil afterDelay:1.0f];
    }

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
                               initWithTitle:NSLocalizedString(@"Error",nil) message:NSLocalizedString(@"Failed to Get Your Location",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
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
    
   else if ([segue.identifier isEqualToString:@"Details"]) {
        
        NSMutableDictionary * dictBD = [[NSMutableDictionary alloc] init];
        dictBD = [BussnessDic mutableCopy];
        [dictBD setObject:kAppDelegate.strSubCategory forKey:@"subcategory_image"];
        
        
        kAppDelegate.flagIsShowAverageRating = NO;
        BusinessdetailsViewController *Bissnesdetails=segue.destinationViewController;
        Bissnesdetails.getBussnessDic=[dictBD mutableCopy];
        Bissnesdetails.isserchsetview=true;
    }
    
    else if ([segue.identifier isEqualToString:@"search"]){
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
        transition.type = kCATransitionPush;
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
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Alert",nil) message:NSLocalizedString(@"Are you sure you want to logout?",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK" ,nil)otherButtonTitles:NSLocalizedString(@"Cancel",nil), nil];
            alert.tag=1;
            [alert show];
        }
            break;
        case 7:
        {
            NSDictionary *UserDict =[[NSUserDefaults standardUserDefaults] objectForKey:@"userdata"];
            if (UserDict == nil) {
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Alert",nil) message:NSLocalizedString(@"Please login first",nil) preferredStyle:UIAlertControllerStyleAlert];
                
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
            }
            else
            {
                IntrestCatViewController *price1=[self.storyboard instantiateViewControllerWithIdentifier:@"IntrestCatViewController"];
               // price1.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
               // price1.modalPresentationStyle = UIModalPresentationFormSheet;
                [self presentViewController:price1 animated:true completion:nil];
            }
            
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
   
    //pp here
    /// dynamic
    NSString *urlStr=[NSString stringWithFormat:@"http://allinfo.co.il/all_info/webservice/master.php?action=searchBusiness&sub_cat_id=%@&language_id=%@&latitude=%@&longitude=%@&page_no=%@&limit=%@",[self.getSubcategryDic objectForKey:@"sub_cat_id"] ,@"2",Userlat,Userlong,[NSString stringWithFormat:@"%li",(long)1],@"100"];

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
         //CLPlacemark *placemark = [placemarks objectAtIndex:0];
         //         _strAddress = [NSString stringWithFormat:@"%@ %@, %@ %@, %@",
         //                          placemark.subThoroughfare, placemark.thoroughfare,
         //                          placemark.postalCode, placemark.locality,
         //                          placemark.country];
         
         //         NSArray *lines = placemark.addressDictionary[ @"FormattedAddressLines"];
         //         _strAddress = [lines componentsJoinedByString:@", "];
         
         // NSString *strCountry = placemark.country;
         // NSString *strCity = placemark.locality;
         
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
        
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(cord_Current, 10000, 100000);
        MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
        [self.mapView setRegion:adjustedRegion animated:YES];
        self.mapView.showsUserLocation = YES;

        //  MKCoordinateRegion region=MKCoordinateRegionMakeWithDistance(cord_Current,100,100);
        //  [mapView setRegion:region animated:true];
        
        // arrUser_detail=[arrAdsList valueForKey:@"user_detail"];
        
        
        NSMutableArray *arr_lat=[[NSMutableArray alloc]init];
        NSMutableArray *arr_long=[[NSMutableArray alloc]init];
        NSMutableArray *arr_AnnoText=[[NSMutableArray alloc]init];
        NSMutableArray *arr_AnnoPrice=[[NSMutableArray alloc]init];

        arr_lat=[serchListArr valueForKey:@"latitude"];
        arr_long=[serchListArr valueForKey:@"longitude"];
        arr_AnnoText=[serchListArr valueForKey:@"business_name"];
        arr_AnnoPrice=[serchListArr valueForKey:@"phone"];

        NSLog(@"arr_AnnoText....%@",arr_AnnoText);
        
        for (int i=0; i<arr_lat.count; i++)
        {
            
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
        
    }
    @catch (NSException *exception)
    {
        NSLog(@"exception map_pin....%@",exception);
    }
}


#pragma mark mapView Delegates

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [self.locationManager stopUpdatingLocation];
    self.locationManager.delegate = nil;
    
    location = [locationManager location];
    longitude=manager.location.coordinate.longitude;
    latitude=manager.location.coordinate.latitude;
    NSLog(@"dLongitude :::: %f", longitude);
    NSLog(@"dLatitude :::: %f", latitude);
    
}

-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation
{
    @try {
        mapClass *m=(mapClass*)annotation;
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
            [viewMapTap addSubview:lblMapTap];
            
            
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

        }
        else {
            [mapView.userLocation setTitle:@"Current Location"];
        }
        
        return pinView;
        
    }
    @catch (NSException *exception) {
        NSLog(@"exception pin.....%@",exception);
        
    }
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
        case kCLAuthorizationStatusAuthorizedAlways:
        {
            
            
            
        }
            break;
        default:
            break;
    }
}



@end

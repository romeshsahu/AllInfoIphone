//
//  MapViewController.m
//  Sertrak
//
//  Created by Parkhya Solutions on 12/17/14.
//  Copyright (c) 2014 Parkhya Solutions Pvt Ltd. All rights reserved.
//

#import "MapViewController.h"
#import "MapPoint.h"
#import "AsyncImageView.h"
#import "WSOperationInEDUApp.h"
#import "SPGooglePlacesAutocompleteQuery.h"
#import "SPGooglePlacesAutocompletePlace.h"
@interface MapViewController ()<UITextFieldDelegate,UITableViewDataSource>
{
    CLGeocoder *geocoder;
    NSArray *placemarks;
    NSDictionary *locationdata;
    NSDictionary *lcation2;
    NSDictionary *updatelcation;
    NSDictionary *updatelcation2;
    CLLocationManager *manager;
    CLPlacemark *placemark;
    BOOL mapvalue;
    BOOL issecond;
    BOOL isFromReprsenativevalue;
    double longitude;
    double latitude;
    MKLocalSearch *localSearch;
    MKLocalSearchResponse *results;
    MKPlacemark *selectedItem;
    NSString *getaddress;
    NSString* userlat;
    NSString*userlong;
    CLLocationCoordinate2D centernew;
    
}

@end

@implementation MapViewController
@synthesize mapView,arr,repAdd,trackMapName,addbtnout;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _ibAddressTableView.layer.masksToBounds = NO;
    _ibAddressTableView.layer.shadowColor = [UIColor blackColor].CGColor;
    _ibAddressTableView.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    _ibAddressTableView.layer.shadowOpacity = 0.8f;

    [_ibAddressTableView setSeparatorInset:UIEdgeInsetsZero];
    _ibAddressTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    searchQuery = [[SPGooglePlacesAutocompleteQuery alloc] init];
    searchQuery.radius = 100.0;
    manager = [[CLLocationManager alloc] init];
    manager.delegate=self;
    manager.distanceFilter=kCLDistanceFilterNone;
    manager.desiredAccuracy=kCLLocationAccuracyBest;
    [manager startUpdatingLocation];
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(foundTap:)];
    tapRecognizer.numberOfTapsRequired = 1;
    tapRecognizer.numberOfTouchesRequired = 1;
    mapView.showsUserLocation = YES;
    //mapView.mapType = MKMapTypeHybrid;
    // [mapView setMapType:MKMapTypeStandard];
    ///self.mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;
    mapView.delegate = self;
    //[self.view addSubview:mapView];
    if(self.locationUseBool==YES){
        //[self.mapView addGestureRecognizer:tapRecognizer];
    }
    
   
    //[self updateMaps:arr];
    // Do any additional setup after loading the view.
}

- (void)mapView:(MKMapView *)aMapView didUpdateUserLocation:(MKUserLocation *)aUserLocation {
//    for (id<MKAnnotation> annotation in self.mapView.annotations)
//    {
//        // NSLog(@" in for annotation ");
//        if ([annotation isKindOfClass:[MapPoint class]])
//        {
//            // NSLog(@"in if annotation");
//            [self.mapView removeAnnotation:annotation];
//        }
//    }
//    CLLocationCoordinate2D placeCoord;
//    placeCoord.latitude=aUserLocation.coordinate.latitude;
//    placeCoord.longitude=aUserLocation.coordinate.longitude;
//    NSString *add;
//    NSString *name;
//    MapPoint *placeObject ;
//   
//    placeObject = [[MapPoint alloc] initWithName:name address:add coordinate:placeCoord];
//    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        MKCoordinateRegion region1;
//        [self.mapView addAnnotation:placeObject];
//        region1.center = self.mapView.userLocation.coordinate;
//        region1.center=placeCoord;
//        //region1.span.longitudeDelta=100 ;
//        //region1.span.latitudeDelta=100;
//        
//        MKCoordinateSpan zoom;
//        zoom.latitudeDelta = 1.01f; //the zoom level in degrees
//        zoom.longitudeDelta =1.01f;//the zoom level in degrees
//        //the location
//        region1.span = zoom;//set zoom level
//        //            region1.span.longitudeDelta=100 ;
//        // region1.span.latitudeDelta=100;
//        [self.mapView setRegion:region1 animated:YES];
//    });
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(aUserLocation.coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
}

#pragma mark - adding pins on map through this method
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *newLocation = [locations firstObject];
    
    // here we get the current location
}
-(void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    MKAnnotationView *ulv = [self.mapView viewForAnnotation:self.mapView.userLocation];
    ulv.enabled = NO;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    static NSString *identifier = @"MapPoint";
    MKPinAnnotationView *annotationV;
    if ([annotation isKindOfClass:[MapPoint class]]) {
        annotationV = (MKPinAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationV == nil) {
            annotationV = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            AsyncImageView *lbl = [[AsyncImageView alloc] initWithFrame:CGRectMake(20, 21, 65, 45)];
            lbl.tag = 42;
            [annotationV addSubview:lbl];
        }
        else
        {
            annotationV.annotation = annotation;
        }
        
        annotationV.canShowCallout = YES;
        //MapPoint *places=annotation;
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        [[self.mapView viewForAnnotation:point] setTag:1];
        UIImage *image = [UIImage imageNamed:@"Home.png"];
        [[self.mapView viewForAnnotation:point] setImage:image];
        isFromReprsenativevalue=YES;
        if (self.isfromUpdate==YES ) {
            annotationV.image=[UIImage imageNamed:@"Home.png"];
            
        }else
            annotationV.image=[UIImage imageNamed:@"Home.png"];
        
        return annotationV;
    }
    return nil;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString*)getAddressFromLatLon:(CLLocation*) location{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if(placemarks && placemarks.count > 0)
         {
              placemark= [placemarks objectAtIndex:0];
               NSLog(@"placemark %@",placemark);
             // address defined in .h file
             locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
             locationdata= placemark.addressDictionary;
             lcation2= placemark.addressDictionary;
             updatelcation= placemark.addressDictionary;
             updatelcation2= placemark.addressDictionary;
             CLLocationCoordinate2D coordinate = location.coordinate;
             latitude = coordinate.latitude;
             longitude = coordinate.longitude;
             [[NSUserDefaults standardUserDefaults]setValue:locatedAt forKey:@"Mapdata"];
             [[NSUserDefaults standardUserDefaults] setDouble:latitude forKey:@"latitude"];
             [[NSUserDefaults standardUserDefaults] setDouble:longitude forKey:@"longitude"];
             [[NSUserDefaults standardUserDefaults]setValue:locationdata forKey:@"location"];
             [[NSUserDefaults standardUserDefaults]setValue:lcation2 forKey:@"location2"];

             NSLog(@"View Controller get Location Logitute : %f",coordinate.latitude);
             NSLog(@"View Controller get Location Latitute : %f",coordinate.longitude);
             NSLog(@"addressDictionary %@", placemark.addressDictionary);
                  NSLog(@"placemark %@",placemark.region);
                  NSLog(@"placemark %@",placemark.country);  // Give Country Name
                  NSLog(@"placemark %@",placemark.locality); // Extract the city name
                  NSLog(@"location %@",placemark.name);
                  NSLog(@"location %@",placemark.ocean);
                  NSLog(@"location %@",placemark.postalCode);
                  NSLog(@"location %@",placemark.subLocality);
                  NSLog(@"location %@",placemark.location);
                  //Print the location to console
                  NSLog(@"I am currently at %@",locatedAt);
             [self.navigationController popViewControllerAnimated:YES];
         }
     }];
  
    return locatedAt;
}
- (void)selectUserLocation:(id)annotation{
    
    [self.mapView selectAnnotation:annotation animated:YES];
}
- (IBAction)BackBtn:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)ActionOnDone:(id)sender {
    if (_isaddnew==YES) {
        if (selectedItem != nil) {
            [self.delegates MapAddress:getaddress La:userlat log:
                 userlong];
        }else{
            [self.delegates MapAddress:self.SerchaddressText.text La:userlat log:userlong];

        
        }
    }else{
      if (selectedItem != nil) {
            [self.delegates MapAddress:getaddress La:userlat log:
             userlong];
      }else{
          
          [self.delegates MapAddress:self.SerchaddressText.text La:userlat log:userlong];
           //userlong];
      }
    }
    [self.navigationController popViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:YES completion:nil];
}
-(CLLocationCoordinate2D) getLocationFromAddressString: (NSString*) addressStr {
    double latitude = 0, longitude = 0;
    NSString *esc_addr =  [addressStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *req = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", esc_addr];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    if (result) {
        NSScanner *scanner = [NSScanner scannerWithString:result];
        if ([scanner scanUpToString:@"\"lat\" :" intoString:nil] && [scanner scanString:@"\"lat\" :" intoString:nil]) {
            [scanner scanDouble:&latitude];
            if ([scanner scanUpToString:@"\"lng\" :" intoString:nil] && [scanner scanString:@"\"lng\" :" intoString:nil]) {
                [scanner scanDouble:&longitude];
            }
        }
    }
   
    centernew.latitude=latitude;
    centernew.longitude = longitude;
    userlat = [NSString stringWithFormat:@"%f", centernew.latitude];
    userlong = [NSString stringWithFormat:@"%f", centernew.longitude];
    NSLog(@"View Controller get Location Logitute : %f",centernew.latitude);
    NSLog(@"View Controller get Location Latitute : %f",centernew.longitude);
    return centernew;
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    NSMutableString *newString=[[NSMutableString alloc]initWithString:textField.text];
    if ([string isEqualToString: @""])
    {
        
        if (newString.length==0) {
            
        }else{
            NSRange ran=NSMakeRange(0, newString.length-1);
            
            NSString *str=[newString stringByReplacingCharactersInRange:ran withString:@""];
            
            NSRange NewRan=[newString rangeOfString:str];
            
            
            newString=[newString stringByReplacingCharactersInRange:NewRan withString:@""];
        }
    }else{
        [newString appendString:string];
    }
    
    
    
    if ([newString isEqualToString:@""]) {
       // searchResultPlaces = nil ;
        [self.ibAddressTableView reloadData];
        self.ibAddressTableView.hidden = YES;
    }else if(newString.length>0){
        // Perform a new search.
       
        searchQuery.location = self.mapView.userLocation.coordinate;
        searchQuery.input = newString;
        
        [searchQuery fetchPlaces:^(NSArray *places, NSError *error) {
            if (error) {
//                SPPresentAlertViewWithErrorAndTitle(error, @"Could not fetch Places");
            } else {
                // [searchResultPlaces release];
                self.ibAddressTableView.hidden = NO;

                searchResultPlaces = places ;
                [self.ibAddressTableView reloadData];
                
            }
        }];
     [self getLocationFromAddressString:newString];
    }
    
    
    
    return YES;
}
#pragma mark - UITextField Delegates
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.SerchaddressText resignFirstResponder];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
   // [self.SerchaddressText resignFirstResponder];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
  //[self.SerchaddressText resignFirstResponder];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SPGooglePlacesAutocompletePlace *place = [self placeAtIndexPath:indexPath];
    [place resolveToPlacemark:^(CLPlacemark *placemark, NSString *addressString, NSError *error) {
        if (error) {
            SPPresentAlertViewWithErrorAndTitle(error, @"Could not map selected Place");
        } else if (placemark) {

            selectedItem = [[MKPlacemark alloc]initWithPlacemark:placemark];
            [self addPlacemarkAnnotationToMap:placemark addressString:addressString];
            getaddress=addressString;
            self.SerchaddressText.text=addressString;
            CLLocation *location = placemark.location;
            CLLocationCoordinate2D coordinate = location.coordinate;
            NSLog(@"coordinate = (%f, %f)", coordinate.latitude, coordinate.longitude);
            [self getLocationFromAddressString:addressString];

           //userlat = [NSString stringWithFormat:@"%f", coordinate.latitude];
           //userlong = [NSString stringWithFormat:@"%f", coordinate.longitude];
            [self recenterMapToPlacemark:placemark];
            [self.SerchaddressText resignFirstResponder];

            self.ibAddressTableView.hidden=YES;
            [self.ibAddressTableView deselectRowAtIndexPath:indexPath animated:NO];
        }
    }];
}





#pragma mark -
#pragma mark UITableViewDelegate

- (void)recenterMapToPlacemark:(CLPlacemark *)placemark {
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    
    span.latitudeDelta = 0.02;
    span.longitudeDelta = 0.02;
    
    region.span = span;
    region.center = placemark.location.coordinate;
    
    [self.mapView setRegion:region];
}

- (void)addPlacemarkAnnotationToMap:(CLPlacemark *)placemark addressString:(NSString *)address {
    [self.mapView removeAnnotation:selectedPlaceAnnotation];
    //[selectedPlaceAnnotation release];
    
    selectedPlaceAnnotation = [[MKPointAnnotation alloc] init];
    selectedPlaceAnnotation.coordinate = placemark.location.coordinate;
    selectedPlaceAnnotation.title = address;
    [self.mapView addAnnotation:selectedPlaceAnnotation];
}


#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [searchResultPlaces count];
}

- (SPGooglePlacesAutocompletePlace *)placeAtIndexPath:(NSIndexPath *)indexPath {
    return [searchResultPlaces objectAtIndex:indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"TableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] ;
    }
    
    // cell.textLabel.font = [UIFont fontWithName:@"GillSans" size:16.0];
    cell.textLabel.text = [self placeAtIndexPath:indexPath].name;
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (IBAction)bakBtn:(id)sender {
     [self.navigationController popViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:YES completion:nil];
}
@end

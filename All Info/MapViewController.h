//
//  MapViewController.h
//  Sertrak
//
//  Created by Parkhya Solutions on 12/17/14.
//  Copyright (c) 2014 Parkhya Solutions Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@protocol MapViewControllerDelegates <NSObject>

-(void)MapAddress:(NSString*)placeMark La:(NSString*)la log:(NSString*)log;

@end
@class SPGooglePlacesAutocompleteQuery;
@interface MapViewController : UIViewController <MKMapViewDelegate>
{
    NSString *address;
    NSString *locatedAt;
    NSString *Lat;
    NSString *Long;
    NSArray *searchResultPlaces;
    SPGooglePlacesAutocompleteQuery *searchQuery;
    MKPointAnnotation *selectedPlaceAnnotation;
    
    BOOL shouldBeginEditing;
    
}
@property (nonatomic,strong) id <MapViewControllerDelegates>delegates;
@property (weak, nonatomic) IBOutlet UITextField *SerchaddressText;
- (IBAction)ActionOnDone:(id)sender;
@property BOOL isaddnew;

@property (weak, nonatomic) IBOutlet UITableView *ibAddressTableView;
@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property (nonatomic, assign) MKCoordinateRegion boundingRegion;
@property (nonatomic, assign) BOOL locationUseBool;
@property NSArray *arr;
@property NSString *repAdd;
@property NSString *addressrep;
@property BOOL isfromUpdate;
- (IBAction)BackBtn:(id)sender;
@property NSString *replassname;
- (IBAction)addbtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *trackMapName;
@property (weak, nonatomic) IBOutlet UIButton *addbtnout;

- (IBAction)bakBtn:(id)sender;

- (void)updateMaps:(NSArray*)data;
@end

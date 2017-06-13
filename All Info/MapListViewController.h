//
//  MapListViewController.h
//  All Info
//
//  Created by Mahendra Suryavanshi on 3/5/16.
//  Copyright © 2016 PS.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>
#import "FMDBManager.h"
#import "Allinfo.h"
#import "MBProgressHUD.h"
#import <MapKit/MapKit.h>
#import "mapClass.h"
#import "UnicodeConversionClass.h"
#import "GifFileViewController.h"


@interface MapListViewController : UIViewController<CLLocationManagerDelegate,MKMapViewDelegate,MBProgressHUDDelegate>

{
@private
    MBProgressHUD *HUD;
    
    UnicodeConversionClass *classUnicode;
    IBOutlet UIView *viewSearch;
    IBOutlet UITextField *textSearch;
    IBOutlet UIButton *btnSearch;
    UIButton *btnMapTap;
    UIView *viewMapTap;
    UILabel *lblMapTap;
    UIImageView *imgMapTap;

}
- (IBAction)btn_Share:(id)sender;

@property bool isserchsetview;
- (IBAction)ActionOnHome:(id)sender;
@property NSString *serchByName;
@property (retain, nonatomic) NSURLConnection *connection;
@property (retain, nonatomic) NSMutableData *receivedData;

@property (retain, nonatomic) NSURLConnection *connectionnew;
@property (retain, nonatomic) NSMutableData *receivedDatanew;
- (IBAction)ActionOnmenu:(id)sender;
@property NSArray *serchnamearr;
@property BOOL issearch;
@property NSDictionary *getSubcategryDic;
- (IBAction)BackBtn:(id)sender;

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;


@end

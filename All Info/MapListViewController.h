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
#import "IntrestCatViewController.h"
//#import <GoogleMaps/GoogleMaps.h>
//#import "SMCalloutView.h"

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

@property (strong, nonatomic) IBOutlet UILabel *lbl_SubCategoryName;

@property bool isserchsetview;
@property NSString *serchByName, * strSCName;
@property (retain, nonatomic) NSURLConnection *connection;
@property (retain, nonatomic) NSMutableData *receivedData;

@property (retain, nonatomic) NSURLConnection *connectionnew;
@property (retain, nonatomic) NSMutableData *receivedDatanew;
- (IBAction)ActionOnmenu:(id)sender;
@property NSArray *serchnamearr;
@property BOOL issearch;
@property NSDictionary *getSubcategryDic;
- (IBAction)BackBtn:(id)sender;
    @property int intLimit;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end








/*-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
 {
 NSLog(@"didSelectAnnotationView.....%@",view);
 
 [viewMapTap removeFromSuperview];
 [btnMapTap removeFromSuperview];
 [lblMapTap removeFromSuperview];
 [imgMapTap removeFromSuperview];
 
 for (UITapGestureRecognizer *recognizer in self.view.gestureRecognizers) {
 [view removeGestureRecognizer:recognizer];
 }
 
 NSString *selectedSelected = [NSString stringWithFormat:@"%@",view.annotation.title];
 
 for (int i=0; i<serchListArr.count; i++)
 {
 BussnessDic = [serchListArr objectAtIndex:i];
 NSString *srtIn=[[serchListArr objectAtIndex:i] valueForKey:@"phone"];
 if ([srtIn isEqualToString:selectedSelected])
 {
 
 viewMapTap=[[UIView alloc]initWithFrame:CGRectMake(-90.0, -90.0, 90.0, 100.0)];
 [viewMapTap setBackgroundColor:[UIColor whiteColor]];
 [view addSubview:viewMapTap];
 
 imgMapTap=[[UIImageView alloc]initWithFrame:CGRectMake(10.0, 3.0, 70.0, 70.0)];
 // [imgMapTap sd_setImageWithURL:[NSURL URLWithString:srtImg] placeholderImage:[UIImage imageNamed:@"map_icon2@3x.png"]];
 ////
 NSString *imageToLoad = [BussnessDic objectForKey:@"product_image1"];
 NSString *imageToLoad2 = [BussnessDic objectForKey:@"product_image2"];
 NSString *imageToLoad3 = [BussnessDic objectForKey:@"product_image3"];
 NSString *imageToLoad4 = [BussnessDic objectForKey:@"product_image4"];
 NSString *imageToLoad5 = [BussnessDic objectForKey:@"product_image5"];
 NSString *imageToLoad6 = [BussnessDic objectForKey:@"product_image6"];
 NSString *imageToLoad7 = [BussnessDic objectForKey:@"product_image7"];
 NSString *imageToLoad8 = [BussnessDic objectForKey:@"product_image8"];
 NSString *imageToLoad9 = [BussnessDic objectForKey:@"product_image9"];
 NSString *imageToLoad10 = [BussnessDic objectForKey:@"product_image10"];
 
 NSLog(@"imageToLoad = %@", imageToLoad);
 NSLog(@"kAppDelegate.strSubCategory = %@", kAppDelegate.strSubCategory);
 if(imageToLoad.length > 0) {
 [imgMapTap sd_setImageWithURL:[NSURL URLWithString:imageToLoad] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
 } else if(imageToLoad2.length > 0) {
 [imgMapTap sd_setImageWithURL:[NSURL URLWithString:imageToLoad2] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
 } else if(imageToLoad3.length > 0) {
 [imgMapTap sd_setImageWithURL:[NSURL URLWithString:imageToLoad3] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
 } else if(imageToLoad4.length > 0) {
 [imgMapTap sd_setImageWithURL:[NSURL URLWithString:imageToLoad4] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
 } else if(imageToLoad5.length > 0) {
 [imgMapTap sd_setImageWithURL:[NSURL URLWithString:imageToLoad5] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
 } else if(imageToLoad6.length > 0) {
 [imgMapTap sd_setImageWithURL:[NSURL URLWithString:imageToLoad6] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
 } else if(imageToLoad7.length > 0) {
 [imgMapTap sd_setImageWithURL:[NSURL URLWithString:imageToLoad7] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
 } else if(imageToLoad8.length > 0) {
 [imgMapTap sd_setImageWithURL:[NSURL URLWithString:imageToLoad8] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
 } else if(imageToLoad9.length > 0) {
 [imgMapTap sd_setImageWithURL:[NSURL URLWithString:imageToLoad9] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
 } else if(imageToLoad10.length > 0) {
 [imgMapTap sd_setImageWithURL:[NSURL URLWithString:imageToLoad10] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
 } else {
 if (self.issearch==NO) {
 [imgMapTap sd_setImageWithURL:[NSURL URLWithString:kAppDelegate.strSubCategory] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
 }else {
 kAppDelegate.strSubCategory = @"";
 FMDBManager *fm = [[FMDBManager alloc] init];
 [fm openDataBase];
 NSArray * arr = [fm SubCategryarry:BussnessDic[@"category_id"]];
 if(arr.count > 0){
 NSDictionary * dict = arr[0];
 kAppDelegate.strSubCategory = dict[@"sub_category_image"];
 NSLog(@"kAppDelegate.strSubCategory = %@", kAppDelegate.strSubCategory);
 [imgMapTap sd_setImageWithURL:[NSURL URLWithString:kAppDelegate.strSubCategory] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
 }
 }
 }
 
 [viewMapTap addSubview:imgMapTap];
 
 NSString *srtLbl=[classUnicode StringToConvert:[[serchListArr objectAtIndex:i] valueForKey:@"business_name"]];
 lblMapTap=[[UILabel alloc]initWithFrame:CGRectMake(0.0, 70.0, 90.0, 30.0)];
 lblMapTap.text=srtLbl;
 lblMapTap.numberOfLines=2;
 lblMapTap.textAlignment=NSTextAlignmentCenter;
 [lblMapTap setFont:[UIFont systemFontOfSize:9.0]];
 [viewMapTap addSubview:lblMapTap];
 
 btnMapTap = [UIButton buttonWithType:UIButtonTypeSystem];
 btnMapTap.frame = CGRectMake(0.0, 0.0, 90.0, 100.0);
 btnMapTap.tag=i;
 [viewMapTap addSubview:btnMapTap];
 
 btnMapTap.userInteractionEnabled = YES;
 UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
 [view addGestureRecognizer:singleFingerTap];
 
 break;
 }
 }
 
 
 
 }
 
 
 //The event handling method
 - (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
 {
 @try {
 BussnessDic = [serchListArr objectAtIndex:[btnMapTap tag]];
 NSMutableDictionary * dictBD = [[NSMutableDictionary alloc] init];
 dictBD = [BussnessDic mutableCopy];
 [dictBD setObject:kAppDelegate.strSubCategory forKey:@"subcategory_image"];
 
 self.isserchsetview=true;
 FMDBManager *fm = [[FMDBManager alloc] init];
 [fm openDataBase];
 [fm saveTude:[dictBD mutableCopy]];
 [self performSegueWithIdentifier:@"Details" sender:self];
 }
 @catch (NSException *exception) {
 NSLog(@"exception.....%@",exception);
 }
 }
 */








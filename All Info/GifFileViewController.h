//
//  GifFileViewController.h
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
#import "MNMBottomPullToRefreshView.h"
#import "MNMBottomPullToRefreshManager.h"
#import "MBProgressHUD.h"
#import "IntrestCatViewController.h"

@interface GifFileViewController : UIViewController<CLLocationManagerDelegate,MNMBottomPullToRefreshManagerClient,MBProgressHUDDelegate>

{
@private
    MNMBottomPullToRefreshManager *pullToRefreshManager_;
    NSUInteger reloads_;
    MBProgressHUD *HUD;
}
- (IBAction)btn_Share:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *PlayImgView;
@property bool isserchsetview;
- (IBAction)ActionOnHome:(id)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *Activity;
@property NSString *serchByName;
@property (retain, nonatomic) NSURLConnection *connection;
@property (retain, nonatomic) NSMutableData *receivedData;

@property (retain, nonatomic) NSURLConnection *connectionnew;
@property (retain, nonatomic) NSMutableData *receivedDatanew;
- (IBAction)ActionOnmenu:(id)sender;
@property NSArray *serchnamearr;
@property BOOL issearch;
@property (weak, nonatomic) IBOutlet UITableView *LocationTableView;
@property (weak, nonatomic) IBOutlet UILabel *ShowTitalLabe;
@property NSDictionary *getSubcategryDic;
@property (weak, nonatomic) IBOutlet UIView *ShowAnimationview;
- (IBAction)BackBtn:(id)sender;



@end

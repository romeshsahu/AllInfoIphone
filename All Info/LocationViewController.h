//
//  LocationViewController.h
//  All Info
//
//  Created by P S 305 on 28/06/17.
//  Copyright © 2017 PS.com. All rights reserved.
//

#import <UIKit/UIKit.h>
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
#import "MNMBottomPullToRefreshView.h"
#import "MNMBottomPullToRefreshManager.h"
#import "MBProgressHUD.h"

@interface LocationViewController : UIViewController<MenuViewControllerDelegates,UITabBarControllerDelegate> {
@private
    MNMBottomPullToRefreshManager *pullToRefreshManager_;
    NSUInteger reloads_;
    MBProgressHUD *HUD;

    
    
    UIRefreshControl *refreshControl;
    NSInteger pageNo;
    UIView *footerView;
    UIActivityIndicatorView * actInd;
    CGPoint lastContentOffset;
    NSString*Userlat, *Userlong, * strSelectedLat, *  strSelectedLong;
    CLLocationManager *locationManager;
    NSDictionary * dictLD;
    
}
@property (strong, nonatomic) IBOutlet UITableView *tblView_Location;
- (IBAction)btn_Done:(id)sender;

@property (strong, nonatomic) NSMutableArray * arrLocation;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *Activity;

@property (retain, nonatomic) NSURLConnection *connection;
@property (retain, nonatomic) NSMutableData *receivedData;

@property (retain, nonatomic) NSURLConnection *connectionnew;
@property (retain, nonatomic) NSMutableData *receivedDatanew;

- (IBAction)btn_Back:(id)sender;
- (IBAction)btn_Home:(id)sender;

@end

//
//  GifFileViewController.m
//  All Info
//
//  Created by Mahendra Suryavanshi on 3/5/16.
//  Copyright © 2016 PS.com. All rights reserved.
//
#import "LocationViewController.h"
#import "GifFileViewController.h"
#import "UIImage+animatedGIF.h"
#import <AudioToolbox/AudioToolbox.h>
#import "LocationTableViewCell.h"
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
#import "MapListViewController.h"

@interface GifFileViewController ()<MenuViewControllerDelegates,UITabBarControllerDelegate>
{

    NSString*Userlat;
    NSMutableDictionary *BussnessDic;
    NSString*Userlong;
    CLLocationManager *locationManager;
    NSMutableArray *serchListArr;
    UINavigationController *nav;
    MenuViewController * sample;
    Allinfo *HistoryInfo;
    UIRefreshControl *refreshControl;
    NSInteger pageNo;
    UIView *footerView;
     UIActivityIndicatorView * actInd;
    CGPoint lastContentOffset;
}

@end

@implementation GifFileViewController
bool isShowngif = false;

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
//bookmarkArray = [[NSMutableArray alloc] init];
    [pullToRefreshManager_ relocatePullToRefreshView];
}
- (void)viewWillAppear:(BOOL)animated {
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    serchListArr = [[NSMutableArray alloc] init];
    pageNo = 1;
    [super viewWillAppear:animated];
    HistoryInfo=[[Allinfo alloc]init];
    [sample.view removeFromSuperview];
    [self.LocationTableView reloadData];
    self.tabBarController.tabBar.hidden=NO;
    if (self.issearch==YES) {
        [self performSelector:@selector(serchByprodect) withObject:nil afterDelay:1.0f];
    }else{
        [self performSelector:@selector(GetprodectList) withObject:nil afterDelay:1.0f];
    }
}

- (void) tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    NSLog(@"working");
}
    
- (void)viewDidLoad {
    [super viewDidLoad];
   
    serchListArr = [[NSMutableArray alloc]init];
    
    
    if (self.issearch==YES) {
        serchListArr=[[NSMutableArray alloc]init];
        //self.ShowTitalLabe.text=[self.getSubcategryDic objectForKey:@"sub_category_name"];
        //self.ShowTitalLabe.textAlignment=NSTextAlignmentCenter;
        [self.LocationTableView setSeparatorInset:UIEdgeInsetsZero];
        self.LocationTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        pageNo = 1;
        reloads_=-1;
        
        pullToRefreshManager_ = [[MNMBottomPullToRefreshManager alloc]initWithPullToRefreshViewHeight:60.0f tableView:self.LocationTableView withClient:self];
        [self initFooterView];
        
    }else{
        serchListArr=[[NSMutableArray alloc]init];
        self.ShowTitalLabe.text=[self.getSubcategryDic objectForKey:@"sub_category_name"];
        self.ShowTitalLabe.textAlignment=NSTextAlignmentCenter;
        [self.LocationTableView setSeparatorInset:UIEdgeInsetsZero];
        self.LocationTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        pageNo = 1;
        reloads_=-1;
        
        pullToRefreshManager_ = [[MNMBottomPullToRefreshManager alloc]initWithPullToRefreshViewHeight:60.0f tableView:self.LocationTableView withClient:self];
        [self initFooterView];
    }
}

- (void)reloadData
{
    // Reload table data
    self.LocationTableView.tableFooterView = nil;
     [(UIActivityIndicatorView *)[footerView viewWithTag:10] stopAnimating];
    [self.LocationTableView reloadData];
    //[pullToRefreshManager_ tableViewReleased];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Pulled"];
}
#pragma mark MNMBottomPullToRefreshManagerClient

/**
 * This is the same delegate method as UIScrollView but required in MNMBottomPullToRefreshManagerClient protocol
 * to warn about its implementation. Here you have to call [MNMBottomPullToRefreshManager tableViewScrolled]
 *
 * Tells the delegate when the user scrolls the content view within the receiver.
 *
 * @param scrollView: The scroll-view object in which the scrolling occurred.
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGPoint currentOffset = scrollView.contentOffset;
    if (currentOffset.y > lastContentOffset.y)
    {
        // Downward
        [pullToRefreshManager_ tableViewScrolled];

    }
    
    lastContentOffset = currentOffset;
    
    
}

/**
 * This is the same delegate method as UIScrollView but required in MNMBottomPullToRefreshClient protocol
 * to warn about its implementation. Here you have to call [MNMBottomPullToRefreshManager tableViewReleased]
 *
 * Tells the delegate when dragging ended in the scroll view.
 *
 * @param scrollView: The scroll-view object that finished scrolling the content view.
 * @param decelerate: YES if the scrolling movement will continue, but decelerate, after a touch-up gesture during a dragging operation.
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [pullToRefreshManager_ tableViewReleased];
    //
    //    BOOL endOfTable = (scrollView.contentOffset.y >= ((self.contentArray.count * 40) - scrollView.frame.size.height)); // Here 40 is row height
    //
    //    if (self.hasMoreData && endOfTable && !self.isLoading && !scrollView.dragging && !scrollView.decelerating)
    //    {
    
    //    }
    
}


/**
 * Tells client that refresh has been triggered
 * After reloading is completed must call [MNMBottomPullToRefreshManager tableViewReloadFinished]
 *
 * @param manager PTR manager
 */
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


- (void)bottomPullToRefreshTriggered:(MNMBottomPullToRefreshManager *)manager {
    self.LocationTableView.tableFooterView = footerView;
    
    [(UIActivityIndicatorView *)[footerView viewWithTag:10] startAnimating];
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"Pulled"];
    [self performSelector:@selector(loadTable) withObject:nil afterDelay:1.0f];
    if (self.issearch==YES) {
        
          [self performSelector:@selector(serchByprodect) withObject:nil afterDelay:1.0f];
    }else{
         [self performSelector:@selector(GetprodectList) withObject:nil afterDelay:1.0f];
        
    }
  
    
    //[refreshControl addTarget:self action:@selector(callUserWs) forControlEvents:UIControlEventValueChanged];
    // [UserprofileTableView addSubview:refreshControl];
    
}

- (void)loadTable {
    
    reloads_++;
    
    [self.LocationTableView reloadData];
    
    [pullToRefreshManager_ tableViewReloadFinished];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:NSLocalizedString( @"Error",nil) message:NSLocalizedString(@"Failed to Get Your Location",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
  //  [errorAlert show];
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
                 //  [self GetprodectList];
                }
                
            }
            NSString * Userlong1
            = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
            [[NSUserDefaults standardUserDefaults] setObject:Userlong1 forKey:@"Userlong"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            NSString *Userlat2= [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
            [[NSUserDefaults standardUserDefaults] setObject:Userlat2 forKey:@"Userlat"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
           // NSLog(@"currentLocation.coordinate.longitude = %f, currentLocation.coordinate.latitude = %f", currentLocation.coordinate.longitude, currentLocation.coordinate.latitude);
            
            Userlong= [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"Userlong"];
            Userlat = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"Userlat"];
        }
       
    }
}

#pragma mark - UITableView Delegates

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LocationTableViewCell *cell = (LocationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"MapLocaton"];
    if(serchListArr.count > 0) {
    BussnessDic = [serchListArr objectAtIndex:indexPath.row];
        
    //SelectedLanguage
    NSString *leg=[[NSUserDefaults standardUserDefaults]objectForKey:@"SelectedLanguage"];
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
    
    
   // NSLog(@"imageToLoad = %@", imageToLoad);
   // NSLog(@"kAppDelegate.strSubCategory = %@", kAppDelegate.strSubCategory);
    if(imageToLoad.length > 0) {
        [cell.PrdoctImgView sd_setImageWithURL:[NSURL URLWithString:imageToLoad] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
    } else if(imageToLoad2.length > 0) {
        [cell.PrdoctImgView sd_setImageWithURL:[NSURL URLWithString:imageToLoad2] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
    } else if(imageToLoad3.length > 0) {
        [cell.PrdoctImgView sd_setImageWithURL:[NSURL URLWithString:imageToLoad3] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
    } else if(imageToLoad4.length > 0) {
        [cell.PrdoctImgView sd_setImageWithURL:[NSURL URLWithString:imageToLoad4] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
    } else if(imageToLoad5.length > 0) {
        [cell.PrdoctImgView sd_setImageWithURL:[NSURL URLWithString:imageToLoad5] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
    } else if(imageToLoad6.length > 0) {
        [cell.PrdoctImgView sd_setImageWithURL:[NSURL URLWithString:imageToLoad6] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
    } else if(imageToLoad7.length > 0) {
        [cell.PrdoctImgView sd_setImageWithURL:[NSURL URLWithString:imageToLoad7] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
    } else if(imageToLoad8.length > 0) {
        [cell.PrdoctImgView sd_setImageWithURL:[NSURL URLWithString:imageToLoad8] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
    } else if(imageToLoad9.length > 0) {
        [cell.PrdoctImgView sd_setImageWithURL:[NSURL URLWithString:imageToLoad9] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
    } else if(imageToLoad10.length > 0) {
        [cell.PrdoctImgView sd_setImageWithURL:[NSURL URLWithString:imageToLoad10] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
    } else {
        if (self.issearch==NO) {
            [cell.PrdoctImgView sd_setImageWithURL:[NSURL URLWithString:kAppDelegate.strSubCategory] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
        }else {
            kAppDelegate.strSubCategory = @"";
            FMDBManager *fm = [[FMDBManager alloc] init];
            [fm openDataBase];
            NSArray * arr = [fm SubCategryarry:BussnessDic[@"category_id"]];
            if(arr.count > 0){
                NSDictionary * dict = arr[0];
                kAppDelegate.strSubCategory = dict[@"sub_category_image"];
          //      NSLog(@"kAppDelegate.strSubCategory = %@", kAppDelegate.strSubCategory);
                [cell.PrdoctImgView sd_setImageWithURL:[NSURL URLWithString:kAppDelegate.strSubCategory] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
            }
        }
    }
    
    NSString *distanceString = [[NSString alloc] initWithFormat: @"%@", [BussnessDic objectForKey:@"distance"]];
    float your_float = [distanceString floatValue];
        //  NSLog(@"float value is: %.1f", your_float);
    NSString *fString = [NSString stringWithFormat:@"%.1f", your_float];
    
    cell.AfterLocationLab.text=[NSString stringWithFormat:@"%@ km",fString];
    NSString *strUnicodeString = [BussnessDic objectForKey:@"business_name"];
    
    if ([strUnicodeString isEqual:[NSNull null]]) {
        strUnicodeString=@"";
    }else if ([strUnicodeString isEqual:@""]) {
        strUnicodeString=@"";
    }else if(strUnicodeString == nil){
        strUnicodeString=@"";
    }else{
    if ([strUnicodeString canBeConvertedToEncoding:NSASCIIStringEncoding]){
        NSData *data = [strUnicodeString dataUsingEncoding:NSUTF8StringEncoding];
        NSString *string = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding];
         cell.Prodectlabel.text=[NSString stringWithFormat:@"%@",string];

     }else{
     cell.Prodectlabel.text=[NSString stringWithFormat:@"%@",strUnicodeString];
     }
    }
   // cell.Prodectlabel.text=[NSString stringWithFormat:@"%@",strUnicodeString];
   // NSLog(@"Your name is %@", strUnicodeString);
    
    cell.Prodectlabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.Prodectlabel.numberOfLines = 0;
    cell.Prodectlabel.font = [UIFont fontWithName:@"Helvetica" size:20.0];
    cell.AfterLocationLab.lineBreakMode = NSLineBreakByWordWrapping;
    cell.AfterLocationLab.numberOfLines = 0;
    cell.AfterLocationLab.font = [UIFont fontWithName:@"Helvetica" size:18.0];

        /// Manage Rating view
    
    float  intRating = [BussnessDic[@"rating"] floatValue];
    cell.lbl_Status.text = BussnessDic[@"status"];
    
        if([BussnessDic[@"parking_avail"] intValue] == 1){
            [cell.imgView_Parking setHidden:NO];
        } else {
            [cell.imgView_Parking setHidden:YES];
        }
        //   NSLog(@"People = %d", [BussnessDic[@"public_access"] intValue]);
        if([BussnessDic[@"public_access"] intValue] == 1){
            [cell.imgView_People setHidden:NO];
        } else {
            [cell.imgView_People setHidden:YES];
        }
        
        if(BussnessDic[@"is_open"] != nil) {
            if([BussnessDic[@"is_open"] intValue] == 2){
                //closed
                cell.lbl_Status.text = NSLocalizedString(@"Close",nil);
            } else {
                cell.lbl_Status.text = @"";
            }
        } else {
            cell.lbl_Status.text = @"";
        }
    
    // NSLog(@"Parking = %d", [BussnessDic[@"parking_avail"] intValue]);
    [self setCellAndRatingImage:intRating andCell:cell];
    }
    
    return  cell;
}

- (void) setCellAndRatingImage:(float) intRating andCell:(LocationTableViewCell *) cell {
    
   // NSLog(@"intRating = %2.f", intRating);
    
    cell.Starimg1.image = [UIImage imageNamed:@"star_blank.png"];
    cell.Starimg2.image = [UIImage imageNamed:@"star_blank.png"];
    cell.Starimg3.image = [UIImage imageNamed:@"star_blank.png"];
    cell.Starimg4.image = [UIImage imageNamed:@"star_blank.png"];
    cell.Starimg5.image = [UIImage imageNamed:@"star_blank.png"];
    
    if(intRating == 0.0) {
    
    } else if(intRating ==  0.5) {
        cell.Starimg1.image = [UIImage imageNamed:@"star_half.png"];
      
    } else if(intRating ==  1.0) {
        cell.Starimg1.image = [UIImage imageNamed:@"star_fill.png"];
      
    } else if(intRating ==  1.5) {
        cell.Starimg1.image = [UIImage imageNamed:@"star_fill.png"];
        cell.Starimg2.image = [UIImage imageNamed:@"star_half.png"];
      
    }  else if(intRating ==  2.0) {
        cell.Starimg1.image = [UIImage imageNamed:@"star_fill.png"];
        cell.Starimg2.image = [UIImage imageNamed:@"star_fill.png"];
      
    } else if(intRating ==  2.5) {
        cell.Starimg1.image = [UIImage imageNamed:@"star_fill.png"];
        cell.Starimg2.image = [UIImage imageNamed:@"star_fill.png"];
        cell.Starimg3.image = [UIImage imageNamed:@"star_half.png"];
        
    } else if(intRating ==  3.0) {
        cell.Starimg1.image = [UIImage imageNamed:@"star_fill.png"];
        cell.Starimg2.image = [UIImage imageNamed:@"star_fill.png"];
        cell.Starimg3.image = [UIImage imageNamed:@"star_fill.png"];
        
    } else if(intRating ==  3.5) {
        cell.Starimg1.image = [UIImage imageNamed:@"star_fill.png"];
        cell.Starimg2.image = [UIImage imageNamed:@"star_fill.png"];
        cell.Starimg3.image = [UIImage imageNamed:@"star_fill.png"];
        cell.Starimg4.image = [UIImage imageNamed:@"star_half.png"];
        
    } else if(intRating ==  4.0) {
        cell.Starimg1.image = [UIImage imageNamed:@"star_fill.png"];
        cell.Starimg2.image = [UIImage imageNamed:@"star_fill.png"];
        cell.Starimg3.image = [UIImage imageNamed:@"star_fill.png"];
        cell.Starimg4.image = [UIImage imageNamed:@"star_fill.png"];
        
    } else if(intRating ==  4.5) {
        cell.Starimg1.image = [UIImage imageNamed:@"star_fill.png"];
        cell.Starimg2.image = [UIImage imageNamed:@"star_fill.png"];
        cell.Starimg3.image = [UIImage imageNamed:@"star_fill.png"];
        cell.Starimg4.image = [UIImage imageNamed:@"star_fill.png"];
        cell.Starimg5.image = [UIImage imageNamed:@"star_half.png"];
        
    } else if(intRating ==  5.0) {
        cell.Starimg1.image = [UIImage imageNamed:@"star_fill.png"];
        cell.Starimg2.image = [UIImage imageNamed:@"star_fill.png"];
        cell.Starimg3.image = [UIImage imageNamed:@"star_fill.png"];
        cell.Starimg4.image = [UIImage imageNamed:@"star_fill.png"];
        cell.Starimg5.image = [UIImage imageNamed:@"star_fill.png"];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BussnessDic = [serchListArr objectAtIndex:indexPath.row];
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


- (IBAction)ActionOnMapView:(id)sender {
    locationManager.delegate = nil;
   // [self performSegueWithIdentifier:@"MapViewList" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"MapViewList"])
    {
        MapListViewController *MapView = segue.destinationViewController;
       // MapView.delegates = self;
       // MapView.isaddnew=YES;
        
        MapView.getSubcategryDic=_getSubcategryDic;
        MapView.isserchsetview=true;
        MapView.strSCName = _ShowTitalLabe.text;
        MapView.intLimit = ((int)pageNo - 1) * 10;
        NSLog(@"(int)pageNo * 10 = %d", ((int)pageNo - 1) * 10);
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return serchListArr.count;
}
-(void)serchByprodect{
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    if([defaults objectForKey:@"SelectedLatitude"] != nil) {
        Userlat = [defaults objectForKey:@"SelectedLatitude"];
    }
    if([defaults objectForKey:@"SelectedLongitude"] != nil) {
        Userlong = [defaults objectForKey:@"SelectedLongitude"];
    }
    
    
    [self.connectionnew cancel];
    
    //initialize new mutable data
    NSMutableData *data = [[NSMutableData alloc] init];
    self.receivedDatanew = data;
    //[data release];
    HUD.delegate = self;
    HUD.labelText = @"Loading";
    [HUD show:NO];  
    NSString *urlStr=[NSString stringWithFormat:@"http://allinfo.co.il/all_info/webservice/master.php?action=search&string=%@&latitude=%@&longitude=%@&page_no=%@&limit=%@",self.serchByName ,Userlat,Userlong,[NSString stringWithFormat:@"%li",(long)pageNo],@"10"];
    NSLog(@"urlStr = %@", urlStr);
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
    //initialize url that is going to be fetched.
    //NSString *urlStr=[NSString stringWithFormat:@"http://allinfo.co.il/all_info/webservice/master.php?action=searchBusiness&sub_cat_id=%@&language_id=%@&latitude=%@&longitude=%@&page_no=%@&limit=%@",[self.getSubcategryDic objectForKey:@"sub_cat_id"] ,@"2",lat,latonh,@"1",[NSString stringWithFormat:@"%li",(long)pageNo]];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    if([defaults objectForKey:@"SelectedLatitude"] != nil) {
        Userlat = [defaults objectForKey:@"SelectedLatitude"];
    }
    if([defaults objectForKey:@"SelectedLongitude"] != nil) {
        Userlong = [defaults objectForKey:@"SelectedLongitude"];
    }
    
        // dynamic
          NSString *urlStr=[NSString stringWithFormat:@"http://allinfo.co.il/all_info/webservice/master.php?action=searchBusiness&sub_cat_id=%@&language_id=%@&latitude=%@&longitude=%@&page_no=%@&limit=%@",[self.getSubcategryDic objectForKey:@"sub_cat_id"] ,@"2",Userlat,Userlong,[NSString stringWithFormat:@"%li",(long)pageNo],@"10"];

        //Static
        // NSString *urlStr=[NSString stringWithFormat:@"http://allinfo.co.il/all_info/webservice/master.php?action=searchBusiness&sub_cat_id=%@&language_id=%@&latitude=%@&longitude=%@&page_no=%@&limit=%@",[self.getSubcategryDic objectForKey:@"sub_cat_id"] ,@"2", @"31.789520", @"35.185456", [NSString stringWithFormat:@"%li",(long)pageNo],@"10"];
    
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
 NSLog(@"(int)pageNo * 10 = %d", (int)pageNo * 10);
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
                    pageNo++;
                    [self.LocationTableView reloadData];

            }
                NSLog(@"serchListArr = %d", (int)serchListArr.count);
                
                 [self reloadData];
            
        }else {
            
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"No data found",nil) message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alert show];
             [self reloadData];
        }
    }
    }
 }else if (connection==self.connectionnew){
     
     if (self.receivedDatanew != nil) {
        NSDictionary *responseDic =[NSJSONSerialization JSONObjectWithData:self.receivedDatanew options:kNilOptions error:nil];
        if ([responseDic isKindOfClass:[NSDictionary class]]) {
            if ([[responseDic objectForKey:@"message"]isEqualToString:@"success"]) {
                if (![[responseDic objectForKey:@"result"] isKindOfClass:[NSNull class]]) {
                    
                    NSArray *responseArr = [responseDic objectForKey:@"result"];
                    
                    for (NSDictionary *dic in responseArr) {
                        [serchListArr addObject:dic];
                    }
                    pageNo++;
                    [self.LocationTableView reloadData];
                    
                }
                [self reloadData];
                
            }else {
                
                //            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"No data found",nil) message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                //            [alert show];
                [self reloadData];
                
            }
        }
     }
    }

    
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
     [HUD hide:YES];
    [self.Activity stopAnimating];
   
    if (connection==self.connection) {
        [self.receivedData appendData:data];
    }else if (connection==self.connectionnew) {
        [self.receivedDatanew appendData:data];
    }
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [HUD hide:YES];
    [self.Activity stopAnimating];
    NSLog(@"%@" , error);
    [self reloadData];
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
    if (!isShowngif) {
        
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
        
        isShowngif = true;
        
    } else {
        
        
        CATransition *transition = [CATransition animation];
        transition.duration =0.5;
        transition.type = kCATransitionReveal;
        transition.subtype = kCATransitionFromRight;
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [sample.view.layer addAnimation:transition forKey:nil];
        [sample.view performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.5];
        
        isShowngif = false;
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
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Are you sure you want to logout?",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK"  ,nil) otherButtonTitles:NSLocalizedString( @"Cancel" ,nil), nil];
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
    
    
    isShowngif = false;
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
@end

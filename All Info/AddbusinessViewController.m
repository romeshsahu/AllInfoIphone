//
//  AddbusinessViewController.m
//  All Info
//
//  Created by iPhones on 5/4/16.
//  Copyright © 2016 PS.com. All rights reserved.
//

#import "AddbusinessViewController.h"
#import "BussinesTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "WSOperationInEDUApp.h"
#import "AppDelegate.h"
#import "NewAddBusinessViewController.h"
#import "FMDBManager.h"
@interface AddbusinessViewController ()<NewAddBusinessViewControllerDelegates>
{
    NSMutableArray *addbusinessarr;
    NSDictionary *BussnessDic;
    NSDictionary *UserDict;
    BOOL isedit;
    UIRefreshControl *refreshControl;
    NSInteger pageNo;
    UIView *footerView;
    UIActivityIndicatorView * actInd;
    CGPoint lastContentOffset;

}

@end

@implementation AddbusinessViewController
- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
      [pullToRefreshManager_ relocatePullToRefreshView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=NO;
    UserDict =[[NSUserDefaults standardUserDefaults] objectForKey:@"userdata"];
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"upda"]isEqualToString:@"Yes"])
    {
        pageNo = 1;
       [self addbusinelist];
    }
}
-(void)callweb{
       // [self addbusinelist];

}
- (void)viewDidLoad {
    [super viewDidLoad];
     isedit=NO;
    self.MyHaedingLabel.text=NSLocalizedString(@"My Business",nil);
    
    self.tabBarController.tabBar.hidden=NO;
    addbusinessarr=[[NSMutableArray alloc]init];
    UserDict =[[NSUserDefaults standardUserDefaults] objectForKey:@"userdata"];
    pageNo = 1;
    reloads_=-1;
    
    pullToRefreshManager_ = [[MNMBottomPullToRefreshManager alloc]initWithPullToRefreshViewHeight:60.0f tableView:self.addbusinestableview withClient:self];
    [self initFooterView];
    [self addbusinelist];
    // Do any additional setup after loading the view.
}
- (void)reloadData
{
    // Reload table data
    self.addbusinestableview.tableFooterView = nil;
    [(UIActivityIndicatorView *)[footerView viewWithTag:10] stopAnimating];
    [self.addbusinestableview reloadData];
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
    self.addbusinestableview.tableFooterView = footerView;
    
    [(UIActivityIndicatorView *)[footerView viewWithTag:10] startAnimating];
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"Pulled"];
    [self performSelector:@selector(loadTable) withObject:nil afterDelay:1.0f];
    
    [self performSelector:@selector(addbusinelist) withObject:nil afterDelay:1.0f];
    
    //[refreshControl addTarget:self action:@selector(callUserWs) forControlEvents:UIControlEventValueChanged];
    // [UserprofileTableView addSubview:refreshControl];
    
}

- (void)loadTable {
    
    
    reloads_++;
    
    [self.addbusinestableview reloadData];
    
    [pullToRefreshManager_ tableViewReloadFinished];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addbusinelist{
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"upda"]isEqualToString:@"Yes"]) {
        NSString *pageNo1 = @"1";
        
        WSOperationInEDUApp *ws=[[WSOperationInEDUApp alloc]initWithDelegate:self callback:@selector(blist:)];
        [ws addbusinessList:[UserDict objectForKey:@"login_id"] language_id:@"2" page_no:pageNo1 limit:@"10"];
        
    }else{
        WSOperationInEDUApp *ws=[[WSOperationInEDUApp alloc]initWithDelegate:self callback:@selector(blist:)];
        [ws addbusinessList:[UserDict objectForKey:@"login_id"] language_id:@"2" page_no:[NSString stringWithFormat:@"%li",(long)pageNo] limit:@"10"];
    }
}
-(void)blist:(id)response
{
    
    @try {
        NSDictionary *responseDic=response;
        if ([response isKindOfClass:[NSDictionary class]]) {
            if ([[responseDic objectForKey:@"message"]isEqualToString:@"success"]) {
                if (![[responseDic objectForKey:@"result"] isKindOfClass:[NSNull class]]) {
                    
                    NSArray *responseArr = [responseDic objectForKey:@"result"];
                    
                    for (NSDictionary *dic in responseArr) {
                        
                        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"upda"]isEqualToString:@"Yes"]) {
                            addbusinessarr=[[NSMutableArray alloc]init];
                            [addbusinessarr addObject:dic];
                            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"upda"];
                        }else{
                            [addbusinessarr addObject:dic];
                        }
                    }
                    pageNo++;
                    [self.addbusinestableview reloadData];
                    
                    
                }
                [self reloadData];
                
            }else {
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"upda"];
                //            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"No data found",nil) message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                //            [alert show];
                [self reloadData];
                
            }
        }

    } @catch (NSException *exception) {
        NSLog(@"exception....%@",exception);
    }
}

#pragma mark - UITableView Delegates

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    @try {
        
        BussinesTableViewCell *cell = (BussinesTableViewCell *)[self.addbusinestableview dequeueReusableCellWithIdentifier:@"businesscell"];
        
        if (addbusinessarr.count>0) {
            BussnessDic = [addbusinessarr objectAtIndex:indexPath.row];
            NSLog(@"bus dict = %@", BussnessDic);
            
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
            
            if(imageToLoad.length > 0) {
                [cell.addimageview sd_setImageWithURL:[NSURL URLWithString:imageToLoad] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
            } else if(imageToLoad2.length > 0) {
                [cell.addimageview sd_setImageWithURL:[NSURL URLWithString:imageToLoad2] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
            } else if(imageToLoad3.length > 0) {
                [cell.addimageview sd_setImageWithURL:[NSURL URLWithString:imageToLoad3] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
            } else if(imageToLoad4.length > 0) {
                [cell.addimageview sd_setImageWithURL:[NSURL URLWithString:imageToLoad4] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
            } else if(imageToLoad5.length > 0) {
                [cell.addimageview sd_setImageWithURL:[NSURL URLWithString:imageToLoad5] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
            } else if(imageToLoad6.length > 0) {
                [cell.addimageview sd_setImageWithURL:[NSURL URLWithString:imageToLoad6] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
            } else if(imageToLoad7.length > 0) {
                [cell.addimageview sd_setImageWithURL:[NSURL URLWithString:imageToLoad7] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
            } else if(imageToLoad8.length > 0) {
                [cell.addimageview sd_setImageWithURL:[NSURL URLWithString:imageToLoad8] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
            } else if(imageToLoad9.length > 0) {
                [cell.addimageview sd_setImageWithURL:[NSURL URLWithString:imageToLoad9] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
            } else if(imageToLoad10.length > 0) {
                [cell.addimageview sd_setImageWithURL:[NSURL URLWithString:imageToLoad10] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
            } else {
                
                FMDBManager *fm = [[FMDBManager alloc] init];
                [fm openDataBase];
                NSArray * arr = [fm SubCategryarry:BussnessDic[@"category_id"]];
                
                if (arr.count > 0) {
                    
                }
                
                NSDictionary * dict = arr[0];
                kAppDelegate.strSubCategory = dict[@"sub_category_image"];
                NSLog(@"kAppDelegate.strSubCategory = %@, b catid = %@", kAppDelegate.strSubCategory,   BussnessDic[@"category_id"]);
                [cell.addimageview sd_setImageWithURL:[NSURL URLWithString:kAppDelegate.strSubCategory] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
            }
            
            NSString* strUnicodeString=[NSString stringWithFormat:@"%@",[BussnessDic objectForKey:@"business_name"]];
            
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
                    cell.addnamelabel.text=[NSString stringWithFormat:@"%@",string];
                    
                }else{
                    cell.addnamelabel.text=[NSString stringWithFormat:@"%@",strUnicodeString];
                }
            }

        }
        
        
        
        return  cell;
        
        
    } @catch (NSException *exception) {
        NSLog(@"exception....%@",exception);
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BussnessDic = [addbusinessarr objectAtIndex:indexPath.row];
    isedit=YES;
    [self performSegueWithIdentifier:@"NewBusiness" sender:self];
//    FMDBManager *fm = [[FMDBManager alloc] init];
//    [fm openDataBase];
//    [fm saveTude:BussnessDic];
//    [self performSegueWithIdentifier:@"Details" sender:self];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 
    if (isedit==YES) {
        if ([segue.identifier isEqualToString:@"NewBusiness"]) {
            NewAddBusinessViewController *NewAdd = segue.destinationViewController;
            NewAdd.delegates = self;
            NewAdd.iseditNew =YES;
            NewAdd.editbusinesdic=BussnessDic;
        }
        
    }else{
    if ([segue.identifier isEqualToString:@"NewBusiness"]) {
        NewAddBusinessViewController *NewAdd = segue.destinationViewController;
        NewAdd.delegates = self;
        
        
    }
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return addbusinessarr.count;
}


- (IBAction)addbusinsAction:(id)sender {
      isedit=NO;
     [self performSegueWithIdentifier:@"NewBusiness" sender:self];
}

- (IBAction)actionOnbackBtn:(id)sender {
    //[self .navigationController popViewControllerAnimated:YES];
    
    
    UIStoryboard *MainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    UINavigationController *controller = (UINavigationController*)[MainStoryboard instantiateViewControllerWithIdentifier: @"RootNavigationController"];
    UITabBarController *tabar = controller.viewControllers[0];
    [tabar setSelectedIndex:3];
    
    [AppDelegate SharedInstance].window.rootViewController=controller;
    [[AppDelegate SharedInstance].window makeKeyAndVisible];
    

}

- (IBAction)ActioNoNhome:(id)sender {
    UIStoryboard *MainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    UINavigationController *controller = (UINavigationController*)[MainStoryboard instantiateViewControllerWithIdentifier: @"RootNavigationController"];
    UITabBarController *tabar = controller.viewControllers[0];
    [tabar setSelectedIndex:3];
    
    [AppDelegate SharedInstance].window.rootViewController=controller;
    [[AppDelegate SharedInstance].window makeKeyAndVisible];
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

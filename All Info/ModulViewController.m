//
//  ModulViewController.m
//  All Info
//
//  Created by iPhones on 4/23/16.
//  Copyright © 2016 Parkhya solutions. All rights reserved.
//

#import "ModulViewController.h"
#import "HomeCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "WSOperationInEDUApp.h"
#import "SubCategiryViewController.h"
#import "MenuViewController.h"
#import "RegistrationViewController.h"
#import "LoginViewController.h"
#import "GifFileViewController.h"
#import "AddbusinessViewController.h"
#import "HelpViewController.h"
#import "ContectUsViewController.h"

@interface ModulViewController ()<MenuViewControllerDelegates,CLLocationManagerDelegate,UITabBarControllerDelegate>
{
    NSMutableArray *categrtArray;
     NSMutableArray *SubcategrtArray;
    NSDictionary *categryDic;
    UINavigationController *nav;
    MenuViewController * sample;
    NSMutableArray *AllCatergryArr;
    NSString *catname;
    
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    NSString *post;
    NSString *userlat;
    NSString *userlong;
    NSString*la;
    NSString*lo;
}

@end
NSString *knewCellID = @"cellIDnew";
@implementation ModulViewController
bool isShownmodule = false;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.delegate = self;

    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization )]) {
        [locationManager requestWhenInUseAuthorization];
    }
    [locationManager startUpdatingLocation];

    [sample.view removeFromSuperview];
    self.tabBarController.tabBar.hidden=NO;
    categrtArray = [[NSMutableArray alloc]init];
    AllCatergryArr= [[NSMutableArray alloc]init];
    SubcategrtArray= [[NSMutableArray alloc]init];
    
    
        //  [self checkLastUpdate];
    [self GetcategoryList];
    [self GetSubcategoryList];
  
    la=userlat;
    lo=userlong;
   // [self GetBusinessList];
    
    // Do any additional setup after loading the view.
}

- (void) checkLastUpdate {
    WSOperationInEDUApp *ws=[[WSOperationInEDUApp alloc]initWithDelegate:self callback:@selector(getLastUpdateData:)];
    [ws getLastUpdate];
}

- (void) getLastUpdateData :(id)response {
    NSMutableDictionary *responseDic=response;
    NSLog(@"responseDic = %@", responseDic);
    if ([response isKindOfClass:[NSDictionary class]]) {
        if ([[responseDic objectForKey:@"message"]isEqualToString:@"success"]) {
            
            
                // kAppDelegate.strSubCategoryDate = responseDic[@"subcat_last_update"];
            
            NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
            
            if([defaults objectForKey:@"cat_last_update"] != nil && [defaults objectForKey:@"subcat_last_update"] != nil){
                
                if(![[defaults objectForKey:@"cat_last_update"] isEqualToString:responseDic[@"cat_last_update"]]) {
                    [defaults setObject:responseDic[@"cat_last_update"] forKey:@"cat_last_update"];
                    kAppDelegate.strCategoryDate = [defaults objectForKey:@"cat_last_update"];//responseDic[@"cat_last_update"];
                } else {
                    kAppDelegate.strCategoryDate = responseDic[@"cat_last_update"];
                }
                
                if(![[defaults objectForKey:@"subcat_last_update"] isEqualToString:responseDic[@"subcat_last_update"]]) {
                    [defaults setObject:responseDic[@"subcat_last_update"] forKey:@"subcat_last_update"];
                    kAppDelegate.strSubCategoryDate = [defaults objectForKey:@"subcat_last_update"];//responseDic[@"subcat_last_update"];
                } else {
                        kAppDelegate.strSubCategoryDate = responseDic[@"subcat_last_update"];
                }
            } else {
                    ///Means first time these are nil
                [defaults setObject:responseDic[@"cat_last_update"] forKey:@"cat_last_update"];
                [defaults setObject:responseDic[@"subcat_last_update"] forKey:@"subcat_last_update"];
                    //  kAppDelegate.strCategoryDate = responseDic[@"cat_last_update"];
                    // kAppDelegate.strSubCategoryDate = responseDic[@"subcat_last_update"];
            }
            
            [defaults synchronize];
            
            [self GetcategoryList];
            [self GetSubcategoryList];
            
        }
    }
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error"
                               message:@"Failed to Get Your Location"
                               delegate:nil
                               cancelButtonTitle:@"OK"
                               otherButtonTitles:nil];
    [errorAlert show];
}

-(CLLocationCoordinate2D) getLocation{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
    CLLocation *location = [locationManager location];
    CLLocationCoordinate2D coordinate = [location coordinate];
    
    return coordinate;
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    currentLocation = [locations objectAtIndex:0];
    [locationManager stopUpdatingLocation];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    CLLocationCoordinate2D coordinate = [self getLocation];
    userlat = [NSString stringWithFormat:@"%f", coordinate.latitude];
    userlong = [NSString stringWithFormat:@"%f", coordinate.longitude];
    [[NSUserDefaults standardUserDefaults] setObject:userlat forKey:@"userlat"];
    [[NSUserDefaults standardUserDefaults] setObject:userlong forKey:@"userlong"];
    //[self GetBusinessList];
}
- (void)viewWillAppear:(BOOL)animated {
        //  [self.view setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.HomeCollectionView setTransform:CGAffineTransformMakeScale(-1, 1)];
    
    
    [super viewWillAppear:animated];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"GoHome"];
    la=userlat;
    lo=userlong;
    [sample.view removeFromSuperview];
    self.tabBarController.tabBar.hidden=NO;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [self.searchFiled resignFirstResponder];
    return YES;
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
    
    
    isShownmodule = false;
}
-(void)GetcategoryList{
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"D cat date = %@, kAppDelegate.strCategoryDate = %@", [defaults objectForKey:@"cat_last_update"], kAppDelegate.strCategoryDate);
     if(![[defaults objectForKey:@"cat_last_update"] isEqualToString:kAppDelegate.strCategoryDate]) {
         WSOperationInEDUApp *ws=[[WSOperationInEDUApp alloc]initWithDelegate:self callback:@selector(Getcategory:)];
         [ws Get_category:@"2"];
    
     } else {
         
         
         
         
         FMDBManager *fm = [[FMDBManager alloc] init];
         [fm openDataBase];
         categrtArray = [fm Categryarry];
         
         
         NSSortDescriptor * descriptor = [NSSortDescriptor sortDescriptorWithKey:@"show_date" ascending:NO selector:@selector(localizedCaseInsensitiveCompare:)];
         NSArray * arrSorted = [NSArray arrayWithObject:descriptor];
         
         [categrtArray sortUsingDescriptors:arrSorted];
         
         
         [self.HomeCollectionView reloadData];
         
     }
}

-(void)GetSubcategoryList{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"D sub cat date = %@, strSubCategoryDate = %@", [defaults objectForKey:@"subcat_last_update"], kAppDelegate.strSubCategoryDate);
    if(![[defaults objectForKey:@"subcat_last_update"] isEqualToString:kAppDelegate.strSubCategoryDate]) {
    
    WSOperationInEDUApp *ws=[[WSOperationInEDUApp alloc]initWithDelegate:self callback:@selector(GetSubcategory:)];
    [ws get_subcategory:@"2"];
    } else {
        
    }
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"view did appear");
    //[self GetBusinessList];
}

-(void)GetBusinesList:(id)response
{
    NSDictionary *responseDic=response;
    if ([response isKindOfClass:[NSDictionary class]]) {
        if ([[responseDic objectForKey:@"message"]isEqualToString:@"success"]) {
            NSArray *BusinessArr=[responseDic objectForKey:@"result"];
            AllCatergryArr=[[NSMutableArray alloc]init];
            for (int i=0; i<BusinessArr.count; i++) {
                NSDictionary *BusinessDic=[BusinessArr objectAtIndex:i];
                Allinfo *BusinessArrInfo=[[Allinfo alloc]init];
                NSLog(@"Business Dict = %@", [BusinessDic objectForKey:@"category_id"]);
                BusinessArrInfo.category_id= [BusinessDic objectForKey:@"category_id"];
                BusinessArrInfo.category_image=[BusinessDic objectForKey:@"category_image"];
                BusinessArrInfo.category_name=[BusinessDic objectForKey:@"category_name"];
                BusinessArrInfo.language_id=[BusinessDic objectForKey:@"language_id"];
                FMDBManager *fm = [[FMDBManager alloc] init];
                [fm openDataBase];
                [fm saveallBusinss:BusinessDic];
                
            }

        }
    }
}
-(void)Getcategory:(id)response
{
    NSDictionary *responseDic=response;
    if ([response isKindOfClass:[NSDictionary class]]) {
        if ([[responseDic objectForKey:@"message"]isEqualToString:@"success"]) {
            //categrtArray=[responseDic objectForKey:@"result"];
            
            
           
            
           
            NSArray *CategrArr=[responseDic objectForKey:@"result"];
            AllCatergryArr=[[NSMutableArray alloc]init];
            for (int i=0; i<CategrArr.count; i++) {
                NSDictionary *CategrDic=[CategrArr objectAtIndex:i];
                    // NSLog(@"CategrDic = %@", CategrDic);
                Allinfo *CategrArrInfo=[[Allinfo alloc]init];
                    //NSLog(@"CategoryId = %@", [CategrDic objectForKey:@"category_id"]);
                CategrArrInfo.category_id=[CategrDic objectForKey:@"category_id"];
                CategrArrInfo.category_image=[CategrDic objectForKey:@"category_image"];
                CategrArrInfo.category_name=[CategrDic objectForKey:@"category_name"];
                CategrArrInfo.language_id=[CategrDic objectForKey:@"language_id"];
                CategrArrInfo.showDate=[CategrDic objectForKey:@"show_date"];
                FMDBManager *fm = [[FMDBManager alloc] init];
                [fm openDataBase];
                [fm saveallcatgery:CategrDic];
                
            }
            //if (CategrArr && CategrArr.count>0) {
        }
        FMDBManager *fm = [[FMDBManager alloc] init];
        [fm openDataBase];
        categrtArray = [fm Categryarry];
        
            ///Means here to manage date sorting
        NSLog(@"categrtArray = %d", (int)categrtArray.count);
        
        NSSortDescriptor * descriptor = [NSSortDescriptor sortDescriptorWithKey:@"show_date" ascending:NO selector:@selector(localizedCaseInsensitiveCompare:)];
        NSArray * arrSorted = [NSArray arrayWithObject:descriptor];
        
        [categrtArray sortUsingDescriptors:arrSorted];
        
            // [categrtArray removeAllObjects];
            //[categrtArray addObjectsFromArray:arrSorted];
        
        
        
        // }
        [self.HomeCollectionView reloadData];
    }
}
-(void)GetSubcategory:(id)response
{
    NSDictionary *responseDic=response;
    if ([response isKindOfClass:[NSDictionary class]]) {
        if ([[responseDic objectForKey:@"message"]isEqualToString:@"success"]) {
            NSArray *SubCategrArr=[responseDic objectForKey:@"result"];
            AllCatergryArr=[[NSMutableArray alloc]init];
            for (int i=0; i<SubCategrArr.count; i++) {
                NSDictionary *SubCategrDic=[SubCategrArr objectAtIndex:i];
                    //   NSLog(@"SubCategory dict = %@", SubCategrDic);
                Allinfo *CategrArrInfo=[[Allinfo alloc]init];
                    //NSLog(@"SubCategoryId = %@", [SubCategrDic objectForKey:@"category_id"]);
                CategrArrInfo.category_id=[SubCategrDic objectForKey:@"category_id"];
                CategrArrInfo.category_name=[SubCategrDic objectForKey:@"category_name"];
                CategrArrInfo.create_date=[SubCategrDic objectForKey:@"create_date"];
                CategrArrInfo.sub_cat_id=[SubCategrDic objectForKey:@"sub_cat_id"];
                CategrArrInfo.sub_category_image=[SubCategrDic objectForKey:@"sub_category_image"];
                CategrArrInfo.sub_category_name=[SubCategrDic objectForKey:@"sub_category_name"];
                CategrArrInfo.showDate=[SubCategrDic objectForKey:@"show_date"];
                FMDBManager *fm = [[FMDBManager alloc] init];
                [fm openDataBase];
                [fm saveallSubcatgery:SubCategrDic];
                
            }
        }
    }
}

#pragma mark collection view cell layout / size
- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            CGSize mElementSize = CGSizeMake(96, 92);
            return mElementSize;
        }
        if(result.height == 568)
        {
            CGSize mElementSize = CGSizeMake(96, 92);
            return mElementSize;
            
        }
        if(result.height == 667)
            
        {
            
            CGSize mElementSize = CGSizeMake(100, 105);
            return mElementSize;
        }
        
        
    }
    
    
    
    NSLog(@"SETTING SIZE FOR ITEM AT INDEX %d", indexPath.row);
    CGSize mElementSize = CGSizeMake(96, 92);
    return mElementSize; // will be w120xh100 or w190x100
    // if the width is higher, only one image will be shown in a line
}

#pragma mark collection view cell paddings
- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            return UIEdgeInsetsMake(10, 7, 10, 7);
        }
        if(result.height == 568)
        {
            return UIEdgeInsetsMake(10, 7, 10, 7);
            
        }
        if(result.height == 667)
            
        {
            
            return UIEdgeInsetsMake(0, 20, 0, 15);
        }
        
        
    }
    return UIEdgeInsetsMake(10, 7, 10, 7);
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 7.0;
}
#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return categrtArray.count;
}

-(NSInteger)numberOfSectionsInCollectionView:
(UICollectionView *)collectionView
{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:knewCellID forIndexPath:indexPath];
    [cell.contentView setTransform:CGAffineTransformMakeScale(-1, 1)];
    categryDic= [categrtArray objectAtIndex:indexPath.row];
    cell.Titallabel.text = [categryDic objectForKey:@"category_name"];
    //    [cell.HomeImageView.layer setBorderColor: [[UIColor blackColor] CGColor]];
    //    [cell.HomeImageView.layer setBorderWidth: 2.0];
    //    cell.HomeImageView.layer.cornerRadius = 10;
    NSString *imageToLoad = [categryDic objectForKey:@"category_image"];
    //[cell.HomeImageView sd_setImageWithURL:[NSURL URLWithString:imageToLoad] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
    [cell.HomeImageView sd_setImageWithURL:[NSURL URLWithString:imageToLoad] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // URL is as expected, but Image is wrong
    }];

    
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    
    categryDic=[categrtArray objectAtIndex:indexPath.row];
    
    NSLog(@"categryDic = %@", categryDic);
    
    FMDBManager *fm = [[FMDBManager alloc] init];
    [fm openDataBase];
    SubcategrtArray = [fm SubCategryarry:[categryDic objectForKey:@"category_id"]];
    catname=[categryDic objectForKey:@"category_name"];
    kAppDelegate.strCategory = [categryDic objectForKey:@"category_image"];
    kAppDelegate.strSubCategory = @"";
    [self performSegueWithIdentifier:@"subcatgery" sender:self];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"subcatgery"]) {
        SubCategiryViewController *subcatgry=segue.destinationViewController;
        subcatgry.getsubArr=SubcategrtArray;
        subcatgry.catgeryName=catname;
    }
//    }else if ([segue.identifier isEqualToString:@"search"]){
//        GifFileViewController *gif=segue.destinationViewController;
//        gif.serchname=self.searchFiled.text;
//        gif.issearch=YES;
//        [self.searchFiled resignFirstResponder];
//        self.searchFiled.text=@"";
//        //GifFileViewController
//    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ActionOnmenuBtn:(id)sender {
    if (!isShownmodule) {
        
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
        
        isShownmodule = true;
        
    } else {
        
        
        CATransition *transition = [CATransition animation];
        transition.duration =0.5;
        transition.type = kCATransitionReveal;
        
        transition.subtype = kCATransitionFromRight;
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [sample.view.layer addAnimation:transition forKey:nil];
        [sample.view performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.5];
        
        isShownmodule = false;
    }
    
    
}

- (IBAction)ActionOnRegistation:(id)sender {
    [self performSegueWithIdentifier:@"Registration" sender:self];
    
}

- (IBAction)ActionOncallView:(id)sender {
    [self performSegueWithIdentifier:@"CallDetails" sender:self];
    
    
    
    
    
}

- (IBAction)LoginBtn:(id)sender {
    [self performSegueWithIdentifier:@"Login" sender:self];
    /// [self performSegueWithIdentifier:@"Leavemssg" sender:self];
    
    
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
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:NSLocalizedString(@"Are you sure you want to logout?",nil) delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
            alert.tag=1;
            [alert show];
        }
            break;
        default:
            break;
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)ActionONBack:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Alert",nil) message:NSLocalizedString(@"Do you want to close the Allinfo",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:NSLocalizedString(@"Cancel",nil), nil];
    alert.tag=11;
    [alert show];
    
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==11) {
        if (buttonIndex == 0){
            
            exit(0);
            
        }
        
        
    }else if (alertView.tag==1) {
            if (buttonIndex == 0){
                
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"login"];
                
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"userdata"];
                
                
                //login
                
            }
            
            
        }
    
}


- (IBAction)actiononserch:(id)sender {
    if (self.searchFiled.text.length==0) {
        //        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter your User Name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //        [alert show];
    }else{
        [self.searchFiled resignFirstResponder];
        [self performSegueWithIdentifier:@"search" sender:self];
    }

}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    [[AppDelegate SharedInstance]getselectedTab:tabBarController.selectedIndex];
}
@end

//
//  ModulViewController.m
//  All Info
//
//  Created by iPhones on 4/23/16.
//  Copyright © 2016 Parkhya solutions. All rights reserved.
//

#import "IntrestCatViewController.h"
#import "IntrestedCatCVCell.h"
#import "UIImageView+WebCache.h"
#import "WSOperationInEDUApp.h"
#import "SubCategiryViewController.h"
#import "MenuViewController.h"
#import "RegistrationViewController.h"
#import "LoginViewController.h"
#import "GifFileViewController.h"
#import "ContectUsViewController.h"

@interface IntrestCatViewController ()<MenuViewControllerDelegates,CLLocationManagerDelegate>
{
    NSMutableArray *categrtArray;
    NSDictionary *categryDic;
    UINavigationController *nav;
    NSString *catname;
    
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    NSString *post;
    NSString *userlat;
    NSString *userlong;
    NSString*la;
    NSString*lo;
    
    NSDictionary *UserDict;

    NSString*strSelectedCat;
    NSMutableArray *arrSelectedCat;
    NSMutableArray *arrSelectedCat_Check;

}

@end
NSString *knewCellID1 = @"IntrestedCatCVCell";
@implementation IntrestCatViewController
bool isShownmodule1 = false;
- (void)viewDidLoad {
    [super viewDidLoad];
    UserDict =[[NSUserDefaults standardUserDefaults] objectForKey:@"userdata"];

    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization )]) {
        [locationManager requestWhenInUseAuthorization];
    }
    [locationManager startUpdatingLocation];
    
    categrtArray = [[NSMutableArray alloc]init];
    arrSelectedCat=[[NSMutableArray alloc]init];
    arrSelectedCat_Check=[[NSMutableArray alloc]init];

    [self getInterestedCategoryList];
    
    //[self GetcategoryList];
    self.tabBarController.tabBar.hidden = YES;

    la=userlat;
    lo=userlong;

}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:NSLocalizedString(@"Error" ,nil)
                               message:NSLocalizedString(@"Failed to Get Your Location" ,nil)
                               delegate:nil
                               cancelButtonTitle:NSLocalizedString(@"OK" ,nil)
                               otherButtonTitles:nil];
   // [errorAlert show];
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
}

- (void) getInterestedCategoryList {
    
    WSOperationInEDUApp *ws=[[WSOperationInEDUApp alloc]initWithDelegate:self callback:@selector(GetInterestedCategory:)];
    [ws getInterestedCategories:[UserDict objectForKey:@"login_id"]];
    
}
    
-(void)GetInterestedCategory:(id)response {
        NSDictionary *responseDic=response;
        if ([response isKindOfClass:[NSDictionary class]]) {
            NSLog(@"responseDic = %@", responseDic);
            if ([[responseDic objectForKey:@"message"]isEqualToString:@"success"]) {
                categrtArray = [[responseDic objectForKey:@"result"] mutableCopy];
                
                NSSortDescriptor * descriptor = [NSSortDescriptor sortDescriptorWithKey:@"show_date" ascending:NO selector:@selector(localizedCaseInsensitiveCompare:)];
                NSArray * arrSorted = [NSArray arrayWithObject:descriptor];
                
                [categrtArray sortUsingDescriptors:arrSorted];
                
                arrSelectedCat_Check = [[NSMutableArray alloc] init];
                arrSelectedCat = [[NSMutableArray alloc] init];
                
                for (int i=0; i<categrtArray.count; i++) {
                    if([categrtArray[i][@"interest"] isEqualToString:@"yes"]) {
                        [arrSelectedCat addObject:categrtArray[i][@"category_id"]];
                        [arrSelectedCat_Check addObject:@"check"];
                    } else {
                        [arrSelectedCat_Check addObject:@""];
                    }   
                }
               
                 [_HomeCollectionView reloadData];
                NSLog(@"arrSelectedCat = %@", arrSelectedCat);
                NSLog(@"arrSelectedCat_Check = %@", arrSelectedCat_Check);
            }
        }
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
        for (int i=0; i<categrtArray.count; i++) {
            [arrSelectedCat_Check addObject:@""];
        }
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"view did appear");
}

- (void)GetBusinesList:(id)response {
    
    NSDictionary *responseDic=response;
    if ([response isKindOfClass:[NSDictionary class]]) {
        if ([[responseDic objectForKey:@"message"]isEqualToString:@"success"]) {
            NSArray *BusinessArr=[responseDic objectForKey:@"result"];
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
                [arrSelectedCat_Check addObject:@""];
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
        [self.HomeCollectionView reloadData];
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
    
    NSLog(@"SETTING SIZE FOR ITEM AT INDEX %ld", (long)indexPath.row);
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
    
    IntrestedCatCVCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:knewCellID1 forIndexPath:indexPath];
    [cell.contentView setTransform:CGAffineTransformMakeScale(-1, 1)];
    categryDic= [categrtArray objectAtIndex:indexPath.row];
    cell.Titallabel.text = [categryDic objectForKey:@"category_name"];
    NSString *imageToLoad = [categryDic objectForKey:@"category_image"];
    [cell.HomeImageView sd_setImageWithURL:[NSURL URLWithString:imageToLoad] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    
    cell.imgCheck.image = [[UIImage alloc] init];
    if ([arrSelectedCat_Check[indexPath.row] isEqualToString:@"check"]) {
        cell.imgCheck.image = [UIImage imageNamed:@"checkBlueTick.png"];
    }
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectItemAtIndexPath....%ld",(long)indexPath.row);
    IntrestedCatCVCell *datasetCell = (IntrestedCatCVCell *)[collectionView cellForItemAtIndexPath:indexPath];
    datasetCell.imgCheck.image = [UIImage imageNamed:@"checkBlueTick.png"];

    categryDic=[categrtArray objectAtIndex:indexPath.row];
    NSString *str1=[categryDic objectForKey:@"category_id"];
 
    if (arrSelectedCat.count>0) {
        if ([arrSelectedCat containsObject:str1]) {
            for (int i=0; i<arrSelectedCat.count; i++) {
                if ([arrSelectedCat[i] isEqualToString:str1]) {
                    [arrSelectedCat removeObjectAtIndex:i];
                    [arrSelectedCat_Check replaceObjectAtIndex:indexPath.row withObject:@""];
                  //  datasetCell.imgCheck.image = [UIImage imageNamed:@""];
                }
            }
        }
        else {
            [arrSelectedCat addObject:str1];
            [arrSelectedCat_Check replaceObjectAtIndex:indexPath.row withObject:@"check"];
           // datasetCell.imgCheck.image = [UIImage imageNamed:@"checkBlueTick.png"];
        }

    }
    else
    {
        [arrSelectedCat addObject:str1];
        [arrSelectedCat_Check replaceObjectAtIndex:indexPath.row withObject:@"check"];
       // datasetCell.imgCheck.image = [UIImage imageNamed:@"checkBlueTick.png"];
    }
    [collectionView reloadData];

    NSLog(@"arrSelectedCat...%@",arrSelectedCat);
}

/*-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didDeselectItemAtIndexPath....%ld",(long)indexPath.row);
    IntrestedCatCVCell *datasetCell = (IntrestedCatCVCell *)[collectionView cellForItemAtIndexPath:indexPath];
    datasetCell.imgCheck.image = [UIImage imageNamed:@""];
    
    categryDic=[categrtArray objectAtIndex:indexPath.row];
    NSString *str1=[categryDic objectForKey:@"category_id"];
    
    if (arrSelectedCat.count>0) {
        for (int i=0; i<arrSelectedCat.count; i++) {
            if ([arrSelectedCat[i] isEqualToString:str1]) {
                [arrSelectedCat removeObjectAtIndex:i];
                [arrSelectedCat_Check replaceObjectAtIndex:indexPath.row withObject:@""];

            }
        }
    }
    [collectionView reloadData];
    NSLog(@"arrSelectedCat...%@",arrSelectedCat);
}*/

- (IBAction)btnDone:(id)sender {
    
    if (arrSelectedCat.count>0) {
        strSelectedCat = [arrSelectedCat componentsJoinedByString:@","];
        NSString *device_id =[[NSUserDefaults standardUserDefaults] objectForKey:@"DevieceId"];
        if (device_id == nil) {
            device_id = @"db1beb6c1f3f8286b6f94c9b6239b12c8fa6014004860f64606c3ac5681014b0";
        }
        WSOperationInEDUApp *ws=[[WSOperationInEDUApp alloc]initWithDelegate:self callback:@selector(intrest_category:)];
        [ws interest_category_login_id:[UserDict objectForKey:@"login_id"] category_id:strSelectedCat device_id:device_id device_type:@"1"];
    }
}
    
- (void)intrest_category:(id)response {
    NSDictionary *responseDic=response;
    if ([response isKindOfClass:[NSDictionary class]]) {
        NSLog(@"responseDic = %@", responseDic);
        if ([[responseDic objectForKey:@"message"]isEqualToString:@"success"]) {
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"" message:NSLocalizedString(@"submitted successfully",nil) preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* yesButton = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
            [alert addAction:yesButton];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ActionONBack:(id)sender {
   // [self dismissViewControllerAnimated:YES completion:nil];
   [self dismissViewControllerAnimated:YES completion:nil];
}

@end








//
//  FavouriteViewController.m
//  All Info
//
//  Created by iPhones on 4/23/16.
//  Copyright © 2016 Parkhya solutions. All rights reserved.
//
#import "LocationViewController.h"
#import "FavouriteViewController.h"
#import "FavirateCollectionViewCell.h"
#import "SubCategiryViewController.h"
#import "FMDBManager.h"
#import "UIImageView+WebCache.h"
#import "BusinessdetailsViewController.h"
#import "RegistrationViewController.h"
#import "LoginViewController.h"
#import "AddbusinessViewController.h"
#import "MenuViewController.h"
#import "AppDelegate.h"
#import "HelpViewController.h"
#import "ContectUsViewController.h"
@interface FavouriteViewController ()<MenuViewControllerDelegates,UITabBarControllerDelegate>
{
    NSMutableArray *favtatearr;
    NSMutableDictionary *favrateDic;
     MenuViewController * sample;
}

@end
NSString *kCid = @"favratecell";
@implementation FavouriteViewController
bool isShownfaver;

- (void)viewDidLoad {
    [super viewDidLoad];
    [sample.view removeFromSuperview];
     self.HedingFaveratealbel.text=NSLocalizedString(@"Favorite",nil);
    self.tabBarController.delegate = self;
    self.tabBarController.tabBar.hidden=NO;
    self.favitarateCollectionView.delegate = self;
    FMDBManager *fm = [[FMDBManager alloc] init];
    [fm openDataBase];
    favtatearr = [fm getfavirate];
//    if (favtatearr == nil || [favtatearr count] == 0) {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"No data found",nil) message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//    }
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [sample.view removeFromSuperview];
    self.tabBarController.tabBar.hidden=NO;
    FMDBManager *fm = [[FMDBManager alloc] init];
    [fm openDataBase];
    favtatearr = [fm getfavirate];
    NSLog(@"favtatearr = %d", (int)favtatearr.count);
    [self.favitarateCollectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return favtatearr.count;
}

-(NSInteger)numberOfSectionsInCollectionView:
(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FavirateCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:kCid forIndexPath:indexPath];
    
    favrateDic= [favtatearr objectAtIndex:indexPath.row];
    
    NSLog(@"favrateDic = %@", favrateDic);
    NSString* strUnicodeString=[favrateDic objectForKey:@"business_name"];
    if ([strUnicodeString canBeConvertedToEncoding:NSASCIIStringEncoding]){
        NSData *data = [strUnicodeString dataUsingEncoding:NSUTF8StringEncoding];
        NSString *string = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding];
        cell.lbl_Title.text=[NSString stringWithFormat:@"%@",string];
        
    }else{
        cell.lbl_Title.text=[NSString stringWithFormat:@"%@",strUnicodeString];
    }
        //   cell.lbl_Title.text =
    //[cell.fimages.layer setBorderColor: [[UIColor blackColor] CGColor]];
//    [cell.fimages.layer setBorderWidth: 2.0];
//    cell.fimages.layer.cornerRadius = 10;
    NSString *imageToLoad = [favrateDic objectForKey:@"product_image1"];
    
    NSString *imageToLoad2 = [favrateDic objectForKey:@"product_image2"];
    NSString *imageToLoad3 = [favrateDic objectForKey:@"product_image3"];
    NSString *imageToLoad4 = [favrateDic objectForKey:@"product_image4"];
    NSString *imageToLoad5 = [favrateDic objectForKey:@"product_image5"];
    NSString *imageToLoad6 = [favrateDic objectForKey:@"product_image6"];
    NSString *imageToLoad7 = [favrateDic objectForKey:@"product_image7"];
    NSString *imageToLoad8 = [favrateDic objectForKey:@"product_image8"];
    NSString *imageToLoad9 = [favrateDic objectForKey:@"product_image9"];
    NSString *imageToLoad10 = [favrateDic objectForKey:@"product_image10"];
    
    NSLog(@"imageToLoad = %@", imageToLoad);
    NSLog(@"kAppDelegate.strSubCategory = %@", kAppDelegate.strSubCategory);
    if(imageToLoad.length > 0) {
        [cell.fimages sd_setImageWithURL:[NSURL URLWithString:imageToLoad] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
    } else if(imageToLoad2.length > 0) {
        [cell.fimages sd_setImageWithURL:[NSURL URLWithString:imageToLoad2] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
    } else if(imageToLoad3.length > 0) {
        [cell.fimages sd_setImageWithURL:[NSURL URLWithString:imageToLoad3] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
    } else if(imageToLoad4.length > 0) {
        [cell.fimages sd_setImageWithURL:[NSURL URLWithString:imageToLoad4] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
    } else if(imageToLoad5.length > 0) {
        [cell.fimages sd_setImageWithURL:[NSURL URLWithString:imageToLoad5] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
    } else if(imageToLoad6.length > 0) {
        [cell.fimages sd_setImageWithURL:[NSURL URLWithString:imageToLoad6] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
    } else if(imageToLoad7.length > 0) {
        [cell.fimages sd_setImageWithURL:[NSURL URLWithString:imageToLoad7] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
    } else if(imageToLoad8.length > 0) {
        [cell.fimages sd_setImageWithURL:[NSURL URLWithString:imageToLoad8] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
    } else if(imageToLoad9.length > 0) {
        [cell.fimages sd_setImageWithURL:[NSURL URLWithString:imageToLoad9] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
    } else if(imageToLoad10.length > 0) {
        [cell.fimages sd_setImageWithURL:[NSURL URLWithString:imageToLoad10] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
    } else {
        [cell.fimages sd_setImageWithURL:[NSURL URLWithString:favrateDic[@"subcategory_image"]] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
        /*
        kAppDelegate.strSubCategory = @"";
        FMDBManager *fm = [[FMDBManager alloc] init];
        [fm openDataBase];
        NSArray * arr = [fm SubCategryarry:favrateDic[@"category_id"]];
        if(arr.count > 0) {
        NSDictionary * dict = arr[0];
        kAppDelegate.strSubCategory = dict[@"sub_category_image"];
        }
        [cell.fimages sd_setImageWithURL:[NSURL URLWithString:kAppDelegate.strSubCategory] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
         */
    }
   
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    
    favrateDic=[favtatearr objectAtIndex:indexPath.row];
    kAppDelegate.strSubCategory = @"";
    FMDBManager *fm = [[FMDBManager alloc] init];
    [fm openDataBase];
    NSArray * arr = [fm SubCategryarry:favrateDic[@"category_id"]];
    if(arr.count > 0) {
        NSDictionary * dict = arr[0];
        kAppDelegate.strSubCategory = dict[@"sub_category_image"];
    } else {
        kAppDelegate.strSubCategory = @"";
    }
    [self performSegueWithIdentifier:@"Businesss" sender:self];
    
}

- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
      {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)  {
            CGSize mElementSize = CGSizeMake(96, 102);
            return mElementSize;
          }
        if(result.height == 568)  {
            CGSize mElementSize = CGSizeMake(96, 106);
            return mElementSize;
            
          }
        if(result.height == 667)  {
            CGSize mElementSize = CGSizeMake(114, 122);
            return mElementSize;
          }
        
        if(result.height == 736)  {
            CGSize mElementSize = CGSizeMake(120, 128);
            return mElementSize;
        }
      }
    CGSize mElementSize = CGSizeMake(96, 92);
    return mElementSize; // will be w120xh100 or w190x100
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"Businesss"]) {
        BusinessdetailsViewController *subcatgry=segue.destinationViewController;
        subcatgry.getBussnessDic=favrateDic;
        subcatgry.ishistoty=YES;
        
        
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
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Are you sure you want to logout?",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK" ,nil) otherButtonTitles:NSLocalizedString(@"Cancel" ,nil), nil];
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
- (IBAction)ActionOnmenu:(id)sender {
    if (!isShownfaver) {
        
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
        
        isShownfaver = true;
        
    } else {
        
        
        CATransition *transition = [CATransition animation];
        transition.duration =0.5;
        transition.type = kCATransitionReveal;
        transition.subtype = kCATransitionFromRight;

        
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [sample.view.layer addAnimation:transition forKey:nil];
        [sample.view performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.5];
        
        isShownfaver = false;
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

- (IBAction)ActionOnHome:(id)sender {
    UIStoryboard *MainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    UINavigationController *controller = (UINavigationController*)[MainStoryboard
                                                                   instantiateViewControllerWithIdentifier: @"RootNavigationController"];
    
    
    UITabBarController *tabar = controller.viewControllers[0];
    [tabar setSelectedIndex:3];
    
    [AppDelegate SharedInstance].window.rootViewController=controller;
    [[AppDelegate SharedInstance].window makeKeyAndVisible];

}

- (IBAction)ActionOnback:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Do you want to close the Allinfo",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:NSLocalizedString(@"Cancel",nil), nil];
    alert.tag=11;
    [alert show];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==11) {
        if (buttonIndex == 0){
            
            exit(0);
            
        }
        
        
    }else  if (alertView.tag==1) {
        if (buttonIndex == 0){
            
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"login"];
            
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"userdata"];
            
            
            //login
            
        }
        
        
    }
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    [[AppDelegate SharedInstance]getselectedTab:tabBarController.selectedIndex];
}

@end

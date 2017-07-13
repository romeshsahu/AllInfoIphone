//
//  SubCategiryViewController.m
//  All Info
//
//  Created by Mahendra Suryavanshi on 3/5/16.
//  Copyright © 2016 PS.com. All rights reserved.
//
#import "LocationViewController.h"
#import "SubCategiryViewController.h"
#import "HomeCollectionViewCell.h"
#import "WSOperationInEDUApp.h"
#import "UIImageView+WebCache.h"
#import "GifFileViewController.h"
#import "MenuViewController.h"
#import "RegistrationViewController.h"
#import "AddbusinessViewController.h"
#import "LoginViewController.h"
#import "HelpViewController.h"
#import "ContectUsViewController.h"
@interface SubCategiryViewController ()<MenuViewControllerDelegates>
{
    NSMutableArray *subCatgiryarr;
    NSDictionary *subcategriyDic;
    UINavigationController *nav;
    MenuViewController * sample;
}

@end
NSString *ID = @"SubcellID";
@implementation SubCategiryViewController
bool issub = false;
- (void)viewDidLoad {
    [super viewDidLoad];
    [sample.view removeFromSuperview];
    self.tabBarController.tabBar.hidden=NO;
    subCatgiryarr =self.getsubArr;
    
    NSLog(@"subCatgiryarr = %@", subCatgiryarr[0]);
    
    NSSortDescriptor * descriptor = [NSSortDescriptor sortDescriptorWithKey:@"show_date" ascending:NO selector:@selector(localizedCaseInsensitiveCompare:)];
    NSArray * arrSorted = [NSArray arrayWithObject:descriptor];
    
    [subCatgiryarr sortUsingDescriptors:arrSorted];
    
    NSLog(@"subCatgiryarr sorted = %@", subCatgiryarr);
    
    [self.SubCollectionview reloadData];

    self.TitalLabel.text=[NSString stringWithFormat:@"%@",self.catgeryName];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
         [self.SubCollectionview setTransform:CGAffineTransformMakeScale(-1, 1)];
        // [self.contentView setTransform:CGAffineTransformMakeScale(-1, 1)];
    [super viewWillAppear:animated];
    [sample.view removeFromSuperview];
    self.tabBarController.tabBar.hidden=NO;
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
    issub = false;
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return subCatgiryarr.count;
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
-(NSInteger)numberOfSectionsInCollectionView:
(UICollectionView *)collectionView
{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    [cell.contentView setTransform:CGAffineTransformMakeScale(-1, 1)];
    subcategriyDic= [subCatgiryarr objectAtIndex:indexPath.row];
    cell.SubcatgiryTital.text = [subcategriyDic objectForKey:@"sub_category_name"];
    NSString *imageToLoad = [subcategriyDic objectForKey:@"sub_category_image"];
    //[cell.SubcatgeryImg sd_setImageWithURL:[NSURL URLWithString:imageToLoad] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
    //[cell .SubcatgeryImg]
    [cell.SubcatgeryImg sd_setImageWithURL:[NSURL URLWithString:imageToLoad] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // URL is as expected, but Image is wrong
    }];

    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
     self.isserchsetview=true;
    subcategriyDic=[subCatgiryarr objectAtIndex:indexPath.row];
    kAppDelegate.strSubCategory = [subcategriyDic objectForKey:@"sub_category_image"];
    NSLog(@"kAppDelegate.strSubCategory = %@", kAppDelegate.strSubCategory);
    [self performSegueWithIdentifier:@"GifView" sender:self];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"GifView"]) {
        GifFileViewController *subcatgry=segue.destinationViewController;
        subcatgry.getSubcategryDic=subcategriyDic;
        subcatgry.isserchsetview=true;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)BackBtn:(id)sender {
     [self .navigationController popViewControllerAnimated:YES];
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
- (IBAction)ActionOnmenu:(id)sender {
    if (!issub) {
        
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
        
        issub = true;
        
    } else {
        
        
        CATransition *transition = [CATransition animation];
        transition.duration =0.5;
        transition.type = kCATransitionReveal;
        transition.subtype = kCATransitionFromRight;
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [sample.view.layer addAnimation:transition forKey:nil];
        [sample.view performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.5];
        
        issub = false;
    }
}
//-(void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    if (self.isserchsetview==true) {
//        
//        self.isserchsetview=false;
//        
//    }else{
//        
//        [self.tabBarController setSelectedIndex:0];
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    
//    }
//}

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
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:NSLocalizedString(@"Are you sure you want to logout?",nil) delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
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
              //  price1.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
              //  price1.modalPresentationStyle = UIModalPresentationFormSheet;
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
@end

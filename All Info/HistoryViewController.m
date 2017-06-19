//
//  HistoryViewController.m
//  All Info
//
//  Created by iPhones on 4/23/16.
//  Copyright © 2016 Parkhya solutions. All rights reserved.
//

#import "HistoryViewController.h"
#import "FMDBManager.h"
#import "HistoryTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "MenuViewController.h"
#import "LoginViewController.h"
#import "RegistrationViewController.h"
#import "AddbusinessViewController.h"
#import "BusinessdetailsViewController.h"
#import "HelpViewController.h"
#import "ContectUsViewController.h"
#import "AppDelegate.h"

@interface HistoryViewController ()<UITableViewDataSource , UITableViewDelegate,MenuViewControllerDelegates,UITabBarControllerDelegate> {
    NSMutableArray *HistoryArr;
    NSMutableDictionary *BussnessDic;
    MenuViewController * sample;
}

@end
bool isShownhist = false;
@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [sample.view removeFromSuperview];
    [sample.view removeFromSuperview];
    self.tabBarController.tabBar.hidden=NO;
    self.tabBarController.delegate = self;
    
     self.HistHedinLabel.text=NSLocalizedString(@"History",nil);

    FMDBManager *fm = [[FMDBManager alloc] init];
    [fm openDataBase];
    
    NSMutableArray * arrData = [fm gethistory];
    HistoryArr = (NSMutableArray *)[[arrData reverseObjectEnumerator] allObjects];
    
    
    
//    if (HistoryArr == nil || [HistoryArr count] == 0) {
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
    NSMutableArray * arrData = [fm gethistory];
    HistoryArr = (NSMutableArray *)[[arrData reverseObjectEnumerator] allObjects];
    
   // NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:@"create_date" ascending:YES];
  //  [HistoryArr sortUsingDescriptors:[NSArray arrayWithObject:sorter]];

    [self.HistoryTableView reloadData];
    
}

-(void)sort_by_Date
{
    
   // NSMutableArray *arrSortedDate=[[NSMutableArray alloc]init];
   // arrSortedDate = HistoryArr;
    NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:@"create_date" ascending:YES];
    [HistoryArr sortUsingDescriptors:[NSArray arrayWithObject:sorter]];
    
   // NSLog(@"arrSortedDate....%@",arrSortedDate);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Delegates
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HistoryTableViewCell *cell = (HistoryTableViewCell *)[self.HistoryTableView dequeueReusableCellWithIdentifier:@"cellhistory"];
    NSString* strUnicodeString=[HistoryArr objectAtIndex:indexPath.row][@"business_name"];
    if ([strUnicodeString canBeConvertedToEncoding:NSASCIIStringEncoding]){
        NSData *data = [strUnicodeString dataUsingEncoding:NSUTF8StringEncoding];
        NSString *string = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding];
        cell.businesnamelab.text=[NSString stringWithFormat:@"%@",string];
        
    }else{
         cell.businesnamelab.text=[NSString stringWithFormat:@"%@",strUnicodeString];
    }

    NSString *distanceString = [HistoryArr objectAtIndex:indexPath.row][@"distance"];
    float your_float = [distanceString floatValue];
    NSLog(@"float value is: %.1f", your_float);
    NSString *fString = [NSString stringWithFormat:@"%.1f", your_float];
    cell.destancelabel.text=[NSString stringWithFormat:@"%@ km",fString];

    NSDictionary * dict =  [HistoryArr objectAtIndex:indexPath.row];
    
    NSString *imageToLoad = [dict objectForKey:@"product_image1"];
    
    NSString *imageToLoad2 = [dict objectForKey:@"product_image2"];
    NSString *imageToLoad3 = [dict objectForKey:@"product_image3"];
    NSString *imageToLoad4 = [dict objectForKey:@"product_image4"];
    NSString *imageToLoad5 = [dict objectForKey:@"product_image5"];
    NSString *imageToLoad6 = [dict objectForKey:@"product_image6"];
    NSString *imageToLoad7 = [dict objectForKey:@"product_image7"];
    NSString *imageToLoad8 = [dict objectForKey:@"product_image8"];
    NSString *imageToLoad9 = [dict objectForKey:@"product_image9"];
    NSString *imageToLoad10 = [dict objectForKey:@"product_image10"];
    
    NSLog(@"imageToLoad = %@", imageToLoad);
    NSLog(@"kAppDelegate.strSubCategory = %@", kAppDelegate.strSubCategory);
    if(imageToLoad.length > 0) {
        [cell.histimgesview sd_setImageWithURL:[NSURL URLWithString:imageToLoad] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
    } else if(imageToLoad2.length > 0) {
        [cell.histimgesview sd_setImageWithURL:[NSURL URLWithString:imageToLoad2] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
    } else if(imageToLoad3.length > 0) {
        [cell.histimgesview sd_setImageWithURL:[NSURL URLWithString:imageToLoad3] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
    } else if(imageToLoad4.length > 0) {
        [cell.histimgesview sd_setImageWithURL:[NSURL URLWithString:imageToLoad4] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
    } else if(imageToLoad5.length > 0) {
        [cell.histimgesview sd_setImageWithURL:[NSURL URLWithString:imageToLoad5] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
    } else if(imageToLoad6.length > 0) {
        [cell.histimgesview sd_setImageWithURL:[NSURL URLWithString:imageToLoad6] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
    } else if(imageToLoad7.length > 0) {
        [cell.histimgesview sd_setImageWithURL:[NSURL URLWithString:imageToLoad7] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
    } else if(imageToLoad8.length > 0) {
        [cell.histimgesview sd_setImageWithURL:[NSURL URLWithString:imageToLoad8] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
    } else if(imageToLoad9.length > 0) {
        [cell.histimgesview sd_setImageWithURL:[NSURL URLWithString:imageToLoad9] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
    } else if(imageToLoad10.length > 0) {
        [cell.histimgesview sd_setImageWithURL:[NSURL URLWithString:imageToLoad10] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
    } else {
        
        [cell.histimgesview sd_setImageWithURL:[NSURL URLWithString:dict[@"subcategory_image"]] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
        /*
        kAppDelegate.strSubCategory = @"";
        FMDBManager *fm = [[FMDBManager alloc] init];
        [fm openDataBase];
        NSArray * arr = [fm SubCategryarry:dict[@"category_id"]];
        if(arr.count > 0) {
            NSDictionary * dict = arr[0];
            kAppDelegate.strSubCategory = dict[@"sub_category_image"];
            [cell.histimgesview sd_setImageWithURL:[NSURL URLWithString:kAppDelegate.strSubCategory] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
        }
        */
    }

    if([[HistoryArr objectAtIndex:indexPath.row][@"is_open"] intValue] == 1) {
        cell.lbl_Status.text = @"";
        
    } else if([[HistoryArr objectAtIndex:indexPath.row][@"is_open"] intValue] == 2){
        cell.lbl_Status.text = NSLocalizedString(@"Close",nil);//@"closed";
    }
    return  cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return HistoryArr.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BussnessDic = [HistoryArr objectAtIndex:indexPath.row];
    FMDBManager *fm = [[FMDBManager alloc] init];
    [fm openDataBase];
    
   
   
    [self performSegueWithIdentifier:@"Details" sender:self];
    
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
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    [[AppDelegate SharedInstance]getselectedTab:tabBarController.selectedIndex];
}


- (IBAction)ActionOnmenu:(id)sender {
    if (!isShownhist) {
        
        sample = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
        sample.delegate = self;
        // nav=[[UINavigationController alloc]init:ll];
        sample.view.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height);
        
        CATransition *transition = [CATransition animation];
        transition.duration = 0.8;
        transition.type = kCATransitionPush;
        
        transition.subtype = kCATransitionFromLeft;
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [sample.view.layer addAnimation:transition forKey:nil];
        [self.view addSubview:sample.view];
        
        isShownhist = true;
        
    } else {
        
        
        CATransition *transition = [CATransition animation];
        transition.duration =0.8;
        transition.type = kCATransitionReveal;
        transition.subtype = kCATransitionFromRight;
        
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [sample.view.layer addAnimation:transition forKey:nil];
        [sample.view performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.8];
        
        isShownhist = false;
    }
}

- (IBAction)ActionONBack:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Alert",nil) message:NSLocalizedString(@"Do you want to close the Allinfo",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:NSLocalizedString(@"Cancel",nil), nil];
    alert.tag=11;
    [alert show];
    
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
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Alert",nil)  message:NSLocalizedString(@"Are you sure you want to logout?",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:NSLocalizedString(@"Cancel",nil), nil];
            alert.tag=1;
            [alert show];
        }
            break;
        case 7:
        {
            NSDictionary *UserDict =[[NSUserDefaults standardUserDefaults] objectForKey:@"userdata"];
            if (UserDict == nil) {
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Alert",nil) message:NSLocalizedString(@"Please login first",nil) preferredStyle:UIAlertControllerStyleAlert];
                
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
            

        default:
            break;
    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"Details"]) {
        BusinessdetailsViewController *Bissnesdetails=segue.destinationViewController;
        Bissnesdetails.getBussnessDic=BussnessDic;
        Bissnesdetails.ishistoty=YES;
        Bissnesdetails.ishistoryselected=true;
        Bissnesdetails.isserchsetview=true;
        
        
        
    }
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

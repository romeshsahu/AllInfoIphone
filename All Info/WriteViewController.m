//
//  WriteViewController.m
//  All Info
//
//  Created by iPhones on 5/4/16.
//  Copyright © 2016 PS.com. All rights reserved.
//
#import "LocationViewController.h"
#import "WriteViewController.h"
#import "RateView.h"
#import "WSOperationInEDUApp.h"
#import "BundleLocalization.h"
#import "AppDelegate.h"
#import "HelpViewController.h"
#import "LoginViewController.h"
#import "RegistrationViewController.h"
#import "AddbusinessViewController.h"
#import "MenuViewController.h"
#import "ContectUsViewController.h"

@interface WriteViewController ()
{
    NSString*finalrating;
    MenuViewController * sample;
}

@end
bool isShownhistwrite = false;
@implementation WriteViewController
//-(void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    
//    
//}
- (void)viewDidLoad {
    [super viewDidLoad];
     [self.WriteScrollView setContentSize:CGSizeMake(320, 490)];
    [sample.view removeFromSuperview];
    [sample.view removeFromSuperview];
    self.tabBarController.tabBar.hidden=NO;
    [self setupRateView];
    if ([self.usertextfiled respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor lightGrayColor];
        self.usertextfiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Name",nil) attributes:@{NSForegroundColorAttributeName: color}];
        self.CommentHeding.text=NSLocalizedString(@"Add Comments",nil);
        self.placehoderLabel.text=NSLocalizedString(@"Comment",nil);
        self.AddRatingLabel.text=NSLocalizedString(@"Add Rating",nil);
        [self.AddcomentBtn setTitle:NSLocalizedString(@"ADD COMMENT",nil) forState:UIControlStateNormal];
   
        UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
        [keyboardDoneButtonView sizeToFit];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                       style:UIBarButtonItemStyleBordered target:self
                                                                      action:@selector(doneClicked:)];
        [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
        self.usertextfiled.inputAccessoryView = keyboardDoneButtonView;
        self.commenttextview.inputAccessoryView = keyboardDoneButtonView;
        
        

    }
    // Do any additional setup after loading the view.
}
- (IBAction)doneClicked:(id)sender
{
    NSLog(@"Done Clicked.");
    [self.usertextfiled resignFirstResponder];
    [self.commenttextview resignFirstResponder];
    
    //[self.view endEditing:YES];
}
- (void)viewDidLayoutSubviews
{
    
    [self.WriteScrollView setContentSize:CGSizeMake(320, 490)];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [sample.view removeFromSuperview];
    [sample.view removeFromSuperview];
    self.tabBarController.tabBar.hidden=NO;
    
    if ([self.usertextfiled respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor lightGrayColor];
        self.usertextfiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"User",nil) attributes:@{NSForegroundColorAttributeName: color}];
        self.CommentHeding.text=NSLocalizedString(@"Add Comments",nil);
        self.placehoderLabel.text=NSLocalizedString(@"Comment",nil);
        self.AddRatingLabel.text=NSLocalizedString(@"Add Rating",nil);
        [self.AddcomentBtn setTitle:NSLocalizedString(@"ADD COMMENT",nil) forState:UIControlStateNormal];
    
    }
    
   

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//pragma mark - Rating method
-(void)setupRateView
{
    self.IBRaingView.notSelectedImage = [UIImage imageNamed:@"star_blank.png"];
    //self.CustomRateVIew.halfSelectedImage = [UIImage imageNamed:@"kermit_half.png"];
    self.IBRaingView.fullSelectedImage = [UIImage imageNamed:@"star_fill.png"];
    self.IBRaingView.rating = 0;
    self.IBRaingView.editable = YES;
    self.IBRaingView.maxRating = 5;
    self.IBRaingView.delegate = self;
}

#pragma mark - rate delegates

- (void)rateView:(RateView *)rateView ratingDidChange:(float)rating
{
    NSString *ratingstr = [NSString stringWithFormat:@"%f", rating];
    NSInteger rateint = [ratingstr integerValue];
    finalrating = [NSString stringWithFormat:@"%ld",(long)rateint];
    kAppDelegate.averageRating = [finalrating floatValue];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    
    NSMutableString *newString=[[NSMutableString alloc]initWithString:textView.text];
    if ([text isEqualToString: @""])
    {
        
        if (newString.length==0) {
            
        }else{
            
            NSRange ran=NSMakeRange(0, newString.length-1);
            
            NSString *str=[newString stringByReplacingCharactersInRange:ran withString:@""];
            
            NSRange NewRan=[newString rangeOfString:str];
            
            
            
            newString=[newString stringByReplacingCharactersInRange:NewRan withString:@""];
        }
    }else{
        [newString appendString:text];
    }
    
    
    
    if ([newString isEqualToString:@""]) {
        self.placehoderLabel.hidden = NO;
    }else if(newString.length>0){
        self.placehoderLabel.hidden = YES;
    }
    
    
    
    return YES;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)BackBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)MenuBtn:(id)sender {
    if (!isShownhistwrite) {
        [self.usertextfiled resignFirstResponder];
        [self.commenttextview resignFirstResponder];
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
        
        isShownhistwrite = true;
        
    } else {
        
        [self.usertextfiled resignFirstResponder];
        [self.commenttextview resignFirstResponder];
        CATransition *transition = [CATransition animation];
        transition.duration =0.8;
        transition.type = kCATransitionReveal;
         transition.subtype = kCATransitionFromRight;
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [sample.view.layer addAnimation:transition forKey:nil];
        [sample.view performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.8];
        
        isShownhistwrite = false;
    }

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
}
- (IBAction)ActionOnAddComent:(id)sender {
    if (self.usertextfiled.text.length==0) {
              UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message: NSLocalizedString(@"Fill Name Field",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
        [alert show];
    }else if (self.commenttextview.text.length==0){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"Fill Comment Field",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
        [alert show];
    }
    else{
    WSOperationInEDUApp *ws=[[WSOperationInEDUApp alloc]initWithDelegate:self callback:@selector(Addcoment:)];
    
    [ws WriteReview:@"0" language_id:@"2" business_id:[self.Bussinedic objectForKey:@"user_id"] name:self.usertextfiled.text comment:self.commenttextview.text rating:finalrating];
        
    }
    
}
-(void)Addcoment:(id)response
{
    
    NSDictionary *responseDic=response;
    if ([response isKindOfClass:[NSDictionary class]]) {
        NSLog(@"responseDic = %@", responseDic);
        
        if ([[responseDic objectForKey:@"message"]isEqualToString:@"success"]) {
            kAppDelegate.flagIsShowAverageRating = YES;
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"לא ניתן להשאיר יותר מתגובה אחת" delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
            [alert show];
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
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Are you sure you want to logout?",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:NSLocalizedString(@"Cancel",nil), nil];
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
                price1.modalPresentationStyle = UIModalPresentationFormSheet;
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
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==1) {
        if (buttonIndex == 0){
            
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"login"];

            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"userdata"];
           
            
            //login
            
        }
        
        
    }
}
@end

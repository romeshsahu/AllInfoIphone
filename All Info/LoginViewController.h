//
//  LoginViewController.h
//  All Info
//
//  Created by Mahendra Suryavanshi on 3/5/16.
//  Copyright © 2016 PS.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <GoogleSignIn/GoogleSignIn.h>



@interface LoginViewController : UIViewController
{
    IBOutlet UIButton *ViewFbButton;
    
    NSString *strFBID ;
    NSString *strFBName ;
    NSString *strFBemail ;

}
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;
@property (weak, nonatomic) IBOutlet GIDSignInButton *signInButton;

- (IBAction)BackBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *LoginScrollView;


- (IBAction)ActionOnHome:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *LoginBtnOut;

@property (weak, nonatomic) IBOutlet UITextField *UserNameTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *PasswordTextFiled;
- (IBAction)TermsAndcondition:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *checkOutlet;
@property (weak, nonatomic) IBOutlet UIImageView *Chackimg;
- (IBAction)ActiononLoginBtn:(id)sender;
- (IBAction)btn_Share:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnGoogle;


@end

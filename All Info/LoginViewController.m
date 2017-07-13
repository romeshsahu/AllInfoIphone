//
//  LoginViewController.m
//  All Info
//
//  Created by Mahendra Suryavanshi on 3/5/16.
//  Copyright © 2016 PS.com. All rights reserved.
//

#import "LoginViewController.h"
#import "UIScrollView+TPKeyboardAvoidingAdditions.h"
#import "MenuViewController.h"
#import "WSOperationInEDUApp.h"
#import "AppDelegate.h"
#import "UnicodeConversionClass.h"



@interface LoginViewController ()<GIDSignInDelegate, GIDSignInUIDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      self.tabBarController.tabBar.hidden=YES;
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"login"]isEqualToString:@"Yes"]) {
        [self performSegueWithIdentifier:@"Bussinesaad" sender:self];
        
    }
    self.LoginScrollView.contentSize = CGSizeMake(320, 400);
    if ([self.UserNameTextFiled respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor lightGrayColor];
        self.UserNameTextFiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"User Name",nil) attributes:@{NSForegroundColorAttributeName: color}];
        self.PasswordTextFiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Password",nil) attributes:@{NSForegroundColorAttributeName: color}];
        [self.LoginBtnOut setTitle:NSLocalizedString(@"LOGIN",nil) forState:UIControlStateNormal];
    }
    
    [[GIDSignIn sharedInstance] signOut];
    [GIDSignIn sharedInstance].uiDelegate = self;
    [GIDSignIn sharedInstance].delegate = self;
    [GIDSignIn sharedInstance].clientID =  @"658798455181-0ja0a73n7ubc4h0drp1spq0uedr57qrn.apps.googleusercontent.com";
    [[GIDSignIn sharedInstance] signInSilently];

    if ([GIDSignIn sharedInstance].hasAuthInKeychain) {
        NSLog(@"Signed in");
    } else {
        NSLog(@"Not signed in");
    }
    
    UIButton *myGoogle=[UIButton buttonWithType:UIButtonTypeCustom];
    myGoogle.frame=CGRectMake(0,0,_btnGoogle.frame.size.width,_btnGoogle.frame.size.height);
    [myGoogle addTarget:self action:@selector(googleStuff) forControlEvents:UIControlEventTouchUpInside];
    [myGoogle setBackgroundImage:[UIImage imageNamed:@"icon_googlegoogle.png"] forState:UIControlStateNormal];
    [_btnGoogle addSubview:myGoogle];
    
    UIButton *myLoginButton=[UIButton buttonWithType:UIButtonTypeCustom];
    myLoginButton.frame=CGRectMake(0,0,ViewFbButton.frame.size.width,ViewFbButton.frame.size.height);
    [myLoginButton addTarget:self action:@selector(loginButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [myLoginButton setBackgroundImage:[UIImage imageNamed:@"icon_fb.png"] forState:UIControlStateNormal];
    [ViewFbButton addSubview:myLoginButton];
    
}
-(void)googleStuff
{
    [[GIDSignIn sharedInstance] setAllowsSignInWithWebView:NO];
    [[GIDSignIn sharedInstance] hasAuthInKeychain];
    [[GIDSignIn sharedInstance] signIn];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLayoutSubviews
{
    
    self.LoginScrollView.contentSize = CGSizeMake(320, 400);
}

#pragma mark - Email Validation

-(BOOL)EmailCheck:(NSString*)sender
{
    // NSString *emailRegex = @"[a-zA-Z0-9._-]+@[a-z_-]+\\.+[a-z]+";
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailValidation = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    if (![emailValidation evaluateWithObject:self.UserNameTextFiled.text]) {
        return NO;
    }
    return YES;
    
    
}

#pragma mark - text field delegates
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)BackBtn:(id)sender {
     [self .navigationController popViewControllerAnimated:YES];
}
- (IBAction)TermsAndcondition:(id)sender {
    if (self.checkOutlet.selected==NO) {
        //Agree to Terms and Conditions
        self.checkOutlet.selected=YES;
        //self.Ischeck=YES;
        [self.Chackimg setImage:[UIImage imageNamed:@"Log-in_TermsBlack.png"] ];
    }else{
        self.checkOutlet.selected=NO;
        [self.Chackimg setImage:[UIImage imageNamed:@"Log-in_Terms.png"] ];
        //self.Ischeck=NO;
    }
}
- (IBAction)ActiononLoginBtn:(id)sender {
 
    if (self.UserNameTextFiled.text.length==0) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"Please enter your User Name.",nil)  delegate:nil cancelButtonTitle:NSLocalizedString(@"OK" ,nil) otherButtonTitles:nil];
        [alert show];
    }else if (self.PasswordTextFiled.text.length==0){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"Please enter Password.",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
        [alert show];
    }
    else{
        [self.UserNameTextFiled resignFirstResponder];
        [self.PasswordTextFiled resignFirstResponder];
        WSOperationInEDUApp *ws=[[WSOperationInEDUApp alloc]initWithDelegate:self callback:@selector(login:)];
        //[ws Login:self.UserNameTextFiled.text password:self.PasswordTextFiled.text];
        [ws Login:@"2" email:self.UserNameTextFiled.text password:self.PasswordTextFiled.text];
        
        //http://parkhyamapps.co.in/all_in/webservice/master.php?action=login&email=suniltale@gmail.com&password=12345
    }

}

#pragma mark---Social login

-(void)loginButtonClicked
{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"public_profile", @"email", @"user_friends"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             [FBSDKAccessToken setCurrentAccessToken:nil];
             [FBSDKProfile setCurrentProfile:nil];
         }  else {
             NSLog(@"Logged in result....%@", result);
             if ([result.grantedPermissions containsObject:@"email"]) {
                 if ([FBSDKAccessToken currentAccessToken]) {
                     [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"name, picture, email"}]
                      startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                          if (!error)  {
                              NSLog(@"fetched user:%@", result);
                              UnicodeConversionClass * unicodeClass = [[UnicodeConversionClass alloc] init];
                              strFBID=[result valueForKey:@"id"];
                              strFBName= [result valueForKey:@"name"];//[unicodeClass perCharToUniCode: [result valueForKey:@"name"]];
                              strFBemail=[result valueForKey:@"email"];
                              NSString *strURL = [[[result valueForKey:@"picture"] valueForKey:@"data"] valueForKey:@"url"];
                              WSOperationInEDUApp *ws=[[WSOperationInEDUApp alloc]initWithDelegate:self callback:@selector(login_FB:)];
                              [ws FBLogin_action:@"socialLogin" social_id:strFBID language_id:@"2" email:strFBemail username:strFBName profile_image:strURL social_type:@"1"];
                          }
                      }];
                 }
             }
         }
     }];
}

-(void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error {
    if (error != nil) {
        NSLog(@"error...%@",error);
    }else{
        NSLog(@"user...%@",user);
        UnicodeConversionClass * unicodeClass = [[UnicodeConversionClass alloc] init];
        
        strFBID=user.userID;
        strFBName= user.profile.name;//[unicodeClass perCharToUniCode:user.profile.name];//
        strFBemail=user.profile.email;
        
        WSOperationInEDUApp *ws=[[WSOperationInEDUApp alloc]initWithDelegate:self callback:@selector(login_Google:)];
        [ws GOOGLELogin_action:@"socialLogin" social_id:strFBID language_id:@"2" email:strFBemail username:strFBName profile_image:@"" social_type:@"2"];
        
    }
}
-(void)signIn:(GIDSignIn *)signIn presentViewController:(UIViewController *)viewController
{
    [self presentViewController:viewController animated:true completion:nil];
}
-(void)signIn:(GIDSignIn *)signIn dismissViewController:(UIViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:NULL];

}


-(IBAction)btnFBLogin:(id)sender
{
    [self loginButtonClicked];
}

-(IBAction)btnGoogleLogin:(id)sender
{
    [[GIDSignIn sharedInstance] signIn];

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
-(void)login:(id)response
{
    NSDictionary *responseDic=response;
    if ([response isKindOfClass:[NSDictionary class]]) {
        if ([[responseDic objectForKey:@"message"]isEqualToString:@"success"]) {
            NSDictionary *userDic=[responseDic objectForKey:@"user_detail"];
            NSString*user_id=[userDic objectForKey:@"user_id"];
            NSString*login_id=[userDic objectForKey:@"login_id"];
            NSString*username=[userDic objectForKey:@"username"];
            NSString*description=[userDic objectForKey:@"description"];
            NSString*email=[userDic objectForKey:@"email"];
            NSString*user_image=[userDic objectForKey:@"user_image"];
            NSString*phone=[userDic objectForKey:@"phone"];
            NSString*address=[userDic objectForKey:@"address"];
            NSString*latitude=[userDic objectForKey:@"latitude"];
            NSString*longitude=[userDic objectForKey:@"longitude"];
            NSString*business_type_id=[userDic objectForKey:@"business_type_id"];
            NSString*business_name=[userDic objectForKey:@"business_name"];
            NSString*sub_cat_id=[userDic objectForKey:@"sub_cat_id"];
            NSString*website_url=[userDic objectForKey:@"website_url"];
            NSString*video_url=[userDic objectForKey:@"video_url"];
            NSString*product_image1=[userDic objectForKey:@"product_image1"];
            NSString*product_image2=[userDic objectForKey:@"product_image2"];
            NSString*product_image3=[userDic objectForKey:@"product_image3"];
            NSString*product_image4=[userDic objectForKey:@"product_image4"];
            NSString*product_image5=[userDic objectForKey:@"product_image5"];
            NSString*product_image6=[userDic objectForKey:@"product_image6"];
            NSString*product_image7=[userDic objectForKey:@"product_image7"];
            NSString*product_image8=[userDic objectForKey:@"product_image8"];
            NSString*product_image9=[userDic objectForKey:@"product_image9"];
            NSString*product_image10=[userDic objectForKey:@"product_image10"];

            
            if ([user_id isEqual:[NSNull null]]) {
                user_id=@"";
            }else if ([user_id isEqual:@""]) {
                user_id=@"";
            }
            if ([description isEqual:[NSNull null]]) {
                description=@"";
            }else if ([description isEqual:@""]) {
                description=@"";
            }
            if ([login_id isEqual:[NSNull null]]) {
                login_id=@"";
            }else if ([login_id isEqual:@""]) {
                login_id=@"";
            }
            if ([username isEqual:[NSNull null]]) {
                username=@"";
            }else if ([username isEqual:@""]) {
                username=@"";
            }
            if ([email isEqual:[NSNull null]]) {
                email=@"";
            }else if ([email isEqual:@""]) {
                email=@"";
            }
            if ([user_image isEqual:[NSNull null]]) {
                user_image=@"";
            }else if ([user_image isEqual:@""]) {
                user_image=@"";
            }
            if ([phone isEqual:[NSNull null]]) {
                phone=@"";
            }else if ([phone isEqual:@""]) {
                phone=@"";
            }
            if ([address isEqual:[NSNull null]]) {
                address=@"";
            }else if ([address isEqual:@""]) {
                address=@"";
            }
            if ([latitude isEqual:[NSNull null]]) {
                latitude=@"";
            }else if ([latitude isEqual:@""]) {
                latitude=@"";
            }
            if ([longitude isEqual:[NSNull null]]) {
                longitude=@"";
            }else if ([longitude isEqual:@""]) {
                longitude=@"";
            }
            if ([business_type_id isEqual:[NSNull null]]) {
                business_type_id=@"";
            }else if ([business_type_id isEqual:@""]) {
                business_type_id=@"";
            }
            if ([business_name isEqual:[NSNull null]]) {
                business_name=@"";
            }else if ([business_name isEqual:@""]) {
                business_name=@"";
            }
            if ([sub_cat_id isEqual:[NSNull null]]) {
                sub_cat_id=@"";
            }else if ([sub_cat_id isEqual:@""]) {
                sub_cat_id=@"";
            }if ([website_url isEqual:[NSNull null]]) {
                website_url=@"";
            }else if ([website_url isEqual:@""]) {
                website_url=@"";
            }
            if ([video_url isEqual:[NSNull null]]) {
                video_url=@"";
            }else if ([video_url isEqual:@""]) {
                video_url=@"";
            }
            if ([product_image1 isEqual:[NSNull null]]) {
                product_image1=@"";
            }else if ([product_image1 isEqual:@""]) {
                product_image1=@"";
            }
            if ([product_image2 isEqual:[NSNull null]]) {
                product_image2=@"";
            }else if ([product_image2 isEqual:@""]) {
                product_image2=@"";
            }
            if ([product_image3 isEqual:[NSNull null]]) {
                product_image3=@"";
            }else if ([product_image3 isEqual:@""]) {
                product_image3=@"";
            }
            if ([product_image4 isEqual:[NSNull null]]) {
                product_image4=@"";
            }else if ([product_image4 isEqual:@""]) {
                product_image4=@"";
            }
            if ([product_image5 isEqual:[NSNull null]]) {
                product_image5=@"";
            }else if ([product_image5 isEqual:@""]) {
                product_image5=@"";
            }
            if ([product_image6 isEqual:[NSNull null]]) {
                product_image6=@"";
            }else if ([product_image6 isEqual:@""]) {
                product_image6=@"";
            }
            
            /////////////
            if ([product_image7 isEqual:[NSNull null]]) {
                product_image7=@"";
            }else if ([product_image7 isEqual:@""]) {
                product_image7=@"";
            }
            if ([product_image8 isEqual:[NSNull null]]) {
                product_image8=@"";
            }else if ([product_image8 isEqual:@""]) {
                product_image8=@"";
            }
            if ([product_image9 isEqual:[NSNull null]]) {
                product_image9=@"";
            }else if ([product_image9 isEqual:@""]) {
                product_image9=@"";
            }
            if ([product_image10 isEqual:[NSNull null]]) {
                product_image10=@"";
            }else if ([product_image10 isEqual:@""]) {
                product_image10=@"";
            }

            
            
            NSMutableDictionary *MyUserDic=[[NSMutableDictionary alloc]init];
            [MyUserDic setObject:user_id forKey:@"user_id"];
            [MyUserDic setObject:login_id forKey:@"login_id"];
            [MyUserDic setObject:description forKey:@"description"];
            [MyUserDic setObject:username forKey:@"username"];
            [MyUserDic setObject:email forKey:@"email"];
            [MyUserDic setObject:user_image forKey:@"user_image"];
            [MyUserDic setObject:phone forKey:@"phone"];
            [MyUserDic setObject:address forKey:@"address"];
            [MyUserDic setObject:latitude forKey:@"latitude"];
            [MyUserDic setObject:longitude forKey:@"longitude"];
            [MyUserDic setObject:business_type_id forKey:@"business_type_id"];
            [MyUserDic setObject:business_name forKey:@"business_name"];
            [MyUserDic setObject:sub_cat_id forKey:@"sub_cat_id"];
            [MyUserDic setObject:website_url forKey:@"website_url"];
            [MyUserDic setObject:video_url forKey:@"video_url"];
            [MyUserDic setObject:product_image1 forKey:@"product_image1"];
            [MyUserDic setObject:product_image2 forKey:@"product_image2"];
            [MyUserDic setObject:product_image3 forKey:@"product_image3"];
            [MyUserDic setObject:product_image4 forKey:@"product_image4"];
            [MyUserDic setObject:product_image5 forKey:@"product_image5"];
            [MyUserDic setObject:product_image6 forKey:@"product_image6"];
            
            [MyUserDic setObject:product_image7 forKey:@"product_image7"];
            [MyUserDic setObject:product_image8 forKey:@"product_image8"];
            [MyUserDic setObject:product_image9 forKey:@"product_image9"];
            [MyUserDic setObject:product_image10 forKey:@"product_image10"];

            [[NSUserDefaults standardUserDefaults]setValue:MyUserDic forKey:@"userdata"];
            
            NSLog(@"MyUserDic_Normal...%@",MyUserDic);
            [[NSUserDefaults standardUserDefaults]setObject:@"Yes" forKey:@"login"];
            [self performSegueWithIdentifier:@"Bussinesaad" sender:self];
            
        }else{
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:[responseDic objectForKey:@"message"] delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
            [alert show];
            
        }
    }
}
-(void)login_FB:(id)response
{
    NSDictionary *responseDic=response;
    if ([response isKindOfClass:[NSDictionary class]]) {
        if ([[responseDic objectForKey:@"message"]isEqualToString:@"success"]) {
            NSDictionary *userDic=[responseDic objectForKey:@"user_detail"];
            NSString*user_id=[userDic objectForKey:@"user_id"];
            NSString*login_id=[userDic objectForKey:@"login_id"];
            NSString*username=[userDic objectForKey:@"username"];
            NSString*description=[userDic objectForKey:@"description"];
            NSString*email=[userDic objectForKey:@"email"];
            NSString*user_image=[userDic objectForKey:@"user_image"];
            NSString*phone=[userDic objectForKey:@"phone"];
            NSString*address=[userDic objectForKey:@"address"];
            NSString*latitude=[userDic objectForKey:@"latitude"];
            NSString*longitude=[userDic objectForKey:@"longitude"];
            NSString*business_type_id=[userDic objectForKey:@"business_type_id"];
            NSString*business_name=[userDic objectForKey:@"business_name"];
            NSString*sub_cat_id=[userDic objectForKey:@"sub_cat_id"];
            NSString*website_url=[userDic objectForKey:@"website_url"];
            NSString*video_url=[userDic objectForKey:@"video_url"];
            NSString*product_image1=[userDic objectForKey:@"product_image1"];
            NSString*product_image2=[userDic objectForKey:@"product_image2"];
            NSString*product_image3=[userDic objectForKey:@"product_image3"];
            NSString*product_image4=[userDic objectForKey:@"product_image4"];
            NSString*product_image5=[userDic objectForKey:@"product_image5"];
            NSString*product_image6=[userDic objectForKey:@"product_image6"];
            
            NSString*product_image7=[userDic objectForKey:@"product_image7"];
            NSString*product_image8=[userDic objectForKey:@"product_image8"];
            NSString*product_image9=[userDic objectForKey:@"product_image9"];
            NSString*product_image10=[userDic objectForKey:@"product_image10"];
            

            if ([user_id isEqual:[NSNull null]]) {
                user_id=@"";
            }else if ([user_id isEqual:@""]) {
                user_id=@"";
            }
            if ([description isEqual:[NSNull null]]) {
                description=@"";
            }else if ([description isEqual:@""]) {
                description=@"";
            }
            if ([login_id isEqual:[NSNull null]]) {
                login_id=@"";
            }else if ([login_id isEqual:@""]) {
                login_id=@"";
            }
            if ([username isEqual:[NSNull null]]) {
                username=@"";
            }else if ([username isEqual:@""]) {
                username=@"";
            }
            if ([email isEqual:[NSNull null]]) {
                email=@"";
            }else if ([email isEqual:@""]) {
                email=@"";
            }
            if ([user_image isEqual:[NSNull null]]) {
                user_image=@"";
            }else if ([user_image isEqual:@""]) {
                user_image=@"";
            }
            if ([phone isEqual:[NSNull null]]) {
                phone=@"";
            }else if ([phone isEqual:@""]) {
                phone=@"";
            }
            if ([address isEqual:[NSNull null]]) {
                address=@"";
            }else if ([address isEqual:@""]) {
                address=@"";
            }
            if ([latitude isEqual:[NSNull null]]) {
                latitude=@"";
            }else if ([latitude isEqual:@""]) {
                latitude=@"";
            }
            if ([longitude isEqual:[NSNull null]]) {
                longitude=@"";
            }else if ([longitude isEqual:@""]) {
                longitude=@"";
            }
            if ([business_type_id isEqual:[NSNull null]]) {
                business_type_id=@"";
            }else if ([business_type_id isEqual:@""]) {
                business_type_id=@"";
            }
            if ([business_name isEqual:[NSNull null]]) {
                business_name=@"";
            }else if ([business_name isEqual:@""]) {
                business_name=@"";
            }
            if ([sub_cat_id isEqual:[NSNull null]]) {
                sub_cat_id=@"";
            }else if ([sub_cat_id isEqual:@""]) {
                sub_cat_id=@"";
            }if ([website_url isEqual:[NSNull null]]) {
                website_url=@"";
            }else if ([website_url isEqual:@""]) {
                website_url=@"";
            }
            if ([video_url isEqual:[NSNull null]]) {
                video_url=@"";
            }else if ([video_url isEqual:@""]) {
                video_url=@"";
            }
            if ([product_image1 isEqual:[NSNull null]]) {
                product_image1=@"";
            }else if ([product_image1 isEqual:@""]) {
                product_image1=@"";
            }
            if ([product_image2 isEqual:[NSNull null]]) {
                product_image2=@"";
            }else if ([product_image2 isEqual:@""]) {
                product_image2=@"";
            }
            if ([product_image3 isEqual:[NSNull null]]) {
                product_image3=@"";
            }else if ([product_image3 isEqual:@""]) {
                product_image3=@"";
            }
            if ([product_image4 isEqual:[NSNull null]]) {
                product_image4=@"";
            }else if ([product_image4 isEqual:@""]) {
                product_image4=@"";
            }
            if ([product_image5 isEqual:[NSNull null]]) {
                product_image5=@"";
            }else if ([product_image5 isEqual:@""]) {
                product_image5=@"";
            }
            if ([product_image6 isEqual:[NSNull null]]) {
                product_image6=@"";
            }else if ([product_image6 isEqual:@""]) {
                product_image6=@"";
            }
            /////////////
            if ([product_image7 isEqual:[NSNull null]]) {
                product_image7=@"";
            }else if ([product_image7 isEqual:@""]) {
                product_image7=@"";
            }
            if ([product_image8 isEqual:[NSNull null]]) {
                product_image8=@"";
            }else if ([product_image8 isEqual:@""]) {
                product_image8=@"";
            }
            if ([product_image9 isEqual:[NSNull null]]) {
                product_image9=@"";
            }else if ([product_image9 isEqual:@""]) {
                product_image9=@"";
            }
            if ([product_image10 isEqual:[NSNull null]]) {
                product_image10=@"";
            }else if ([product_image10 isEqual:@""]) {
                product_image10=@"";
            }

            NSMutableDictionary *MyUserDic=[[NSMutableDictionary alloc]init];
            [MyUserDic setObject:user_id forKey:@"user_id"];
            [MyUserDic setObject:login_id forKey:@"login_id"];
            [MyUserDic setObject:description forKey:@"description"];
            [MyUserDic setObject:username forKey:@"username"];
            [MyUserDic setObject:email forKey:@"email"];
            [MyUserDic setObject:user_image forKey:@"user_image"];
            [MyUserDic setObject:phone forKey:@"phone"];
            [MyUserDic setObject:address forKey:@"address"];
            [MyUserDic setObject:latitude forKey:@"latitude"];
            [MyUserDic setObject:longitude forKey:@"longitude"];
            [MyUserDic setObject:business_type_id forKey:@"business_type_id"];
            [MyUserDic setObject:business_name forKey:@"business_name"];
            [MyUserDic setObject:sub_cat_id forKey:@"sub_cat_id"];
            [MyUserDic setObject:website_url forKey:@"website_url"];
            [MyUserDic setObject:video_url forKey:@"video_url"];
            [MyUserDic setObject:product_image1 forKey:@"product_image1"];
            [MyUserDic setObject:product_image2 forKey:@"product_image2"];
            [MyUserDic setObject:product_image3 forKey:@"product_image3"];
            [MyUserDic setObject:product_image4 forKey:@"product_image4"];
            [MyUserDic setObject:product_image5 forKey:@"product_image5"];
            [MyUserDic setObject:product_image6 forKey:@"product_image6"];
            
            [MyUserDic setObject:product_image7 forKey:@"product_image7"];
            [MyUserDic setObject:product_image8 forKey:@"product_image8"];
            [MyUserDic setObject:product_image9 forKey:@"product_image9"];
            [MyUserDic setObject:product_image10 forKey:@"product_image10"];

            [[NSUserDefaults standardUserDefaults]setValue:MyUserDic forKey:@"userdata"];
            NSLog(@"MyUserDic_FB...%@",MyUserDic);

            [[NSUserDefaults standardUserDefaults]setObject:@"Yes" forKey:@"login"];
            [self performSegueWithIdentifier:@"Bussinesaad" sender:self];
            
        }else{
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:[responseDic objectForKey:@"message"] delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
            [alert show];
            
        }
    }
}

-(void)login_Google:(id)response
{
    NSDictionary *responseDic=response;
    if ([response isKindOfClass:[NSDictionary class]]) {
        if ([[responseDic objectForKey:@"message"]isEqualToString:@"success"]) {
            NSDictionary *userDic=[responseDic objectForKey:@"user_detail"];
            NSString*user_id=[userDic objectForKey:@"user_id"];
            NSString*login_id=[userDic objectForKey:@"login_id"];
            NSString*username=[userDic objectForKey:@"username"];
            NSString*description=[userDic objectForKey:@"description"];
            NSString*email=[userDic objectForKey:@"email"];
            NSString*user_image=[userDic objectForKey:@"user_image"];
            NSString*phone=[userDic objectForKey:@"phone"];
            NSString*address=[userDic objectForKey:@"address"];
            NSString*latitude=[userDic objectForKey:@"latitude"];
            NSString*longitude=[userDic objectForKey:@"longitude"];
            NSString*business_type_id=[userDic objectForKey:@"business_type_id"];
            NSString*business_name=[userDic objectForKey:@"business_name"];
            NSString*sub_cat_id=[userDic objectForKey:@"sub_cat_id"];
            NSString*website_url=[userDic objectForKey:@"website_url"];
            NSString*video_url=[userDic objectForKey:@"video_url"];
            NSString*product_image1=[userDic objectForKey:@"product_image1"];
            NSString*product_image2=[userDic objectForKey:@"product_image2"];
            NSString*product_image3=[userDic objectForKey:@"product_image3"];
            NSString*product_image4=[userDic objectForKey:@"product_image4"];
            NSString*product_image5=[userDic objectForKey:@"product_image5"];
            NSString*product_image6=[userDic objectForKey:@"product_image6"];
            
            NSString*product_image7=[userDic objectForKey:@"product_image7"];
            NSString*product_image8=[userDic objectForKey:@"product_image8"];
            NSString*product_image9=[userDic objectForKey:@"product_image9"];
            NSString*product_image10=[userDic objectForKey:@"product_image10"];
            
            if ([user_id isEqual:[NSNull null]]) {
                user_id=@"";
            }else if ([user_id isEqual:@""]) {
                user_id=@"";
            }
            if ([description isEqual:[NSNull null]]) {
                description=@"";
            }else if ([description isEqual:@""]) {
                description=@"";
            }
            if ([login_id isEqual:[NSNull null]]) {
                login_id=@"";
            }else if ([login_id isEqual:@""]) {
                login_id=@"";
            }
            if ([username isEqual:[NSNull null]]) {
                username=@"";
            }else if ([username isEqual:@""]) {
                username=@"";
            }
            if ([email isEqual:[NSNull null]]) {
                email=@"";
            }else if ([email isEqual:@""]) {
                email=@"";
            }
            if ([user_image isEqual:[NSNull null]]) {
                user_image=@"";
            }else if ([user_image isEqual:@""]) {
                user_image=@"";
            }
            if ([phone isEqual:[NSNull null]]) {
                phone=@"";
            }else if ([phone isEqual:@""]) {
                phone=@"";
            }
            if ([address isEqual:[NSNull null]]) {
                address=@"";
            }else if ([address isEqual:@""]) {
                address=@"";
            }
            if ([latitude isEqual:[NSNull null]]) {
                latitude=@"";
            }else if ([latitude isEqual:@""]) {
                latitude=@"";
            }
            if ([longitude isEqual:[NSNull null]]) {
                longitude=@"";
            }else if ([longitude isEqual:@""]) {
                longitude=@"";
            }
            if ([business_type_id isEqual:[NSNull null]]) {
                business_type_id=@"";
            }else if ([business_type_id isEqual:@""]) {
                business_type_id=@"";
            }
            if ([business_name isEqual:[NSNull null]]) {
                business_name=@"";
            }else if ([business_name isEqual:@""]) {
                business_name=@"";
            }
            if ([sub_cat_id isEqual:[NSNull null]]) {
                sub_cat_id=@"";
            }else if ([sub_cat_id isEqual:@""]) {
                sub_cat_id=@"";
            }if ([website_url isEqual:[NSNull null]]) {
                website_url=@"";
            }else if ([website_url isEqual:@""]) {
                website_url=@"";
            }
            if ([video_url isEqual:[NSNull null]]) {
                video_url=@"";
            }else if ([video_url isEqual:@""]) {
                video_url=@"";
            }
            if ([product_image1 isEqual:[NSNull null]]) {
                product_image1=@"";
            }else if ([product_image1 isEqual:@""]) {
                product_image1=@"";
            }
            if ([product_image2 isEqual:[NSNull null]]) {
                product_image2=@"";
            }else if ([product_image2 isEqual:@""]) {
                product_image2=@"";
            }
            if ([product_image3 isEqual:[NSNull null]]) {
                product_image3=@"";
            }else if ([product_image3 isEqual:@""]) {
                product_image3=@"";
            }
            if ([product_image4 isEqual:[NSNull null]]) {
                product_image4=@"";
            }else if ([product_image4 isEqual:@""]) {
                product_image4=@"";
            }
            if ([product_image5 isEqual:[NSNull null]]) {
                product_image5=@"";
            }else if ([product_image5 isEqual:@""]) {
                product_image5=@"";
            }
            if ([product_image6 isEqual:[NSNull null]]) {
                product_image6=@"";
            }else if ([product_image6 isEqual:@""]) {
                product_image6=@"";
            }
            /////////////
            if ([product_image7 isEqual:[NSNull null]]) {
                product_image7=@"";
            }else if ([product_image7 isEqual:@""]) {
                product_image7=@"";
            }
            if ([product_image8 isEqual:[NSNull null]]) {
                product_image8=@"";
            }else if ([product_image8 isEqual:@""]) {
                product_image8=@"";
            }
            if ([product_image9 isEqual:[NSNull null]]) {
                product_image9=@"";
            }else if ([product_image9 isEqual:@""]) {
                product_image9=@"";
            }
            if ([product_image10 isEqual:[NSNull null]]) {
                product_image10=@"";
            }else if ([product_image10 isEqual:@""]) {
                product_image10=@"";
            }

            NSMutableDictionary *MyUserDic=[[NSMutableDictionary alloc]init];
            [MyUserDic setObject:user_id forKey:@"user_id"];
            [MyUserDic setObject:login_id forKey:@"login_id"];
            [MyUserDic setObject:description forKey:@"description"];
            [MyUserDic setObject:username forKey:@"username"];
            [MyUserDic setObject:email forKey:@"email"];
            [MyUserDic setObject:user_image forKey:@"user_image"];
            [MyUserDic setObject:phone forKey:@"phone"];
            [MyUserDic setObject:address forKey:@"address"];
            [MyUserDic setObject:latitude forKey:@"latitude"];
            [MyUserDic setObject:longitude forKey:@"longitude"];
            [MyUserDic setObject:business_type_id forKey:@"business_type_id"];
            [MyUserDic setObject:business_name forKey:@"business_name"];
            [MyUserDic setObject:sub_cat_id forKey:@"sub_cat_id"];
            [MyUserDic setObject:website_url forKey:@"website_url"];
            [MyUserDic setObject:video_url forKey:@"video_url"];
            [MyUserDic setObject:product_image1 forKey:@"product_image1"];
            [MyUserDic setObject:product_image2 forKey:@"product_image2"];
            [MyUserDic setObject:product_image3 forKey:@"product_image3"];
            [MyUserDic setObject:product_image4 forKey:@"product_image4"];
            [MyUserDic setObject:product_image5 forKey:@"product_image5"];
            [MyUserDic setObject:product_image6 forKey:@"product_image6"];
            [MyUserDic setObject:product_image7 forKey:@"product_image7"];
            [MyUserDic setObject:product_image8 forKey:@"product_image8"];
            [MyUserDic setObject:product_image9 forKey:@"product_image9"];
            [MyUserDic setObject:product_image10 forKey:@"product_image10"];

            [[NSUserDefaults standardUserDefaults]setValue:MyUserDic forKey:@"userdata"];
            NSLog(@"MyUserDic_Google...%@",MyUserDic);

            [[NSUserDefaults standardUserDefaults]setObject:@"Yes" forKey:@"login"];
            [self performSegueWithIdentifier:@"Bussinesaad" sender:self];
    
        }else{
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:[responseDic objectForKey:@"message"] delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
            [alert show];
        }
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
@end

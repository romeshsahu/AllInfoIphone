//
//  LeavemessageViewController.m
//  All Info
//
//  Created by Mahendra Suryavanshi on 3/8/16.
//  Copyright © 2016 PS.com. All rights reserved.
//

#import "LeavemessageViewController.h"
#import "WSOperationInEDUApp.h"
#import "AppDelegate.h"

@interface LeavemessageViewController ()

@end

@implementation LeavemessageViewController

// Do any additional setup after loading the view.


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)doneClicked:(id)sender
{
    
    [self.NameTextFiled resignFirstResponder];
    [self.PhoneTextFiled resignFirstResponder];
    [self.EmailTextFiled resignFirstResponder];
    [self.MessageTextview resignFirstResponder];
    
}
- (void)viewDidLayoutSubviews
{
    
    [self.LeveScrollView setContentSize:CGSizeMake(320, 490)];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden=NO;
     [self.LeveScrollView setContentSize:CGSizeMake(320, 490)];
    UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStyleDone target:self action:@selector(doneClicked:)];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
    self.NameTextFiled.inputAccessoryView = keyboardDoneButtonView;
    self.PhoneTextFiled.inputAccessoryView = keyboardDoneButtonView;
    self.EmailTextFiled.inputAccessoryView = keyboardDoneButtonView;
    self.MessageTextview.inputAccessoryView = keyboardDoneButtonView;
    
    if ([self.NameTextFiled respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor lightGrayColor];
        self.NameTextFiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Name",nil) attributes:@{NSForegroundColorAttributeName: color}];
        self.PhoneTextFiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Phone",nil) attributes:@{NSForegroundColorAttributeName: color}];
        self.EmailTextFiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"email",nil) attributes:@{NSForegroundColorAttributeName: color}];
        self.PlaceHoderLabel.text=NSLocalizedString(@"A message from All Info user",nil);
        self.LeveMesageLable.text=NSLocalizedString(@"Leave a message",nil);
        
        [self.SendbtnOut setTitle:NSLocalizedString(@"Send",nil) forState:UIControlStateNormal];
    }

    // Do any additional setup after loading the view.
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
        self.PlaceHoderLabel.hidden = NO;
        
    }else if(newString.length>0){
        self.PlaceHoderLabel.hidden = YES;
       
    }
    
    
    
    return YES;
}

- (IBAction)ActionOnsend:(id)sender {
    if (self.NameTextFiled.text.length==0){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message: NSLocalizedString(@"Please  enter Name.",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"Yes",nil)  otherButtonTitles:nil];
        [alert show];
    }else if (self.EmailTextFiled.text.length==0){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"Please enter email.",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"Yes",nil) otherButtonTitles:nil];
        [alert show];
    }else if (self.PhoneTextFiled.text.length==0){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"Please enter a valid phone Number.",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"Yes",nil) otherButtonTitles:nil];
        [alert show];
    }else if (self.MessageTextview.text.length==0){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"Please enter Message.",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"Yes",nil) otherButtonTitles:nil];
            [alert show];
    }else{
        
        [self.PhoneTextFiled resignFirstResponder];
        [self.NameTextFiled resignFirstResponder];
        WSOperationInEDUApp *ws=[[WSOperationInEDUApp alloc]initWithDelegate:self callback:@selector(sendmessage:)];
        [ws sendmessage:self.NameTextFiled.text phone:self.PhoneTextFiled.text business_id:[self.Businesdic objectForKey:@"user_id"] email_id:self.EmailTextFiled.text message:self.MessageTextview.text];
           }

}-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [self.PhoneTextFiled resignFirstResponder];
    [self.NameTextFiled resignFirstResponder];
    [self.MessageTextview resignFirstResponder];
}
-(void)sendmessage:(id)response
{
    self.PhoneTextFiled.text =@"";
    self.NameTextFiled.text =@"";
    self.MessageTextview.text =@"";
    NSDictionary *responseDic=response;
    if ([response isKindOfClass:[NSDictionary class]]) {
        if ([[responseDic objectForKey:@"message"]isEqualToString:@"success"]) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"send successfully.",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Yes",nil) otherButtonTitles:nil];
             alert.tag=1;
             [alert show];
        
            
        }
    }
    
   
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==1) {
         [self.navigationController popViewControllerAnimated:YES];
        
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

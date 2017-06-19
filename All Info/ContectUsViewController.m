//
//  ContectUsViewController.m
//  All Info
//
//  Created by iPhones on 6/20/16.
//  Copyright © 2016 PS.com. All rights reserved.
//

#import "ContectUsViewController.h"
#import "WSOperationInEDUApp.h"
#import "AppDelegate.h"

@interface ContectUsViewController ()

@end

@implementation ContectUsViewController
// Do any additional setup after loading the view.



- (IBAction)doneClicked:(id)sender
{
    
    [self.Nametextfiled resignFirstResponder];
    [self.EmailtextFiled resignFirstResponder];
    [self.phoneNotextfiled resignFirstResponder];
    [self.Subjecttextview resignFirstResponder];
    [self.DescriptinTextView resignFirstResponder];
    
}
- (void)viewDidLayoutSubviews
{
    
    [ self.ContectScrollView setContentSize:CGSizeMake(320, 525)];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [ self.ContectScrollView setContentSize:CGSizeMake(320, 525)];

    UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStyleDone target:self action:@selector(doneClicked:)];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
    self.Nametextfiled.inputAccessoryView = keyboardDoneButtonView;
    self.EmailtextFiled.inputAccessoryView = keyboardDoneButtonView;
    self.phoneNotextfiled.inputAccessoryView = keyboardDoneButtonView;
    self.Subjecttextview.inputAccessoryView = keyboardDoneButtonView;
    self.DescriptinTextView.inputAccessoryView = keyboardDoneButtonView;

    
    if ([self.Nametextfiled respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor lightGrayColor];
        self.Nametextfiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Name",nil) attributes:@{NSForegroundColorAttributeName: color}];
        self.EmailtextFiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString: NSLocalizedString(@"Email",nil) attributes:@{NSForegroundColorAttributeName: color}];
        self.phoneNotextfiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Phone",nil) attributes:@{NSForegroundColorAttributeName: color}];
        self.Subjecttextview.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Subject",nil) attributes:@{NSForegroundColorAttributeName: color}];
        self.plaseHoderlabel.text=NSLocalizedString(@"A message from Allinfo user",nil);
        [self.SentBtnout setTitle:NSLocalizedString(@"Send",nil) forState:UIControlStateNormal];
    }
 
    // Do any additional setup after loading the view.
}
#pragma mark - text field delegates
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==self.Nametextfiled) {
        [self.EmailtextFiled becomeFirstResponder];
    }else if (textField==self.EmailtextFiled){
        [self.phoneNotextfiled becomeFirstResponder];
    }else if (textField==self.phoneNotextfiled){
        [self.Subjecttextview becomeFirstResponder];
    }else if (textField==self.Subjecttextview){
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        self.plaseHoderlabel.hidden = NO;
    }else if(newString.length>0){
        self.plaseHoderlabel.hidden = YES;
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
-(BOOL)EmailCheck:(NSString*)sender
{
    // NSString *emailRegex = @"[a-zA-Z0-9._-]+@[a-z_-]+\\.+[a-z]+";
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailValidation = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    if (![emailValidation evaluateWithObject:self.EmailtextFiled.text]) {
        return NO;
    }
    return YES;
    
    
}
//#pragma mark - Email Validation
//
//-(BOOL)EmailCheck:(NSString*)sender
//{
//    NSString *emailRegex = @"[a-zA-Z0-9._-]+@[a-z_-]+\\.+[a-z]+";
//    NSPredicate *emailValidation = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
//    if (![emailValidation evaluateWithObject:sender]) {
//        return NO;
//    }
//    return YES;
//}

- (IBAction)ActionnSent:(id)sender {
    if (self.Nametextfiled.text.length==0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Fill Name Field",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString( @"OK",nil) otherButtonTitles:nil];
        [alert show];
    }else if (self.EmailtextFiled.text.length==0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Fill Email Field",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK" ,nil) otherButtonTitles:nil];
        [alert show];
    }else if (![self EmailCheck:self.EmailtextFiled.text]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Fill valid Email Field",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK" ,nil) otherButtonTitles:nil];
        
        [alert show];
    }else if (self.Subjecttextview.text.length==0){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Fill Subject Field",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK" ,nil) otherButtonTitles:nil];
        [alert show];
    }else if (self.phoneNotextfiled.text.length==0){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Fill Phone Field",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK" ,nil) otherButtonTitles:nil];
        [alert show];
    }else if (self.DescriptinTextView.text.length==0){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Fill message Field",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK" ,nil) otherButtonTitles:nil];
        [alert show];
    }else{
    
     WSOperationInEDUApp *ws=[[WSOperationInEDUApp alloc]initWithDelegate:self callback:@selector(sendinquri:)];
     [ws contact_request:self.Nametextfiled.text email:self.EmailtextFiled.text phone:self.phoneNotextfiled.text subject:self.Subjecttextview.text message:self.DescriptinTextView.text  ];
    }
}

-(void)sendinquri:(id)response
{
    
    NSDictionary *responseDic=response;
    if ([response isKindOfClass:[NSDictionary class]]) {
        if ([[responseDic objectForKey:@"message"]isEqualToString:@"success"]) {
            [self .navigationController popViewControllerAnimated:YES];
        }else{
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Email already exists",nil) message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alert show];
            
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


- (IBAction)ActionOnback:(id)sender {
     [self .navigationController popViewControllerAnimated:YES];
}
@end

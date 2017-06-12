//
//  CallSendViewController.m
//  All Info
//
//  Created by Mahendra Suryavanshi on 3/5/16.
//  Copyright © 2016 PS.com. All rights reserved.
//

#import "CallSendViewController.h"
#import "WSOperationInEDUApp.h"
#import "UIScrollView+TPKeyboardAvoidingAdditions.h"

@interface CallSendViewController ()

@end

@implementation CallSendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.NameTextFiled resignFirstResponder];
    [self.EmailTextFiled resignFirstResponder];
     [self.PhoneTextFiled resignFirstResponder];
    [self.SubjecttextFiled resignFirstResponder];
    [self.MessageTextView resignFirstResponder];
    
}
#pragma mark - text field delegates
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==self.NameTextFiled) {
        [self.EmailTextFiled becomeFirstResponder];
    }else if (textField==self.EmailTextFiled){
        [self.PhoneTextFiled becomeFirstResponder];
    }else if (textField==self.SubjecttextFiled){
        [self.SubjecttextFiled becomeFirstResponder];
    }else if (textField==self.SubjecttextFiled){
        [self.MessageTextView becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if (textField==self.PhoneTextFiled){
        
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-100, self.view.frame.size.width, self.view.frame.size.height);
        
    }else if (textField==self.SubjecttextFiled){
        
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-120, self.view.frame.size.width, self.view.frame.size.height);
        
    }
}
#pragma mark - ComentTextView
//---------------------------------------------------------------------------------------------------
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    
    
        if (textView==self.MessageTextView)
       {
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-200, self.view.frame.size.width, self.view.frame.size.height);
        }
    
    return YES;
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
       [textView resignFirstResponder];
    
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    
    //    if(self.Addrexxtext.text.length == 0){
    //
    //        [self.Addrexxtext resignFirstResponder];
    //        self.BGview.hidden=YES;
    //    }
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    //    if([text isEqualToString:@"\n"]) {
    //        [self.FedbackTextView resignFirstResponder];
    //        return NO;
    //    }
    
    return YES;
}
//------------------------------------------------------------------------------------------//--------
#pragma mark - Chacklengthmethod
//---------------------------------------------------------------------------------------------------
-(BOOL)CheckEmail:(NSString*)text
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailValidation = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    if (![emailValidation evaluateWithObject:text]) {
        return NO;
    }
    return YES;
}



-(void)Getcategory:(id)response
{
    NSDictionary *responseDic=response;
    if ([response isKindOfClass:[NSDictionary class]]) {
        if ([[responseDic objectForKey:@"message"]isEqualToString:@"success"]) {
            
            
        }
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

- (IBAction)BackBtn:(id)sender {
     [self .navigationController popViewControllerAnimated:YES];
}
- (IBAction)ActionOnSend:(id)sender {
    
    
    WSOperationInEDUApp *ws=[[WSOperationInEDUApp alloc]initWithDelegate:self callback:@selector(Getcategory:)];
    [ws contact_request:self.NameTextFiled.text email:self.EmailTextFiled.text phone:self.PhoneTextFiled.text subject:self.SubjecttextFiled.text message:self.MessageTextView.text];
    
}
@end

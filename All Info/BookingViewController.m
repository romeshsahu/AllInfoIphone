//
//  BookingViewController.m
//  All Info
//
//  Created by iPhones on 6/28/16.
//  Copyright © 2016 PS.com. All rights reserved.
//

#import "BookingViewController.h"
#import "AppDelegate.h"
#import "WSOperationInEDUApp.h"
#import "AADatePicker.h"
@interface BookingViewController ()<AADatePickerDelegate>
{
    NSDateFormatter *formatter;
    UIDatePicker *datePicker;
    UIDatePicker *datePicker2;
    AADatePicker *Picker;
}
@property (retain) NSArray* textFields;
@end

@implementation BookingViewController
- (void)viewDidLayoutSubviews
{
    
    [ self.BookokingScroll setContentSize:CGSizeMake(320, 540)];
}
-(void)dateChanged:(AADatePicker *)sender
{
    NSString *dateString = [NSDateFormatter localizedStringFromDate:sender.date
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterMediumStyle];
   
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; // here
    [dateFormatter setDateFormat:@"dd-MM-yyyy,HH:mm:ss"]; //// here set format of d
    NSDate *date = [dateFormatter dateFromString: dateString];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *convertedString = [dateFormatter stringFromDate:date];
    NSLog(@"%@",dateString);
    self.TimeTextFiled.text=[NSString stringWithFormat:@"%@",convertedString];
    
    //[self.TimeTextFiled setText:dateString];
}
-(void)changeDateFromLabel:(id)sender
{
    NSDate *chosen = [Picker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    self.TimeTextFiled.text = [dateFormatter stringFromDate:chosen];
    Picker.delegate = self;
   [Picker removeFromSuperview];

}
- (void)viewDidLoad {
    [super viewDidLoad];
     [ self.BookokingScroll setContentSize:CGSizeMake(320, 540)];
      self.tabBarController.tabBar.hidden=NO;
   
    datePicker = [[UIDatePicker alloc]init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"he"];
    [datePicker setLocale:locale];
    [datePicker setDate:[NSDate date]];
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [self.DateTextFiled setInputView:datePicker];
    
    
//    datePicker2 = [[UIDatePicker alloc]init];
//    NSLocale *locale2 = [[NSLocale alloc] initWithLocaleIdentifier:@"he"];
//    [datePicker2 setLocale:locale2];
//    datePicker2.datePickerMode = UIDatePickerModeTime;
//    [datePicker2 setDate:[NSDate date]];
//    [datePicker2 addTarget:self action:@selector(updateTextField2:) forControlEvents:UIControlEventValueChanged];
//    [self.TimeTextFiled setInputView:datePicker2];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            Picker = [[AADatePicker alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, 210, self.view.frame.size.width, 200) maxDate:[NSDate dateWithTimeIntervalSinceNow:7*24*60*60] minDate:[NSDate date] showValidDatesOnly:NO];
            UIToolbar *toolBar= [[UIToolbar alloc] initWithFrame:CGRectMake(self.view.frame.origin.x,0,self.view.frame.size.width,44)];
            [toolBar setBarStyle:UIBarStyleBlackOpaque];
            UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                              style:UIBarButtonItemStyleBordered target:self action:@selector(changeDateFromLabel:)];
            toolBar.items = @[barButtonDone];
            barButtonDone.tintColor=[UIColor whiteColor];
            [Picker addSubview:toolBar];
            Picker.delegate = self;

        }
        if(result.height == 568)
        {
            Picker = [[AADatePicker alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, 325, self.view.frame.size.width, 200) maxDate:[NSDate dateWithTimeIntervalSinceNow:7*24*60*60] minDate:[NSDate date] showValidDatesOnly:NO];
            UIToolbar *toolBar= [[UIToolbar alloc] initWithFrame:CGRectMake(self.view.frame.origin.x,0,self.view.frame.size.width,44)];
            [toolBar setBarStyle:UIBarStyleBlackOpaque];
            UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                              style:UIBarButtonItemStyleBordered target:self action:@selector(changeDateFromLabel:)];
            toolBar.items = @[barButtonDone];
            barButtonDone.tintColor=[UIColor whiteColor];
            [Picker addSubview:toolBar];
            Picker.delegate = self;

            
        }
        if(result.height == 667)
            
        {
            
            Picker = [[AADatePicker alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, 400, self.view.frame.size.width, 200) maxDate:[NSDate dateWithTimeIntervalSinceNow:7*24*60*60] minDate:[NSDate date] showValidDatesOnly:NO];
            UIToolbar *toolBar= [[UIToolbar alloc] initWithFrame:CGRectMake(self.view.frame.origin.x,0,self.view.frame.size.width,44)];
            [toolBar setBarStyle:UIBarStyleBlackOpaque];
            UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                              style:UIBarButtonItemStyleBordered target:self action:@selector(changeDateFromLabel:)];
            toolBar.items = @[barButtonDone];
            barButtonDone.tintColor=[UIColor whiteColor];
            [Picker addSubview:toolBar];
            Picker.delegate = self;

        }
        
        
    }
       // [self.view addSubview:Picker];
    
   


    if ([self.NametextFiled respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor lightGrayColor];
        self.NametextFiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"NAME",nil) attributes:@{NSForegroundColorAttributeName: color}];
        self.DateTextFiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"DATE",nil) attributes:@{NSForegroundColorAttributeName: color}];
        self.TimeTextFiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"TIME",nil) attributes:@{NSForegroundColorAttributeName: color}];
        self.NoOfpeopleTextfiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"NUMBER OF PEOPLE",nil) attributes:@{NSForegroundColorAttributeName: color}];
        self.PhoneNoTextFiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"PHONE",nil) attributes:@{NSForegroundColorAttributeName: color}];
        self.PlaceholderLabel.text=NSLocalizedString(@"MESSAGE",nil);
        [self.BookBtnout setTitle:NSLocalizedString(@"BOOK A RESERVATION",nil) forState:UIControlStateNormal];
        
    }
    self.textFields = @[self.NametextFiled,
                        self.NoOfpeopleTextfiled,
                        self.MessageTextView,
                        self.PhoneNoTextFiled,
                        ];
    UIButton* done = [UIButton buttonWithType:UIButtonTypeCustom];
    done.bounds = CGRectMake(0, 0, 20, 32);
    done.backgroundColor = [UIColor darkGrayColor];
    [done setTitle:@"Done" forState:UIControlStateNormal];
    
    UIButton* done1 = [UIButton buttonWithType:UIButtonTypeCustom];
    done1.bounds = CGRectMake(0, 0, 20, 32);
    done1.backgroundColor = [UIColor darkGrayColor];
    [done1 setTitle:@"Done" forState:UIControlStateNormal];
    
    UIButton* done2 = [UIButton buttonWithType:UIButtonTypeCustom];
    done2.bounds = CGRectMake(0, 0, 20, 32);
    done2.backgroundColor = [UIColor darkGrayColor];
    [done2 setTitle:@"Done" forState:UIControlStateNormal];
    
    for(UITextField* textField in self.textFields)
    {
        [done addTarget:textField action:@selector(resignFirstResponder) forControlEvents:UIControlEventTouchUpInside];
        textField.inputAccessoryView = done;
    }
    
    
    
    [done1 addTarget:self action:@selector(dateResponder:) forControlEvents:UIControlEventTouchUpInside];
    self.DateTextFiled.inputAccessoryView = done1;
    
//    [done2 addTarget:self action:@selector(timeResponder:) forControlEvents:UIControlEventTouchUpInside];
//    self.TimeTextFiled.inputAccessoryView = done2;
    // }
}
- (BOOL)resignFirstResponder
{
    Picker.delegate = self;
    [Picker removeFromSuperview];
    return [super resignFirstResponder];
}
- (IBAction)dateResponder:(id)sender

{
    NSDate *chosen = [datePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    self.DateTextFiled.text = [dateFormatter stringFromDate:chosen];
    Picker.delegate = self;
    [Picker removeFromSuperview];
    [self.DateTextFiled resignFirstResponder];
    [self.NametextFiled resignFirstResponder];
    [self.TimeTextFiled resignFirstResponder];
    [self.NoOfpeopleTextfiled resignFirstResponder];
    [self.MessageTextView resignFirstResponder];
    [self.PhoneNoTextFiled resignFirstResponder];
    //return [super resignFirstResponder];
}

//- (IBAction)timeResponder:(id)sender
//
//{
//    NSDate *chosen = [datePicker2 date];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"mm:HH"];
//    self.TimeTextFiled.text = [dateFormatter stringFromDate:chosen];
//    
//    [self.DateTextFiled resignFirstResponder];
//    [self.NametextFiled resignFirstResponder];
//    [self.TimeTextFiled resignFirstResponder];
//    [self.NoOfpeopleTextfiled resignFirstResponder];
//    [self.MessageTextView resignFirstResponder];
//    [self.PhoneNoTextFiled resignFirstResponder];
//    //return [super resignFirstResponder];
//}
-(void)updateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.DateTextFiled.inputView;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    Picker.delegate = self;
    [Picker removeFromSuperview];
    // Convert to new Date Format
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    //NSString *newDate = [dateFormatter stringFromDate:dateFormatter];
    
    self.DateTextFiled.text = [dateFormatter stringFromDate:picker.date];
    //self.DateTextFiled.text = [NSString stringWithFormat:@"%@",picker.date];
}
/**
-(void)updateTextField:(UIDatePicker *)sender
{
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    
    // Convert to new Date Format
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    //NSString *newDate = [dateFormatter stringFromDate:dateFormatter];
    
    self.DateTextFiled.text = [dateFormatter stringFromDate:sender.date];
}
 **/
-(void)updateTextField2:(id)sender
{
    Picker.delegate = self;
    [Picker removeFromSuperview];
   UIDatePicker *picker = (UIDatePicker*)self.TimeTextFiled.inputView;
   NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // Convert to new Date Format
    [dateFormatter setDateFormat:@"HH:mm"];
    //NSString *newDate = [dateFormatter stringFromDate:dateFormatter];
    
   self.TimeTextFiled.text = [dateFormatter stringFromDate:picker.date];

}
-(void)add{
    if (self.DateTextFiled.inputView == nil)
    {
        Picker.delegate = self;
        [Picker removeFromSuperview];
        UIDatePicker *datePicker = [[UIDatePicker alloc] init];
        datePicker.datePickerMode = UIDatePickerModeDate;
        [datePicker addTarget:self action:@selector(updateTextField:)
             forControlEvents:UIControlEventValueChanged];
        [self.DateTextFiled setInputView:datePicker];
    }
}
-(void)add2{
    if (self.TimeTextFiled.inputView == nil)
    {
        Picker.delegate = self;
        [Picker removeFromSuperview];
        UIDatePicker *datePicker = [[UIDatePicker alloc] init];
        datePicker.datePickerMode = UIDatePickerModeTime;
        [datePicker addTarget:self action:@selector(updateTextField2:)
             forControlEvents:UIControlEventValueChanged];
        [self.TimeTextFiled setInputView:datePicker];
    }
}



#pragma mark - text field delegates
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==self.NametextFiled) {
        [self.DateTextFiled becomeFirstResponder];
    }else if (textField==self.DateTextFiled){
        [self.TimeTextFiled becomeFirstResponder];
    }else if (textField==self.TimeTextFiled){
        [self.NoOfpeopleTextfiled becomeFirstResponder];
    }else if (textField==self.NoOfpeopleTextfiled){
        [self.PhoneNoTextFiled becomeFirstResponder];
    }else if (textField==self.PhoneNoTextFiled){
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
    
    
    Picker.delegate = self;
    [Picker removeFromSuperview];
    if ([newString isEqualToString:@""]) {
        self.PlaceholderLabel.hidden = NO;
    }else if(newString.length>0){
        self.PlaceholderLabel.hidden = YES;
    }
    
    
    
    return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)ActionOnBookingbtn:(id)sender {
    Picker.delegate = self;
    [Picker removeFromSuperview];
    if (self.NametextFiled.text.length==0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Fill Name Field",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
        [alert show];
    }else if (self.DateTextFiled.text.length==0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Fill DATE Field",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
        [alert show];
    }else if (self.TimeTextFiled.text.length==0){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Fill Time Field",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
        [alert show];
    }else if (self.NoOfpeopleTextfiled.text.length==0){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Fill NUMBER OF PEOPLE Field",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
        [alert show];
    }else if (self.PhoneNoTextFiled.text.length==0){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Fill Phone number Field",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
        [alert show];
    }else if (self.MessageTextView.text.length==0){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Fill MESSAGE Field",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
        [alert show];
    }else{
        
        WSOperationInEDUApp *ws=[[WSOperationInEDUApp alloc]initWithDelegate:self callback:@selector(oderview:)];
        
        [ws oderResrvation:[self.BusinessDic objectForKey:@"user_id"] name:self.NametextFiled.text date:self.DateTextFiled.text time:self.TimeTextFiled.text phone:self.PhoneNoTextFiled.text no_of_people:self.NoOfpeopleTextfiled.text message:self.MessageTextView.text];
    }
    
    
}
-(void)oderview:(id)response
{
    NSDictionary *responseDic=response;
    if ([response isKindOfClass:[NSDictionary class]]) {
        if ([[responseDic objectForKey:@"message"]isEqualToString:@"success"]) {
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"no business email found",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
            [alert show];
        
        }
    }
}

-(NSString*)formatNumber:(NSString*)mobileNumber
{
    
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    NSLog(@"%@", mobileNumber);
    
    long int length = [mobileNumber length];
    if(length > 10)
    {
        mobileNumber = [mobileNumber substringFromIndex: length-10];
        NSLog(@"%@", mobileNumber);
        
    }
    
    
    return mobileNumber;
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

- (IBAction)AcTimebtn:(id)sender {
    [self.view addSubview:Picker];
    
}

- (IBAction)ActionOnback:(id)sender {
    [self .navigationController popViewControllerAnimated:YES];
}

- (IBAction)AdddatePickerBtn:(id)sender {
    [self.DateTextFiled resignFirstResponder];
    [self.NametextFiled resignFirstResponder];
    [self.TimeTextFiled resignFirstResponder];
    [self.NoOfpeopleTextfiled resignFirstResponder];
    [self.MessageTextView resignFirstResponder];
    [self.PhoneNoTextFiled resignFirstResponder];
    
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

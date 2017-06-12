//
//  BookingViewController.h
//  All Info
//
//  Created by iPhones on 6/28/16.
//  Copyright © 2016 PS.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookingViewController : UIViewController
- (IBAction)btn_Share:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *NametextFiled;
@property (weak, nonatomic) IBOutlet UITextField *DateTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *TimeTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *NoOfpeopleTextfiled;
@property (weak, nonatomic) IBOutlet UITextField *PhoneNoTextFiled;
@property (weak, nonatomic) IBOutlet UILabel *PlaceholderLabel;
@property (weak, nonatomic) IBOutlet UITextView *MessageTextView;
@property (strong, nonatomic) UILabel *dateLabel;
- (IBAction)ActionOnBookingbtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *BookBtnout;
- (IBAction)ActionOnHome:(id)sender;

- (IBAction)AcTimebtn:(id)sender;


- (IBAction)ActionOnback:(id)sender;
@property NSDictionary *BusinessDic;
- (IBAction)AdddatePickerBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *BookokingScroll;
@property (weak, nonatomic) IBOutlet UIDatePicker *showdatepicker;

@end

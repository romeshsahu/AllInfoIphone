//
//  LeavemessageViewController.h
//  All Info
//
//  Created by Mahendra Suryavanshi on 3/8/16.
//  Copyright © 2016 PS.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeavemessageViewController : UIViewController
- (IBAction)BackBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *NameTextFiled;
- (IBAction)ActionOnHome:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *LeveMesageLable;
@property (weak, nonatomic) IBOutlet UIScrollView *LeveScrollView;

@property (weak, nonatomic) IBOutlet UILabel *PlaceHoderLabel;
@property (weak, nonatomic) IBOutlet UITextField *EmailTextFiled;

@property (weak, nonatomic) IBOutlet UITextField *PhoneTextFiled;
@property (weak, nonatomic) IBOutlet UITextView *MessageTextview;
@property NSDictionary *Businesdic;
- (IBAction)ActionOnsend:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *SendbtnOut;
- (IBAction)btn_Share:(id)sender;

@end

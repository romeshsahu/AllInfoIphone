//
//  CallSendViewController.h
//  All Info
//
//  Created by Mahendra Suryavanshi on 3/5/16.
//  Copyright © 2016 PS.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CallSendViewController : UIViewController
- (IBAction)BackBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *NameTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *EmailTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *PhoneTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *SubjecttextFiled;
- (IBAction)ActionOnSend:(id)sender;
@property UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UITextView *MessageTextView;
@end

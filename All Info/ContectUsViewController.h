//
//  ContectUsViewController.h
//  All Info
//
//  Created by iPhones on 6/20/16.
//  Copyright © 2016 PS.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContectUsViewController : UIViewController

- (IBAction)ActionnSent:(id)sender;

@property (weak, nonatomic) IBOutlet UITextView *DescriptinTextView;
@property (weak, nonatomic) IBOutlet UILabel *plaseHoderlabel;
@property (weak, nonatomic) IBOutlet UITextField *Subjecttextview;
@property (weak, nonatomic) IBOutlet UITextField *phoneNotextfiled;

@property (weak, nonatomic) IBOutlet UITextField *EmailtextFiled;

@property (weak, nonatomic) IBOutlet UITextField *Nametextfiled;
@property (weak, nonatomic) IBOutlet UIScrollView *ContectScrollView;

- (IBAction)ActionOnHome:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *SentBtnout;

- (IBAction)ActionOnback:(id)sender;


@end

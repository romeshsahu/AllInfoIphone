//
//  WriteViewController.h
//  All Info
//
//  Created by iPhones on 5/4/16.
//  Copyright © 2016 PS.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RateView.h"
#import "IntrestCatViewController.h"

@interface WriteViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *commenttextview;

- (IBAction)ActionOnHome:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *WriteScrollView;

@property (weak, nonatomic) IBOutlet UILabel *placehoderLabel;

@property (weak, nonatomic) IBOutlet UITextField *usertextfiled;
- (IBAction)ActionOnAddComent:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *AddcomentBtn;

@property (weak, nonatomic) IBOutlet UILabel *CommentHeding;


@property (weak, nonatomic) IBOutlet UILabel *AddRatingLabel;


@property (weak, nonatomic) IBOutlet RateView *IBRaingView;

@property NSDictionary *Bussinedic;

@property BOOL iswrite;
- (IBAction)BackBtn:(id)sender;

- (IBAction)MenuBtn:(id)sender;
@end

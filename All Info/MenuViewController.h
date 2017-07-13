//
//  MenuViewController.h
//  All Info
//
//  Created by iPhones on 4/23/16.
//  Copyright © 2016 PS.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuViewController;

@protocol MenuViewControllerDelegates <NSObject>
-(void)PushViewControllersOnSelFView:(int)View;
@end

@interface MenuViewController : UIViewController

@property(strong,nonatomic) id <MenuViewControllerDelegates> delegate;
- (IBAction)ActionOnButtons:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *ReistratinBtnOut;

@property (weak, nonatomic) IBOutlet UIButton *ContectUsBtnOut;
@property (weak, nonatomic) IBOutlet UIButton *LogoutBtNOut;
@property (weak, nonatomic) IBOutlet UIButton *LoginBtnOut;

@property (weak, nonatomic) IBOutlet UIButton *HelpBtnOut;
@property (weak, nonatomic) IBOutlet UIButton *btnCategory;
@property (strong, nonatomic) IBOutlet UIButton *btn_Location;

@end

//
//  MenuViewController.m
//  All Info
//
//  Created by iPhones on 4/23/16.
//  Copyright © 2016 PS.com. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ///http://allinfo.co.il/all_info/webservice/master.php?action=location
    [self.ReistratinBtnOut setTitle:NSLocalizedString(@"Register",nil) forState:UIControlStateNormal];
    [self.ContectUsBtnOut setTitle:NSLocalizedString(@"Contact",nil) forState:UIControlStateNormal];
    [self.LogoutBtNOut setTitle:NSLocalizedString(@"Logout",nil) forState:UIControlStateNormal];
    [self.LoginBtnOut setTitle:NSLocalizedString(@"Login",nil) forState:UIControlStateNormal];
    [self.HelpBtnOut setTitle:NSLocalizedString(@"Help",nil) forState:UIControlStateNormal];
    [self.btnCategory setTitle:NSLocalizedString(@"Category",nil) forState:UIControlStateNormal];
    [self.btn_Location setTitle:NSLocalizedString(@"CurrentLocation",nil) forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    CATransition *transition = [CATransition animation];
    transition.duration = 1;
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromRight;
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.view.layer addAnimation:transition forKey:nil];
    [self.view performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.5];
    
}

- (IBAction)ActionOnButtons:(id)sender {
    UIButton *btn = (UIButton*)sender;
    NSLog(@"btn = %ld", (long)btn.tag);
    if ([self.delegate respondsToSelector:@selector(PushViewControllersOnSelFView:)]) {
        if(btn.tag == 0) {
                [self.delegate PushViewControllersOnSelFView:btn.tag + 8];
        } else {
            [self.delegate PushViewControllersOnSelFView:btn.tag];
        }
        
        
    }
}

@end









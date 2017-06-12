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

    [self.ReistratinBtnOut setTitle:NSLocalizedString(@"Register",nil) forState:UIControlStateNormal];
    [self.ContectUsBtnOut setTitle:NSLocalizedString(@"Contact",nil) forState:UIControlStateNormal];
    [self.LogoutBtNOut setTitle:NSLocalizedString(@"Logout",nil) forState:UIControlStateNormal];
    [self.LoginBtnOut setTitle:NSLocalizedString(@"Login",nil) forState:UIControlStateNormal];
    [self.HelpBtnOut setTitle:NSLocalizedString(@"Help",nil) forState:UIControlStateNormal];
 
//    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler)];
//    [self.view addGestureRecognizer:gestureRecognizer];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    
    CATransition *transition = [CATransition animation];
    transition.duration = 1;
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromRight;
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.view.layer addAnimation:transition forKey:nil];
    [self.view performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.5];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



-(void)swipeHandler{
    
}
- (IBAction)ActionOnButtons:(id)sender {
    UIButton *btn = (UIButton*)sender;
    if ([self.delegate respondsToSelector:@selector(PushViewControllersOnSelFView:)]) {
        [self.delegate PushViewControllersOnSelFView:btn.tag];
    }
}
@end

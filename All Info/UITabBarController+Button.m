//
//  UITabBarController+Button.m
//  AccaCombo
//
//  Created by iPhones on 2/15/16.
//  Copyright (c) 2016 Parkhya solutions. All rights reserved.
//

#import "UITabBarController+Button.h"
#import "AppDelegate.h"
#define kBUTTON_TAG   4096
@interface UITabBarController (Button) <UIActionSheetDelegate>

@end

@implementation UITabBarController (Button)


- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)replaceItemAtIndex:(NSUInteger)index withButtonImage:(UIImage*)buttonImage {
    
     UIButton *button = (UIButton *)[self.view viewWithTag:kBUTTON_TAG];
    
    if (!button) {
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = kBUTTON_TAG;
        [button setImage:buttonImage forState:UIControlStateNormal];
        //[button setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        UITabBar *bar = self.tabBar;
        CGFloat width = bar.frame.size.width / bar.items.count;
        button.frame = CGRectMake(index*width, bar.frame.origin.y, width, bar.frame.size.height);
        [button setImageEdgeInsets:UIEdgeInsetsMake(5, 10, 15, 10)];
        [self.view addSubview:button];
    }
}

#pragma mark - Handle button tap

- (void)buttonTapped:(id)sender {
    
    UIButton *btn = (UIButton*)sender;
    
    if (btn.isSelected) {
        btn.selected = NO;
       //[[AppDelegate sharedInstance].popupView removeFromSuperview];
    }else{
       // [self.view addSubview:[AppDelegate sharedInstance].popupView];
        btn.selected = YES;
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


- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
   // NSLog(@"tab selected: %@", item.title);
   // [[AppDelegate sharedInstance].popupView removeFromSuperview];
  //  [AppDelegate sharedInstance].button.selected = NO;
}
@end

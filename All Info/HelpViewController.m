//
//  HelpViewController.m
//  All Info
//
//  Created by iPhones on 6/27/16.
//  Copyright © 2016 PS.com. All rights reserved.
//

#import "HelpViewController.h"
#import "AppDelegate.h"
#import "MenuViewController.h"

@interface HelpViewController ()<MenuViewControllerDelegates,UITextFieldDelegate>

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden=YES;
    NSString *urlString = @"http://allinfo.co.il/help";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.WebView loadRequest:urlRequest];
    // Do any additional setup after loading the view.
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

- (IBAction)ActionOnBack:(id)sender {
     [self .navigationController popViewControllerAnimated:YES];
}

- (IBAction)ActionoNHome:(id)sender {
    UIStoryboard *MainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    UINavigationController *controller = (UINavigationController*)[MainStoryboard
                                                                   instantiateViewControllerWithIdentifier: @"RootNavigationController"];
     UITabBarController *tabar = controller.viewControllers[0];
    [tabar setSelectedIndex:3];
    [AppDelegate SharedInstance].window.rootViewController=controller;
    [[AppDelegate SharedInstance].window makeKeyAndVisible];

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

//
//  HelpViewController.h
//  All Info
//
//  Created by iPhones on 6/27/16.
//  Copyright © 2016 PS.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpViewController : UIViewController
- (IBAction)ActionOnBack:(id)sender;
- (IBAction)ActionoNHome:(id)sender;
- (IBAction)btn_Share:(id)sender;

@property (weak, nonatomic) IBOutlet UIWebView *WebView;
@end

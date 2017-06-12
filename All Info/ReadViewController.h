//
//  ReadViewController.h
//  All Info
//
//  Created by iPhones on 6/27/16.
//  Copyright © 2016 PS.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReadViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *ReadTabelView;
- (IBAction)ActionOnBack:(id)sender;
- (IBAction)ActionOnHome:(id)sender;
@property bool isserchsetview;
@property NSDictionary *BusinessDic;
- (IBAction)btn_Share:(id)sender;

@end

//
//  HistoryViewController.h
//  All Info
//
//  Created by iPhones on 4/23/16.
//  Copyright © 2016 Parkhya solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntrestCatViewController.h"

@interface HistoryViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *HistoryTableView;
- (IBAction)ActionOnHome:(id)sender;

- (IBAction)ActionOnhome:(id)sender;

- (IBAction)ActionOnmenu:(id)sender;
- (IBAction)ActionONBack:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *HistHedinLabel;
- (IBAction)btn_Share:(id)sender;

@end

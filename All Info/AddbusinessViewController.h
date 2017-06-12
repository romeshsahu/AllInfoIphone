//
//  AddbusinessViewController.h
//  All Info
//
//  Created by iPhones on 5/4/16.
//  Copyright © 2016 PS.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MNMBottomPullToRefreshView.h"
#import "MNMBottomPullToRefreshManager.h"
@interface AddbusinessViewController : UIViewController<MNMBottomPullToRefreshManagerClient>
{
@private
    MNMBottomPullToRefreshManager *pullToRefreshManager_;
    NSUInteger reloads_;
}
@property (weak, nonatomic) IBOutlet UITableView *addbusinestableview;
- (IBAction)addbusinsAction:(id)sender;

- (IBAction)actionOnbackBtn:(id)sender;

- (IBAction)ActioNoNhome:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *MyHaedingLabel;
- (IBAction)btn_Share:(id)sender;

@end

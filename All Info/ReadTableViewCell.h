//
//  ReadTableViewCell.h
//  All Info
//
//  Created by iPhones on 6/27/16.
//  Copyright © 2016 PS.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RateView.h"

@interface ReadTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *CommentLabel;
@property (weak, nonatomic) IBOutlet UILabel *DateLabel;
@property (weak, nonatomic) IBOutlet RateView *IBRaingView;

@end

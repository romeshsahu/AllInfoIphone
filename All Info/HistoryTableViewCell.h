//
//  HistoryTableViewCell.h
//  All Info
//
//  Created by iPhones on 5/3/16.
//  Copyright © 2016 PS.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbl_Status;

@property (weak, nonatomic) IBOutlet UIImageView *histimgesview;

@property (weak, nonatomic) IBOutlet UILabel *businesnamelab;

@property (weak, nonatomic) IBOutlet UILabel *destancelabel;
@end

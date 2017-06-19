//
//  SubCategiryViewController.h
//  All Info
//
//  Created by Mahendra Suryavanshi on 3/5/16.
//  Copyright © 2016 PS.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntrestCatViewController.h"

@interface SubCategiryViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>
@property NSMutableArray *getsubArr;
@property NSString *catgeryName;
@property (weak, nonatomic) IBOutlet UICollectionView *SubCollectionview;
- (IBAction)ActionOnmenu:(id)sender;
- (IBAction)ActionOnHome:(id)sender;
@property bool isserchsetview;

@property (weak, nonatomic) IBOutlet UILabel *TitalLabel;
- (IBAction)BackBtn:(id)sender;
- (IBAction)btn_Share:(id)sender;

@end

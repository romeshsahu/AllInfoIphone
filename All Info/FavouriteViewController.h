//
//  FavouriteViewController.h
//  All Info
//
//  Created by iPhones on 4/23/16.
//  Copyright © 2016 Parkhya solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntrestCatViewController.h"

@interface FavouriteViewController : UIViewController <UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *favitarateCollectionView;
- (IBAction)ActionOnHome:(id)sender;

- (IBAction)ActionOnback:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *HedingFaveratealbel;

@end

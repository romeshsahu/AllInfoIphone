//
//  ModulViewController.h
//  All Info
//
//  Created by iPhones on 4/23/16.
//  Copyright © 2016 Parkhya solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#import "IntrestCatViewController.h"


@interface ModulViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>
- (IBAction)ActionONBack:(id)sender;

- (IBAction)btn_Share:(id)sender;

- (IBAction)actiononserch:(id)sender;



@property (weak, nonatomic) IBOutlet UICollectionView *HomeCollectionView;

- (IBAction)ActionOnmenuBtn:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *searchFiled;


@end

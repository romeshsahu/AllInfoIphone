//
//  ViewController.h
//  All Info
//
//  Created by Mahendra Suryavanshi on 3/3/16.
//  Copyright © 2016 PS.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntrestCatViewController.h"

@interface ViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>

- (IBAction)actiononserch:(id)sender;
- (IBAction)ActionOnback:(id)sender;


@property (weak, nonatomic) IBOutlet UICollectionView *HomeCollectionView;

- (IBAction)ActionOnmenuBtn:(id)sender;

@property (retain, nonatomic) NSURLConnection *connection;
@property (retain, nonatomic) NSMutableData *receivedData;
@property (weak, nonatomic) IBOutlet UITextField *searchFiled;

- (IBAction)ActionOnRegistation:(id)sender;
- (IBAction)ActionOncallView:(id)sender;
- (IBAction)LoginBtn:(id)sender;

@end


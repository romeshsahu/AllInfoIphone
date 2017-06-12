//
//  SlideImagesViewController.h
//  All Info
//
//  Created by iPhones on 6/22/16.
//  Copyright © 2016 PS.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideImagesViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *HomeScrollView;
@property NSMutableArray *Imagearr;
@property int Tag;
- (IBAction)ActionOnback:(id)sender;


@end

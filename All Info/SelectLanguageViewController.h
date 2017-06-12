//
//  SelectLanguageViewController.h
//  All Info
//
//  Created by iPhones on 5/12/16.
//  Copyright © 2016 PS.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectLanguageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *LanguageTableView;


@end

//
//  SelectLanguageViewController.m
//  All Info
//
//  Created by iPhones on 5/12/16.
//  Copyright © 2016 PS.com. All rights reserved.
//

#import "SelectLanguageViewController.h"
#import "LanguageTableViewCell.h"
#import "WSOperationInEDUApp.h"
#import "BundleLocalization.h"

@interface SelectLanguageViewController ()
{
    NSMutableArray *languageArr;
}

@end

@implementation SelectLanguageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[[NSUserDefaults standardUserDefaults]objectForKey: NSLocalizedString(@"selecttlanguage",nil)]isEqualToString:NSLocalizedString(@"Yes",nil)]) {
    
    [self performSegueWithIdentifier:@"Home" sender:self];
    
    }
   languageArr= [NSMutableArray arrayWithObjects:@"English language",@"Russian language",@"Hebrew language",@"Arabic language",nil];;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"celllanguge";
    LanguageTableViewCell *cell = (LanguageTableViewCell*)[self.LanguageTableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[LanguageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }

   
    cell.languageLabel.text =NSLocalizedString([languageArr objectAtIndex:indexPath.row],nil);

    return  cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return languageArr.count;
}

#pragma mark - UITableView Delegates

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [[BundleLocalization sharedInstance] setLanguage:@"en"];
            [[NSUserDefaults standardUserDefaults] setInteger:indexPath.row forKey:@"SelectedLanguage"];
            [self.self.LanguageTableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
           
            break;
        case 1:
            [[BundleLocalization sharedInstance] setLanguage:@"ru"];
            [[NSUserDefaults standardUserDefaults] setInteger:indexPath.row forKey:@"SelectedLanguage"];
            
            [self.LanguageTableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
            
            break;
        case 2:
            [[BundleLocalization sharedInstance] setLanguage:@"he"];
            [[NSUserDefaults standardUserDefaults] setInteger:indexPath.row forKey:@"SelectedLanguage"];
            
            [self.LanguageTableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
        
            
            break;
        case 3:
            [[BundleLocalization sharedInstance] setLanguage:@"ar"];
            [[NSUserDefaults standardUserDefaults] setInteger:indexPath.row forKey:@"SelectedLanguage"];
            
            [self.LanguageTableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
            
            

            break;
        default:
            break;
            
    }
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.LanguageTableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
    [self.LanguageTableView reloadData];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

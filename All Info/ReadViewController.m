//
//  ReadViewController.m
//  All Info
//
//  Created by iPhones on 6/27/16.
//  Copyright © 2016 PS.com. All rights reserved.
//

#import "ReadViewController.h"
#import "SDWebImageCompat.h"
#import "WSOperationInEDUApp.h"
#import "ReadTableViewCell.h"
#import "AppDelegate.h"
@interface ReadViewController ()
{
    NSMutableArray *readarr;
}

@end

@implementation ReadViewController
//-(void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    if (self.isserchsetview==true) {
//        
//        self.isserchsetview=false;
//        
//    }else{
//        
//        [self.tabBarController setSelectedIndex:0];
//        [self.navigationController popToRootViewControllerAnimated:YES];
//        
//    }
//    
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    readarr=[[NSMutableArray alloc]init];
     WSOperationInEDUApp *ws=[[WSOperationInEDUApp alloc]initWithDelegate:self callback:@selector(ReadBtn:)];
    [ws readReview:[self.BusinessDic objectForKey:@"user_id"]];
   
    
     //[ws addbusinessList:[UserDict objectForKey:@"login_id"]];
    
}
-(void)ReadBtn:(id)response
{
    NSDictionary *responseDic=response;
    if ([response isKindOfClass:[NSDictionary class]]) {
        if ([[responseDic objectForKey:@"message"]isEqualToString:@"success"]) {
            readarr=[responseDic objectForKey:@"result"];
            [self.ReadTabelView reloadData];
        }
        
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReadTableViewCell *cell = (ReadTableViewCell *)[self.ReadTabelView dequeueReusableCellWithIdentifier:@"Readcell"];
    NSString* strUnicodeString=[readarr objectAtIndex:indexPath.row][@"comment"];
    NSString* strUniname=[readarr objectAtIndex:indexPath.row][@"name"];
   // NSString *strUniname = [s stringByReplacingOccurrencesOfString:@"\\" withString:@"\"];
    
    NSString* strcreate_date=[readarr objectAtIndex:indexPath.row][@"create_date"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; // here
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; //// here set format of d
    NSDate *date = [dateFormatter dateFromString: strcreate_date];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *convertedString = [dateFormatter stringFromDate:date];
    NSString* strreview_id=[readarr objectAtIndex:indexPath.row][@"rating"];
    if ([strreview_id isEqual:[NSNull null]]) {
        strreview_id=@"";
    }else if ([strreview_id isEqual:@""]) {
        strreview_id=@"";
    }else if (strreview_id==nil) {
        strreview_id=@"";
    }
    int valus=[strreview_id intValue];
    if ([strUniname canBeConvertedToEncoding:NSASCIIStringEncoding]){
        NSData *data = [strUniname dataUsingEncoding:NSUTF8StringEncoding];
        NSString *string = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding];
        cell.NameLabel.text=[NSString stringWithFormat:@"%@",string];
        
    }else{
        cell.NameLabel.text=[NSString stringWithFormat:@"%@",strUniname];
    }
    if ([strUnicodeString canBeConvertedToEncoding:NSASCIIStringEncoding]){
        NSData *data = [strUnicodeString dataUsingEncoding:NSUTF8StringEncoding];
        NSString *string = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding];
        cell.CommentLabel.text=[NSString stringWithFormat:@"%@",string];
        
    }else{
        cell.CommentLabel.text=[NSString stringWithFormat:@"%@",strUnicodeString];
    }
    
    if ([convertedString canBeConvertedToEncoding:NSASCIIStringEncoding]){
        NSData *data = [convertedString dataUsingEncoding:NSUTF8StringEncoding];
        NSString *string = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding];
        cell.DateLabel.text=[NSString stringWithFormat:@"%@",string];
        
    }else{
        cell.DateLabel.text=[NSString stringWithFormat:@"%@",convertedString];
    }
    cell.IBRaingView.notSelectedImage = [UIImage imageNamed:@"star_blank.png"];
    cell.IBRaingView.fullSelectedImage = [UIImage imageNamed:@"star_fill.png"];
    cell.IBRaingView.rating = valus;
    //cell.IBRaingView.editable = NO;plain-star-2.png
    cell.IBRaingView.maxRating = 5;
    //cell.IBRaingView.delegate = self;
   
    return  cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return readarr.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath: (NSIndexPath *)indexPath
{
    static ReadTableViewCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.ReadTabelView  dequeueReusableCellWithIdentifier:@"Readcell"];
    });
    
    NSString* strUnicodeString=[readarr objectAtIndex:indexPath.row][@"comment"];
    NSString* s=[readarr objectAtIndex:indexPath.row][@"name"];
    NSString *strUniname = [s stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    NSString* strcreate_date=[readarr objectAtIndex:indexPath.row][@"create_date"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; // here
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; //// here set format of d
    NSDate *date = [dateFormatter dateFromString: strcreate_date];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *convertedString = [dateFormatter stringFromDate:date];
    NSString* strreview_id=[readarr objectAtIndex:indexPath.row][@"rating"];
    if ([strreview_id isEqual:[NSNull null]]) {
        strreview_id=@"";
    }else if ([strreview_id isEqual:@""]) {
        strreview_id=@"";
    }else if (strreview_id==nil) {
        strreview_id=@"";
    }
    int valus=[strreview_id intValue];
    if ([strUniname canBeConvertedToEncoding:NSASCIIStringEncoding]){
        NSData *data = [strUniname dataUsingEncoding:NSUTF8StringEncoding];
        NSString *string = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding];
        sizingCell.NameLabel.text=[NSString stringWithFormat:@"%@",string];
        
    }else{
        sizingCell.NameLabel.text=[NSString stringWithFormat:@"%@",strUniname];
    }
    if ([strUnicodeString canBeConvertedToEncoding:NSASCIIStringEncoding]){
        NSData *data = [strUnicodeString dataUsingEncoding:NSUTF8StringEncoding];
        NSString *string = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding];
        sizingCell.CommentLabel.text=[NSString stringWithFormat:@"%@",string];
        
    }else{
        sizingCell.CommentLabel.text=[NSString stringWithFormat:@"%@",strUnicodeString];
    }
    
    if ([convertedString canBeConvertedToEncoding:NSASCIIStringEncoding]){
        NSData *data = [convertedString dataUsingEncoding:NSUTF8StringEncoding];
        NSString *string = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding];
        sizingCell.DateLabel.text=[NSString stringWithFormat:@"%@",string];
        
    }else{
        sizingCell.DateLabel.text=[NSString stringWithFormat:@"%@",convertedString];
    }
    
    //sizingCell.NameLabel.text=[readarr objectAtIndex:indexPath.row][@"name"];;
   // sizingCell.CommentLabel.text=[readarr objectAtIndex:indexPath.row][@"comment"];;
    //sizingCell.DateLabel.text=[readarr objectAtIndex:indexPath.row][@"create_date"];;
    
    CGFloat fixedWidth = sizingCell.NameLabel.frame.size.width;
    CGFloat fixedWidth2 = sizingCell.CommentLabel.frame.size.width;
    CGFloat fixedWidth3= sizingCell.DateLabel.frame.size.width;
    CGSize newSize = [sizingCell.NameLabel     sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    CGSize newSize2 = [sizingCell.CommentLabel     sizeThatFits:CGSizeMake(fixedWidth2, MAXFLOAT)];
    CGSize newSize3 = [sizingCell.DateLabel     sizeThatFits:CGSizeMake(fixedWidth3, MAXFLOAT)];
    CGRect newFrame = sizingCell.NameLabel.frame;
    CGRect newFrame2 = sizingCell.CommentLabel.frame;
    CGRect newFrame3 = sizingCell.DateLabel.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    newFrame2.size = CGSizeMake(fmaxf(newSize2.width, fixedWidth), newSize2.height);
    newFrame3.size = CGSizeMake(fmaxf(newSize3.width, fixedWidth), newSize3.height);
    CGFloat height= newFrame.size.height;
    CGFloat height2= newFrame2.size.height;
    CGFloat height3= newFrame3.size.height;
    
    
    
    NSLog(@"%f is height ",height);
    return height+height2+height3+90.0f;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)ActionOnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)ActionOnHome:(id)sender {
    
    UIStoryboard *MainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    UINavigationController *controller = (UINavigationController*)[MainStoryboard
                                                                   instantiateViewControllerWithIdentifier: @"RootNavigationController"];
    
    
    UITabBarController *tabar = controller.viewControllers[0];
    [tabar setSelectedIndex:3];
    
    [AppDelegate SharedInstance].window.rootViewController=controller;
    [[AppDelegate SharedInstance].window makeKeyAndVisible];
}
- (IBAction)btn_Share:(id)sender {
    NSString *textToShare = @"Share link using";
    NSURL *myWebsite = [NSURL URLWithString:kAppDelegate.strShareLink];
    
    NSArray *objectsToShare = @[textToShare, myWebsite];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    NSArray *excludeActivities = @[UIActivityTypeAirDrop,
                                   UIActivityTypePrint,
                                   UIActivityTypeAssignToContact,
                                   UIActivityTypeSaveToCameraRoll,
                                   UIActivityTypeAddToReadingList,
                                   UIActivityTypePostToFlickr,
                                   UIActivityTypePostToVimeo];
    
    activityVC.excludedActivityTypes = excludeActivities;
    
    [self presentViewController:activityVC animated:YES completion:nil];
}
@end

//
//  BusinessdetailsViewController.m
//  All Info
//
//  Created by Mahendra Suryavanshi on 3/7/16.
//  Copyright © 2016 PS.com. All rights reserved.
//

#import "BusinessdetailsViewController.h"
#import "HomeCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "AllImgesViewController.h"
#import "FMDBManager.h"
#import "LeavemessageViewController.h"
#import "MenuViewController.h"
#import "RegistrationViewController.h"
#import "LoginViewController.h"
#import "AddbusinessViewController.h"
#import "WriteViewController.h"
#import "BundleLocalization.h"
#import "SlideImagesViewController.h"
#import "WSOperationInEDUApp.h"
#import "AppDelegate.h"
#import "HelpViewController.h"
#import "ReadViewController.h"
#import "BookingViewController.h"
#import "ContectUsViewController.h"
#import "LocationViewController.h"

@interface BusinessdetailsViewController ()<MenuViewControllerDelegates>
{
    NSMutableArray *imgarr;
    NSDictionary *ImgDic;
    UIAlertView *calert;
    NSString*Userlat;
    NSString*Userlong;
    NSMutableDictionary *bdic;
    MenuViewController * sample;
    CLLocationManager *locationManager;
    NSMutableArray *ImageArr;
    int tag;
    NSString *FbUrlstring;
    NSString *VideoUrlstring;
    NSString *website_urlstring;
    NSString *Rating;
    int value;
    NSString *catname;
    NSString *setwsLat;
    NSString *setwsLong;
    
    NSString*strLink;
    NSDictionary *UserDict;

}

@end
NSString *kID = @"BussnessCell";
@implementation BusinessdetailsViewController

@synthesize  Starimg1, Starimg2, Starimg3, Starimg4, Starimg5, lbl_Status, lbl_Status1;


bool isbusiness = false;
- (void)viewDidLayoutSubviews
{
    
    [ self.BusinesScrollView setContentSize:CGSizeMake(320, 960)];
}
- (void)viewDidLoad {
    [super viewDidLoad];
 

    
}
-(void)Get_share_page:(id)response
{
    @try {
        NSDictionary *responseDic=response;
        if ([response isKindOfClass:[NSDictionary class]]) {
            if ([[responseDic objectForKey:@"message"]isEqualToString:@"success"]) {
                strLink=[responseDic objectForKey:@"url"];
                NSLog(@"strLink in api.....%@",strLink);
            }
        }
        
    } @catch (NSException *exception) {
        NSLog(@"exception....%@",exception);
    }
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [super viewWillAppear:YES];
    
    UserDict =[[NSUserDefaults standardUserDefaults] objectForKey:@"userdata"];

  //  WSOperationInEDUApp *ws=[[WSOperationInEDUApp alloc]initWithDelegate:self callback:@selector(Get_share_page:)];
  //  [ws share_page_user_id:[bdic objectForKey:@"user_id"]];
    
    self.tabBarController.tabBar.hidden=NO;
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
    [ self.BusinesScrollView setContentSize:CGSizeMake(320, 960)];
    bdic=[[NSMutableDictionary alloc]init];
    self.tabBarController.tabBar.hidden=NO;
    bdic = [self.getBussnessDic mutableCopy];
    
    WSOperationInEDUApp *ws=[[WSOperationInEDUApp alloc]initWithDelegate:self callback:@selector(Get_share_page:)];
    [ws share_page_user_id:[bdic objectForKey:@"user_id"]];
    
    NSLog(@"bdic = %@", bdic);
    NSLog(@"user_id = %@", [bdic objectForKey:@"user_id"]);
    
    Rating=[bdic objectForKey:@"rating"];
    value = [Rating intValue];
    setwsLat= [[NSString alloc] initWithFormat: @"%@", [bdic objectForKey:@"latitude"]];
    setwsLong= [[NSString alloc] initWithFormat: @"%@", [bdic objectForKey:@"longitude"]];
    
    
    if(bdic[@"is_open"] != nil) {
        if([bdic[@"is_open"] intValue] == 2) {
            lbl_Status.text = NSLocalizedString(@"Close",nil);//@"closed";
            lbl_Status1.text = NSLocalizedString(@"Close",nil);
        } else {
            lbl_Status.text = @"";
            lbl_Status1.text = @"";
        }
    } else {
        lbl_Status.text = @"";
        lbl_Status1.text = @"";
    }
    
    
    
    if([bdic[@"parking_avail"] intValue] == 1) {
        [self.imgView_Parking setHidden:NO];
    } else if([bdic[@"parking_avail"] intValue] == 2){
        [self.imgView_Parking setHidden:YES];
    }
    
    if([bdic[@"public_access"] intValue] == 1) {
        [self.imgView_People setHidden:NO];
    } else if([bdic[@"public_access"] intValue] == 2){
        [self.imgView_People setHidden:YES];
    }
    
    NSString * strTUrl = self.getBussnessDic[@"table_reservation_url"];
    NSString * strMUrl = self.getBussnessDic[@"menu_url"];
    
    if(strTUrl.length > 0) {
        [self.btn_TableUrl setBackgroundImage:[UIImage imageNamed:@"table1.png"] forState:UIControlStateNormal];
    } else {
        [self.btn_TableUrl setBackgroundImage:[UIImage imageNamed:@"table_disable.jpg"] forState:UIControlStateNormal];
    }
    
    if(strMUrl.length > 0) {
        [self.btn_MenuUrl setBackgroundImage:[UIImage imageNamed:@"menu1.png"] forState:UIControlStateNormal];
    } else {
        [self.btn_MenuUrl setBackgroundImage:[UIImage imageNamed:@"menu_disable.jpg"] forState:UIControlStateNormal];
    }
    
    NSString *cat = [[NSString alloc] initWithFormat: @"%@", [bdic objectForKey:@"category_name"]];
    if ([cat canBeConvertedToEncoding:NSASCIIStringEncoding]){
        NSData *data = [cat dataUsingEncoding:NSUTF8StringEncoding];
        NSString *string = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding];
       catname=[NSString stringWithFormat:@"%@",string];
    }else{
       catname=[NSString stringWithFormat:@"%@",cat];
    }
    if ([catname rangeOfString:NSLocalizedString(@"Restaurants and cafes",nil)].location != NSNotFound){
        self.OderBtnOut.hidden=NO;
    }else if([catname rangeOfString:NSLocalizedString(@"cafes",nil)].location != NSNotFound){
        self.OderBtnOut.hidden=NO;
    }else if([catname rangeOfString:NSLocalizedString(@"Restaurants",nil)].location != NSNotFound){
        self.OderBtnOut.hidden=NO;
    }else if([catname rangeOfString:NSLocalizedString(@"Restaurantes y cafés",nil)].location != NSNotFound){
        self.OderBtnOut.hidden=NO;
    }else{
        self.OderBtnOut.hidden=NO;
    }
    
    if ([cat containsString:@"מסעדות"]) {
        self.viewThreebtn.hidden=false;
        _ViewWatchVideo.frame = CGRectMake( _ViewWatchVideo.frame.origin.x, _ViewWatchVideo.frame.origin.y, _ViewWatchVideo.frame.size.width, _ViewWatchVideo.frame.size.height);
    }
    else
    {
        self.viewThreebtn.hidden=true;
        _ViewWatchVideo.frame = CGRectMake( _ViewWatchVideo.frame.origin.x, _ViewWatchVideo.frame.origin.y-self.viewThreebtn.frame.size.height, _ViewWatchVideo.frame.size.width, _ViewWatchVideo.frame.size.height);
    }
    

    
    [self setRatingView1];
    FMDBManager *fm = [[FMDBManager alloc] init];
    [fm openDataBase];
    NSString *like = [fm likeststus:[bdic objectForKey:@"user_id"]];;
    if ([like isEqualToString:@"unlike"]) {
        
        self.changeimageview.image=[UIImage imageNamed:@"favorite_icons_wid_blk_hrt.png"];
        [self.LinkBtn setSelected:NO];
        
    }else{
        self.changeimageview.image=[UIImage imageNamed:@"favorite_icons_widout_blk_hrt.png"];
        [self.LinkBtn setSelected:YES];

    }
    ///category_name
    //BusnessnameLabel
    NSString *distanceString = [[NSString alloc] initWithFormat: @"%@", [bdic objectForKey:@"distance"]];
    NSString *strBusnessname = [self.getBussnessDic objectForKey:@"business_name"];
    NSString *strdescription = [NSString stringWithFormat:@"%@",[self.getBussnessDic objectForKey:@"description"]];
    NSString *strtimeLabel = [self.getBussnessDic objectForKey:@"start_time"];
    NSString *strUnicodeString = [self.getBussnessDic objectForKey:@"address"];
   ///
    
    if ([strBusnessname canBeConvertedToEncoding:NSASCIIStringEncoding]){
        NSData *data = [strBusnessname dataUsingEncoding:NSUTF8StringEncoding];
        NSString *string = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding];
        self.BusnessnameLabel.text=[NSString stringWithFormat:@"%@",string];
        
    }else{
        self.BusnessnameLabel.text=[NSString stringWithFormat:@"%@",strBusnessname];
    }
    ///
    if ([strdescription canBeConvertedToEncoding:NSASCIIStringEncoding]){
        NSData *data = [strdescription dataUsingEncoding:NSUTF8StringEncoding];
        NSString *string = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding];
        self.DetailsTextView.text=[NSString stringWithFormat:@"%@",string];
        
    }else{
       self.DetailsTextView.text=[NSString stringWithFormat:@"%@",strdescription];
    }
   // NSString *s = [strtimeLabel stringByReplacingOccurrencesOfString:@"" withString:@""];
    NSString *s = [strtimeLabel stringByReplacingOccurrencesOfString:@"\\n" withString:@""];
    NSString *s2 = [s stringByReplacingOccurrencesOfString:@"\\r" withString:@""];
    NSString *trimmed = [s2 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if ([trimmed canBeConvertedToEncoding:NSASCIIStringEncoding]){
        NSData *data = [strtimeLabel dataUsingEncoding:NSUTF8StringEncoding];
        NSString *string = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding];
        
        if (string == nil)
        {  self.start_timeLabel.text=@"";            //do something when value is null
        }else{
          self.start_timeLabel.text=[NSString stringWithFormat:@"%@",string];
        }
        
    }else{
        self.start_timeLabel.text=[NSString stringWithFormat:@"%@",trimmed];
    }
    ///
    if ([strUnicodeString canBeConvertedToEncoding:NSASCIIStringEncoding]){
        NSData *data = [strUnicodeString dataUsingEncoding:NSUTF8StringEncoding];
        NSString *string = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding];
        self.AddressLabel.text=[NSString stringWithFormat:@"%@",string];
        
    }else{
        self.AddressLabel.text=[NSString stringWithFormat:@"%@",strUnicodeString];
    }
    float your_float = [distanceString floatValue];
    NSLog(@"float value is: %.1f km", your_float);
    NSString *fString = [NSString stringWithFormat:@"%.1f km", your_float];
    self.DistanceLabel.text=[NSString stringWithFormat:@"%@",fString];
    self.placehoderLabel.hidden = YES;
    
    
    NSString* fbu =[[NSString alloc] initWithFormat: @"%@", [bdic objectForKey:@"facebook_url"]];
    if ([fbu isEqual:[NSNull null]]) {
        fbu=@"";
    }else if ([fbu isEqual:@""]) {
        fbu=@"";
    }else if(fbu == nil){
        fbu=@"";
    }else{
        
        if ([fbu canBeConvertedToEncoding:NSASCIIStringEncoding]){
            NSData *data = [fbu dataUsingEncoding:NSUTF8StringEncoding];
            NSString *string = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding];
             FbUrlstring=[NSString stringWithFormat:@"%@",string];
            
        }else{
             FbUrlstring=[NSString stringWithFormat:@"%@",fbu];
        }
    }

    NSString* web =[[NSString alloc] initWithFormat: @"%@", [bdic objectForKey:@"website_url"]];
    if ([web isEqual:[NSNull null]]) {
        web=@"";
    }else if ([web isEqual:@""]) {
        web=@"";
    }else if(web == nil){
        web=@"";
    }else{
        
        if ([web canBeConvertedToEncoding:NSASCIIStringEncoding]){
            NSData *data = [web dataUsingEncoding:NSUTF8StringEncoding];
            NSString *string = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding];
            website_urlstring=[NSString stringWithFormat:@"%@",string];
            
        }else{
             website_urlstring=[NSString stringWithFormat:@"%@",web];
        }
    }
    
    NSString* video =[[NSString alloc] initWithFormat: @"%@", [bdic objectForKey:@"video_url"]];
    if ([video isEqual:[NSNull null]]) {
        video=@"";
    }else if ([video isEqual:@""]) {
        video=@"";
    }else if(video == nil){
        video=@"";
    }else{
        
        if ([video canBeConvertedToEncoding:NSASCIIStringEncoding]){
            NSData *data = [video dataUsingEncoding:NSUTF8StringEncoding];
            NSString *string = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding];
            VideoUrlstring=[NSString stringWithFormat:@"%@",string];
            
        }else{
            VideoUrlstring=[NSString stringWithFormat:@"%@",video];
        }
    }

    
       //address
    self.PhoneNoLabel.text=[NSString stringWithFormat:@"%@",[bdic objectForKey:@"phone"]];
    self.DetailsTextView.textColor=[UIColor whiteColor];
   [self.DetailsTextView setFont:[UIFont systemFontOfSize:16]];
    self.DetailsTextView.textAlignment=NSTextAlignmentRight;;
    
    ///localzation
    self.ReadLabel.text = NSLocalizedString(@"READ Review",nil);
    self.BusinesshoursLabel.text = NSLocalizedString(@"Business hours",nil);
    self. WrightLabel.text = NSLocalizedString(@"Wright Review",nil);
    [self.VisitBtn setTitle:NSLocalizedString(@"VISIT WEBSITE",nil) forState:UIControlStateNormal];
    [self.LinkBtn setTitle:NSLocalizedString(@"LINK",nil) forState:UIControlStateNormal];
    [self.VideoBtn setTitle:NSLocalizedString(@"WATCH VIDEO",nil) forState:UIControlStateNormal];
    
    ///
    
    NSString *imageToLoad = [self.getBussnessDic objectForKey:@"product_image1"];
    NSString *imageToLoad2 = [self.getBussnessDic objectForKey:@"product_image2"];
    NSString *imageToLoad3 = [self.getBussnessDic objectForKey:@"product_image3"];
    NSString *imageToLoad4 = [self.getBussnessDic objectForKey:@"product_image4"];
    NSString *imageToLoad5 = [self.getBussnessDic objectForKey:@"product_image5"];
    NSString *imageToLoad6 = [self.getBussnessDic objectForKey:@"product_image6"];
    NSString *imageToLoad7 = [self.getBussnessDic objectForKey:@"product_image7"];
    NSString *imageToLoad8 = [self.getBussnessDic objectForKey:@"product_image8"];
    NSString *imageToLoad9 = [self.getBussnessDic objectForKey:@"product_image9"];
    NSString *imageToLoad10 = [self.getBussnessDic objectForKey:@"product_image10"];
    
    
    if(imageToLoad.length > 0) {
        [self.UserImage sd_setImageWithURL:[NSURL URLWithString:imageToLoad] placeholderImage:[UIImage imageNamed:@"index.png"]];
    } else if(imageToLoad2.length > 0) {
        [self.UserImage sd_setImageWithURL:[NSURL URLWithString:imageToLoad2] placeholderImage:[UIImage imageNamed:@"index.png"]];
    } else if(imageToLoad2.length > 0) {
        [self.UserImage sd_setImageWithURL:[NSURL URLWithString:imageToLoad2] placeholderImage:[UIImage imageNamed:@"index.png"]];
    } else if(imageToLoad3.length > 0) {
        [self.UserImage sd_setImageWithURL:[NSURL URLWithString:imageToLoad3] placeholderImage:[UIImage imageNamed:@"index.png"]];
    } else if(imageToLoad4.length > 0) {
        [self.UserImage sd_setImageWithURL:[NSURL URLWithString:imageToLoad4] placeholderImage:[UIImage imageNamed:@"index.png"]];
    } else if(imageToLoad5.length > 0) {
        [self.UserImage sd_setImageWithURL:[NSURL URLWithString:imageToLoad5] placeholderImage:[UIImage imageNamed:@"index.png"]];
    } else if(imageToLoad6.length > 0) {
        [self.UserImage sd_setImageWithURL:[NSURL URLWithString:imageToLoad6] placeholderImage:[UIImage imageNamed:@"index.png"]];
    } else if(imageToLoad7.length > 0) {
        [self.UserImage sd_setImageWithURL:[NSURL URLWithString:imageToLoad7] placeholderImage:[UIImage imageNamed:@"index.png"]];
    } else if(imageToLoad8.length > 0) {
        [self.UserImage sd_setImageWithURL:[NSURL URLWithString:imageToLoad8] placeholderImage:[UIImage imageNamed:@"index.png"]];
    } else if(imageToLoad9.length > 0) {
        [self.UserImage sd_setImageWithURL:[NSURL URLWithString:imageToLoad9] placeholderImage:[UIImage imageNamed:@"index.png"]];
    } else if(imageToLoad10.length > 0) {
        [self.UserImage sd_setImageWithURL:[NSURL URLWithString:imageToLoad10] placeholderImage:[UIImage imageNamed:@"index.png"]];
    } else {
        [self.UserImage sd_setImageWithURL:[NSURL URLWithString:self.getBussnessDic[@"subcategory_image"]] placeholderImage:[UIImage imageNamed:@"index.png"]];
    }
    
    
    NSString *Profile1 = [self.getBussnessDic objectForKey:@"product_image1"];
    [self.ProfileImage1 sd_setImageWithURL:[NSURL URLWithString:Profile1] placeholderImage:[UIImage imageNamed:@"index.png"]];
    NSString *Profile2 = [self.getBussnessDic objectForKey:@"product_image2"];
    [self.ProfileImage2 sd_setImageWithURL:[NSURL URLWithString:Profile2] placeholderImage:[UIImage imageNamed:@"index.png"]];
    NSString *Profile3 = [self.getBussnessDic objectForKey:@"product_image3"];
    [self.ProfileImage3 sd_setImageWithURL:[NSURL URLWithString:Profile3] placeholderImage:[UIImage imageNamed:@"index.png"]];
    NSString *Profile4 = [self.getBussnessDic objectForKey:@"product_image4"];
    [self.ProfileImage4 sd_setImageWithURL:[NSURL URLWithString:Profile4] placeholderImage:[UIImage imageNamed:@"index.png"]];
    NSString *Profile5 = [self.getBussnessDic objectForKey:@"product_image5"];
    [self.ProfileImage5 sd_setImageWithURL:[NSURL URLWithString:Profile5] placeholderImage:[UIImage imageNamed:@"index.png"]];
    NSString *Profile6 = [self.getBussnessDic objectForKey:@"product_image6"];
    [self.ProfileImage6 sd_setImageWithURL:[NSURL URLWithString:Profile6] placeholderImage:[UIImage imageNamed:@"index.png"]];
    
    NSString *Profile7 = [self.getBussnessDic objectForKey:@"product_image7"];
    [self.ProfileImage7 sd_setImageWithURL:[NSURL URLWithString:Profile7] placeholderImage:[UIImage imageNamed:@"index.png"]];
    NSString *Profile8 = [self.getBussnessDic objectForKey:@"product_image8"];
    [self.ProfileImage8 sd_setImageWithURL:[NSURL URLWithString:Profile8] placeholderImage:[UIImage imageNamed:@"index.png"]];
    NSString *Profile9 = [self.getBussnessDic objectForKey:@"product_image9"];
    [self.ProfileImage9 sd_setImageWithURL:[NSURL URLWithString:Profile9] placeholderImage:[UIImage imageNamed:@"index.png"]];
    NSString *Profile10 = [self.getBussnessDic objectForKey:@"product_image10"];
    [self.ProfileImage10 sd_setImageWithURL:[NSURL URLWithString:Profile10] placeholderImage:[UIImage imageNamed:@"index.png"]];

    
    
    ImageArr = [[NSMutableArray alloc] init];
    
    if(Profile1.length > 0) {
        [ImageArr addObject:self.ProfileImage1];    // [NSMutableArray arrayWithObjects:self.ProfileImage1, nil];
        UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapGesture1:)];
        tapGesture1.numberOfTapsRequired = 1;
        [tapGesture1 setDelegate:self];
        [self.ProfileImage1 addGestureRecognizer:tapGesture1];
        
        self.ProfileImage1.userInteractionEnabled = YES;
        self.ProfileImage1.tag=0;
    }
    
    if(Profile2.length > 0) {
        [ImageArr addObject:self.ProfileImage2];
        self.ProfileImage2.userInteractionEnabled = YES;
        self.ProfileImage2.tag=1;
        UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapGesture2:)];
        tapGesture2.numberOfTapsRequired = 1;
        [tapGesture2 setDelegate:self];
        [self.ProfileImage2 addGestureRecognizer:tapGesture2];
    }
    
    if(Profile3.length > 0) {
        [ImageArr addObject:self.ProfileImage3];
        self.ProfileImage3.tag=2;
        self.ProfileImage3.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapGesture3 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapGesture3:)];
        tapGesture3.numberOfTapsRequired = 1;
        [tapGesture3 setDelegate:self];
        [self.ProfileImage3 addGestureRecognizer:tapGesture3];
    }
    
    if(Profile4.length > 0) {
        [ImageArr addObject:self.ProfileImage4];
        self.ProfileImage4.tag=3;
        self.ProfileImage4.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapGesture4 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapGesture4:)];
        tapGesture4.numberOfTapsRequired = 1;
        [tapGesture4 setDelegate:self];
        [self.ProfileImage4 addGestureRecognizer:tapGesture4];
    }
    if(Profile5.length > 0) {
        [ImageArr addObject:self.ProfileImage5];
        self.ProfileImage5.tag=4;
        self.ProfileImage5.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture5 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapGesture5:)];
        tapGesture5.numberOfTapsRequired = 1;
        [tapGesture5 setDelegate:self];
        [self.ProfileImage5 addGestureRecognizer:tapGesture5];
    }
    if(Profile6.length > 0) {
        [ImageArr addObject:self.ProfileImage6];
        self.ProfileImage6.tag=5;
        self.ProfileImage6.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture5 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapGesture5:)];
        tapGesture5.numberOfTapsRequired = 1;
        [tapGesture5 setDelegate:self];
        [self.ProfileImage6 addGestureRecognizer:tapGesture5];
    }
    if(Profile7.length > 0) {
        [ImageArr addObject:self.ProfileImage7];
        self.ProfileImage7.tag=6;
        self.ProfileImage7.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapGesture3 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapGesture3:)];
        tapGesture3.numberOfTapsRequired = 1;
        [tapGesture3 setDelegate:self];
        [self.ProfileImage7 addGestureRecognizer:tapGesture3];
    }
    
    if(Profile8.length > 0) {
        [ImageArr addObject:self.ProfileImage8];
        self.ProfileImage8.tag=7;
        self.ProfileImage8.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapGesture4 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapGesture4:)];
        tapGesture4.numberOfTapsRequired = 1;
        [tapGesture4 setDelegate:self];
        [self.ProfileImage8 addGestureRecognizer:tapGesture4];
    }
    if(Profile9.length > 0) {
        [ImageArr addObject:self.ProfileImage9];
        self.ProfileImage9.tag=8;
        self.ProfileImage9.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture5 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapGesture5:)];
        tapGesture5.numberOfTapsRequired = 1;
        [tapGesture5 setDelegate:self];
        [self.ProfileImage9 addGestureRecognizer:tapGesture5];
    }
    if(Profile10.length > 0) {
        [ImageArr addObject:self.ProfileImage10];
        self.ProfileImage10.tag=9;
        self.ProfileImage10.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture5 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapGesture5:)];
        tapGesture5.numberOfTapsRequired = 1;
        [tapGesture5 setDelegate:self];
        [self.ProfileImage10 addGestureRecognizer:tapGesture5];
    }

    NSLog(@"array size is %lu", (unsigned long)ImageArr.count);
 
    if(ImageArr.count > 0) {
        self.lbl_ImgCounter.frame = CGRectMake(0, self.view_Images.frame.size.height - self.lbl_ImgCounter.frame.size.height - 2, self.lbl_ImgCounter.frame.size.width, self.lbl_ImgCounter.frame.size.height);
        [self.view_Images addSubview:self.lbl_ImgCounter];
        self.lbl_ImgCounter.hidden = NO;
        self.lbl_ImgCounter.text = [NSString stringWithFormat:@"+ %d", (int)ImageArr.count];
    } else {
        [self.ProfileImage1 sd_setImageWithURL:[NSURL URLWithString:self.getBussnessDic[@"subcategory_image"]] placeholderImage:[UIImage imageNamed:@"index.png"]];
        [ImageArr addObject:self.ProfileImage1];
        
        self.lbl_ImgCounter.hidden = YES;
    }
    
    
    [self setupRateView];
    // Do any additional setup after loading the view.

   
}

- (void) tapGesture1: (id)sender
{    tag=0;
     [self performSegueWithIdentifier:@"slideView" sender:self];
    //handle Tap...
}
- (void) tapGesture2: (id)sender
{    tag=1;
    [self performSegueWithIdentifier:@"slideView" sender:self];
    //handle Tap...
}
- (void) tapGesture3: (id)sender
{    tag=2;
    [self performSegueWithIdentifier:@"slideView" sender:self];
    //handle Tap...
}
- (void) tapGesture4: (id)sender
{    tag=3;
    [self performSegueWithIdentifier:@"slideView" sender:self];
    //handle Tap...
}- (void) tapGesture5: (id)sender
{   tag=4;
    [self performSegueWithIdentifier:@"slideView" sender:self];
    //handle Tap...
}- (void) tapGesture6: (id)sender
{
    tag=5;
    [self performSegueWithIdentifier:@"slideView" sender:self];
    //handle Tap...
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"Leavemssg"]) {
        LeavemessageViewController *Leave=segue.destinationViewController;
        Leave.Businesdic=self.getBussnessDic;
        
    }else if([segue.identifier isEqualToString:@"Write"]){
        WriteViewController *Write=segue.destinationViewController;
        Write.iswrite =YES;
        Write.Bussinedic=bdic;
        
    }else if([segue.identifier isEqualToString:@"slideView"]){
        SlideImagesViewController *SlideImages=segue.destinationViewController;
        SlideImages.Imagearr =ImageArr;
        SlideImages.Tag=tag;
    }else if([segue.identifier isEqualToString:@"ReadView"]){
        ReadViewController *ReadView=segue.destinationViewController;
        ReadView.BusinessDic=bdic;
        ReadView.isserchsetview=true;
        
        
    }else if([segue.identifier isEqualToString:@"Booking"]){
        BookingViewController *BookingView=segue.destinationViewController;
        BookingView.BusinessDic=bdic;
        
        
    }

    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    
    NSMutableString *newString=[[NSMutableString alloc]initWithString:textView.text];
    if ([text isEqualToString: @""])
    {
        
        if (newString.length==0) {
            
        }else{
            
            NSRange ran=NSMakeRange(0, newString.length-1);
            
            NSString *str=[newString stringByReplacingCharactersInRange:ran withString:@""];
            
            NSRange NewRan=[newString rangeOfString:str];
            
            
            newString=[newString stringByReplacingCharactersInRange:NewRan withString:@""];
        }
    }else{
        [newString appendString:text];
    }
    
    
    
    if ([newString isEqualToString:@""]) {
        self.placehoderLabel.hidden = NO;
    }else if(newString.length>0){
        self.placehoderLabel.hidden = YES;
    }
    
    
    
    return YES;
}


- (IBAction)ActionOnmap:(id)sender {
    
}

- (IBAction)RatingBtn:(id)sender {
    self.isserchsetview=true;
    [self performSegueWithIdentifier:@"Write" sender:self];
    //
}
- (IBAction)ActionOncallIng:(id)sender {
    NSString *phNo = [self.getBussnessDic objectForKey:@"phone"];
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
        calert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Alert" ,nil) message:NSLocalizedString(@"Call facility is not available!!!" ,nil) delegate:nil cancelButtonTitle:NSLocalizedString( @"OK" ,nil) otherButtonTitles:nil, nil];
        [calert show];
    }
}

- (IBAction)ActionOnmessage:(id)sender {
    self.isserchsetview=true;
    [self performSegueWithIdentifier:@"Leavemssg" sender:self];
}

- (IBAction)BackBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)ActionOnMenu:(id)sender {
    if (!isbusiness) {
        
        sample = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
        sample.delegate = self;
        // nav=[[UINavigationController alloc]init:ll];
        sample.view.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height);
        
        CATransition *transition = [CATransition animation];
        transition.duration = 0.5;
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [sample.view.layer addAnimation:transition forKey:nil];
        [self.view addSubview:sample.view];
        
        isbusiness = true;
        
    } else {
        
        
        CATransition *transition = [CATransition animation];
        transition.duration =0.5;
        transition.type = kCATransitionReveal;
        transition.subtype = kCATransitionFromRight;

        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [sample.view.layer addAnimation:transition forKey:nil];
        [sample.view performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.5];
        
        isbusiness = false;
    }
    
    

}

- (IBAction)ActionOnHome:(id)sender {
    
    UIStoryboard *MainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    UINavigationController *controller = (UINavigationController*)[MainStoryboard instantiateViewControllerWithIdentifier: @"RootNavigationController"];
    
    UITabBarController *tabar = controller.viewControllers[0];
    [tabar setSelectedIndex:3];
    
    [AppDelegate SharedInstance].window.rootViewController=controller;
    [[AppDelegate SharedInstance].window makeKeyAndVisible];
}

- (IBAction)ActiononFavirateBtn:(id)sender {
    
    NSMutableDictionary * dictBD = [[NSMutableDictionary alloc] init];
    dictBD = [bdic mutableCopy];
    [dictBD setObject:kAppDelegate.strSubCategory forKey:@"subcategory_image"];
    
    if ([sender isSelected]) {
         NSString*me=@"like";
        [bdic setObject:me forKey:@"like"];
        [dictBD setObject:me forKey:@"like"];
        [sender setSelected: NO];
        FMDBManager *fm = [[FMDBManager alloc] init];
        [fm openDataBase];
        [fm deletefavrate:[dictBD mutableCopy]];
        self.changeimageview.image=[UIImage imageNamed:@"favorite_icons_widout_blk_hrt.png"];
    } else {
        [sender setSelected: YES];
        NSString*me=@"unlike";
        [bdic setObject:me forKey:@"like"];
        [dictBD setObject:me forKey:@"like"];
        FMDBManager *fm = [[FMDBManager alloc] init];
        [fm openDataBase];
        [fm savefavrate:[dictBD mutableCopy]];
        self.changeimageview.image=[UIImage imageNamed:@"favorite_icons_wid_blk_hrt.png"];
    }
}
#pragma mark - Menu delegates

-(void)PushViewControllersOnSelFView:(int)View {
    [sample.view removeFromSuperview];
    
    switch (View) {
        case 1:
            
            break;
        case 2:
        {
            RegistrationViewController *registerView = [self.storyboard instantiateViewControllerWithIdentifier:@"RegistrationViewController"];
            registerView.tabBarController.tabBar.hidden = YES;
            [self.navigationController pushViewController:registerView animated:YES];
        }
            break;
        case 3:
        {
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"login"]isEqualToString:@"Yes"]) {
                AddbusinessViewController *AddbusinessView = [self.storyboard instantiateViewControllerWithIdentifier:@"AddbusinessViewController"];
                //AddbusinessView.tabBarController.tabBar.hidden = YES;
                [self.navigationController pushViewController:AddbusinessView animated:YES];
            }else{
                
                LoginViewController *LoginView = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
                LoginView.tabBarController.tabBar.hidden = YES;
                [self.navigationController pushViewController:LoginView animated:YES];
            }
            
            
            
        }
            
            break;
        case 4:
        {
            HelpViewController*HelpView = [self.storyboard instantiateViewControllerWithIdentifier:@"HelpViewController"];
            HelpView.tabBarController.tabBar.hidden = YES;
            [self.navigationController pushViewController:HelpView animated:YES];
        
        }
            
            break;
        case 5:
        {
            ContectUsViewController*ContectUsView = [self.storyboard instantiateViewControllerWithIdentifier:@"ContectUsViewController"];
            ContectUsView.tabBarController.tabBar.hidden = YES;
            [self.navigationController pushViewController:ContectUsView animated:YES];
        }
            
            break;
        case 6:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Are you sure you want to logout?",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK" ,nil) otherButtonTitles:NSLocalizedString(@"Cancel" ,nil), nil];
            
            alert.tag=1;
            [alert show];
        }
            break;
        case 7:
        {
            
            if (UserDict == nil) {
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"" message:NSLocalizedString(@"Please login first",nil) preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* yesButton = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                    
                    LoginViewController *LoginView = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
                    LoginView.tabBarController.tabBar.hidden = YES;
                    [self.navigationController pushViewController:LoginView animated:YES];

                }];
                UIAlertAction* CancelButton = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                }];

                [alert addAction:yesButton];
                [alert addAction:CancelButton];

                [self presentViewController:alert animated:YES completion:nil];
  
            }
            else
            {
                IntrestCatViewController *price1=[self.storyboard instantiateViewControllerWithIdentifier:@"IntrestCatViewController"];
               // price1.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
               // price1.modalPresentationStyle = UIModalPresentationFormSheet;
                [self presentViewController:price1 animated:true completion:nil];
            }

            
        }
            break;
        case 8:
        {
            LocationViewController*vcLocationViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LocationViewController"];
            vcLocationViewController.tabBarController.tabBar.hidden = YES;
            [self.navigationController pushViewController:vcLocationViewController animated:YES];
        }
            
            break;
            
        default:
            break;
    }
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:NSLocalizedString(@"Error" ,nil) message:NSLocalizedString(@"Failed to Get Your Location" ,nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK" ,nil) otherButtonTitles:nil];
    //[errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    //NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    if (currentLocation != nil) {
        //Userlong = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        //Userlat= [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        self.lat=currentLocation.coordinate.latitude;
         self.longs=currentLocation.coordinate.longitude;
       
        //[self GetprodectList];
    }
}
- (IBAction)ActionOnOpenapp:(id)sender {
    
//[self navigateToLatitude:self.lat
            //   longitude:self.longs];
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"AllinInfo"
                                                      message:@""
                                                     delegate:self
                                            cancelButtonTitle:@"Cancel"
                                            otherButtonTitles:@"Waze", @"Google", nil];
        //  [message show];
    
    self.view_PopUp.frame = self.view.frame;
    [self.view addSubview:_view_PopUp];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
   
    if (alertView.tag==1) {
        if (buttonIndex == 0){
            
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"login"];
            
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"userdata"];
            
            
            //login
            
        }
        
        
    }else{
        NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
        
        if([title isEqualToString:@"Google"])
        {
            double wsLat = [setwsLat doubleValue];
            double wsLong  = [setwsLong doubleValue];
            
            if ([[UIApplication sharedApplication] canOpenURL:
                 [NSURL URLWithString:@"comgooglemaps://"]]) {
                NSString* url = [NSString stringWithFormat:@"http://maps.google.com/maps?saddr=%f,%f&daddr=%f,%f",self.lat, self.longs, wsLat, wsLong];
                [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
                
            } else {
                [[UIApplication sharedApplication] openURL:[NSURL
                                                            URLWithString:@"https://itunes.apple.com/in/app/google-maps-real-time-navigation/id585027354?mt=8"]];
            }
        }
        else if([title isEqualToString:@"Waze"])
        {
            double wsLat = [setwsLat doubleValue];
            double wsLong  = [setwsLong doubleValue];
            [self navigateToLatitude:wsLat
                           longitude:wsLong];
            
        }
        else if([title isEqualToString:@"Cancel"])
        {
            
        }
    }
}


- (IBAction)ActionOnOderBtn:(id)sender {
     self.isserchsetview=true;
     [self performSegueWithIdentifier:@"Booking" sender:self];
  //  Booking
}
- (void) navigateToLatitude:(double)latitude
                  longitude:(double)longitude
{
    if ([[UIApplication sharedApplication]
         canOpenURL:[NSURL URLWithString:@"waze://"]]) {
        
        // Waze is installed. Launch Waze and start navigation
        NSString *urlStr =
        [NSString stringWithFormat:@"waze://?ll=%f,%f&navigate=yes",
         latitude, longitude];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
        
    } else {
        
        // Waze is not installed. Launch AppStore to install Waze app
        [[UIApplication sharedApplication] openURL:[NSURL
                                                    URLWithString:@"http://itunes.apple.com/us/app/id323229106"]];
    }
}
- (IBAction)ActionFb:(id)sender {
    
    if ([FbUrlstring rangeOfString:@"http://"].location != NSNotFound){
         [[UIApplication sharedApplication] openURL:[NSURL URLWithString: FbUrlstring]];
    }
    if ([FbUrlstring rangeOfString:@"https://"].location != NSNotFound){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: FbUrlstring]];
    }else{
        NSString *fb=[NSString stringWithFormat:@"http://%@",FbUrlstring];
         [[UIApplication sharedApplication] openURL:[NSURL URLWithString: fb]];
    }

   


}
- (IBAction)ReadBtnAction:(id)sender {
    self.isserchsetview=true;
    [self performSegueWithIdentifier:@"ReadView" sender:self];
    
       // WSOperationInEDUApp *ws=[[WSOperationInEDUApp //alloc]initWithDelegate:self callback:@selector(ReadBtn:)];
        //[ws readReview:@"2"];
        
       // [ws addbusinessList:[UserDict objectForKey:@"login_id"]];

}
-(void)ReadBtn:(id)response
{
    NSDictionary *responseDic=response;
    if ([response isKindOfClass:[NSDictionary class]]) {
        if ([[responseDic objectForKey:@"message"]isEqualToString:@"success"]) {
            
        }
        
    }
}

- (IBAction)WrightBtnAction:(id)sender {
    self.isserchsetview=true;
    [self performSegueWithIdentifier:@"Write" sender:self];
}

//pragma mark - Rating method
- (void)setupRateView
{
    self.IBRaingView.notSelectedImage = [UIImage imageNamed:@"star_blank.png"];
    self.IBRaingView.fullSelectedImage = [UIImage imageNamed:@"star_fill.png"];
    if(kAppDelegate.flagIsShowAverageRating) {
        if(value == 0) {
    
        self.IBRaingView.rating = kAppDelegate.averageRating;
        } else {
            int aValue = (value + kAppDelegate.averageRating)/2;
            
            self.IBRaingView.rating = aValue;
        }
    } else {
        self.IBRaingView.rating = value;
    }
    
    self.IBRaingView.maxRating = 5;
   
}


- (void) setRatingView1 {
    Starimg1.image = [UIImage imageNamed:@"star_blank.png"];
    Starimg2.image = [UIImage imageNamed:@"star_blank.png"];
    Starimg3.image = [UIImage imageNamed:@"star_blank.png"];
    Starimg4.image = [UIImage imageNamed:@"star_blank.png"];
    Starimg5.image = [UIImage imageNamed:@"star_blank.png"];
    
    float intRating = 0.0;
    if(kAppDelegate.flagIsShowAverageRating) {
        if(Rating.floatValue == 0) {
                intRating =  kAppDelegate.averageRating;
        } else {
            intRating = (Rating.floatValue + kAppDelegate.averageRating)/2;
        }
        
    } else {
      intRating =  Rating.floatValue;
    }
    
    
    
    if(intRating == 0.0) {
        
    } else if(intRating ==  0.5) {
        Starimg1.image = [UIImage imageNamed:@"star_half.png"];
        
    } else if(intRating ==  1.0) {
        Starimg1.image = [UIImage imageNamed:@"star_fill.png"];
        
    } else if(intRating ==  1.5) {
        Starimg1.image = [UIImage imageNamed:@"star_fill.png"];
        Starimg2.image = [UIImage imageNamed:@"star_half.png"];
        
    }  else if(intRating ==  2.0) {
        Starimg1.image = [UIImage imageNamed:@"star_fill.png"];
        Starimg2.image = [UIImage imageNamed:@"star_fill.png"];
        
    } else if(intRating ==  2.5) {
        Starimg1.image = [UIImage imageNamed:@"star_fill.png"];
        Starimg2.image = [UIImage imageNamed:@"star_fill.png"];
        Starimg3.image = [UIImage imageNamed:@"star_half.png"];
        
    } else if(intRating ==  3.0) {
        Starimg1.image = [UIImage imageNamed:@"star_fill.png"];
        Starimg2.image = [UIImage imageNamed:@"star_fill.png"];
        Starimg3.image = [UIImage imageNamed:@"star_fill.png"];
        
    } else if(intRating ==  3.5) {
        Starimg1.image = [UIImage imageNamed:@"star_fill.png"];
        Starimg2.image = [UIImage imageNamed:@"star_fill.png"];
        Starimg3.image = [UIImage imageNamed:@"star_fill.png"];
        Starimg4.image = [UIImage imageNamed:@"star_half.png"];
        
    } else if(intRating ==  4.0) {
        Starimg1.image = [UIImage imageNamed:@"star_fill.png"];
        Starimg2.image = [UIImage imageNamed:@"star_fill.png"];
        Starimg3.image = [UIImage imageNamed:@"star_fill.png"];
        Starimg4.image = [UIImage imageNamed:@"star_fill.png"];
        
    } else if(intRating ==  4.5) {
        Starimg1.image = [UIImage imageNamed:@"star_fill.png"];
        Starimg2.image = [UIImage imageNamed:@"star_fill.png"];
        Starimg3.image = [UIImage imageNamed:@"star_fill.png"];
        Starimg4.image = [UIImage imageNamed:@"star_fill.png"];
        Starimg5.image = [UIImage imageNamed:@"star_half.png"];
        
    } else if(intRating ==  5.0) {
        Starimg1.image = [UIImage imageNamed:@"star_fill.png"];
        Starimg2.image = [UIImage imageNamed:@"star_fill.png"];
        Starimg3.image = [UIImage imageNamed:@"star_fill.png"];
        Starimg4.image = [UIImage imageNamed:@"star_fill.png"];
        Starimg5.image = [UIImage imageNamed:@"star_fill.png"];
    }
}

#pragma mark - rate delegates

- (void)rateView:(RateView *)rateView ratingDidChange:(float)rating
{
    NSString *ratingstr = [NSString stringWithFormat:@"%f", rating];
    NSInteger rateint = [ratingstr integerValue];
    //finalrating = [NSString stringWithFormat:@"%ld",(long)rateint];
    
}
- (IBAction)ActionONvideo:(id)sender {
    if ([VideoUrlstring rangeOfString:@"http://"].location != NSNotFound){
        
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[VideoUrlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    }
    if ([VideoUrlstring rangeOfString:@"https://"].location != NSNotFound){
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[VideoUrlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    }else{
        NSString *fb=[NSString stringWithFormat:@"http://%@",VideoUrlstring];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[fb stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        //[[UIApplication sharedApplication] openURL:[NSURL URLWithString: fb]];
    }

}
- (IBAction)ActionOnvisitBtn:(id)sender {
    
   NSString* web = [website_urlstring stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([web rangeOfString:@"http://"].location != NSNotFound){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[web stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    }
    if ([web rangeOfString:@"https://"].location != NSNotFound){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[web stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    }else{
        NSString *wsurl=[NSString stringWithFormat:@"https://%@",web];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[wsurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        //[[UIApplication sharedApplication] openURL:[NSURL URLWithString: wsurl]];
    }
}
- (IBAction)btn_TableUrl:(id)sender {
    
    NSString * strTUrl = self.getBussnessDic[@"table_reservation_url"];
    
    if(strTUrl.length > 0) {
        
        if ([strTUrl rangeOfString:@"http://"].location != NSNotFound){
            NSURL * tUrl = [NSURL URLWithString:[strTUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            [[UIApplication sharedApplication] openURL:tUrl];
        }
        
        if ([strTUrl rangeOfString:@"https://"].location != NSNotFound){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[strTUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        }else{
            NSString *wsurl=[NSString stringWithFormat:@"https://%@",strTUrl];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[wsurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        }
        
    }
}

- (IBAction)btn_MenuUrl:(id)sender {
    NSString * strMUrl = self.getBussnessDic[@"menu_url"];
    
    if(strMUrl.length > 0) {
        
        if ([strMUrl rangeOfString:@"http://"].location != NSNotFound){
            NSURL * tUrl = [NSURL URLWithString:[strMUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            [[UIApplication sharedApplication] openURL:tUrl];
        }
        
        if ([strMUrl rangeOfString:@"https://"].location != NSNotFound){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[strMUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        }else{
            NSString *wsurl=[NSString stringWithFormat:@"https://%@",strMUrl];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[wsurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        }
        
    }
}

- (IBAction)btn_ShareImage:(id)sender {

    NSString *strBusinessName = @"";
    NSString* strUnicodeString=[NSString stringWithFormat:@"%@",[self.getBussnessDic objectForKey:@"business_name"]];
    
    if ([strUnicodeString isEqual:[NSNull null]]) {
        strUnicodeString=@"";
    }else if ([strUnicodeString isEqual:@""]) {
        strUnicodeString=@"";
    }else if(strUnicodeString == nil){
        strUnicodeString=@"";
    }else{
        if ([strUnicodeString canBeConvertedToEncoding:NSASCIIStringEncoding]){
            NSData *data = [strUnicodeString dataUsingEncoding:NSUTF8StringEncoding];
            NSString *string = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding];
            strBusinessName =[NSString stringWithFormat:@"%@",string];
            
        }else{
            strBusinessName =[NSString stringWithFormat:@"%@",strUnicodeString];
        }
    }
    
    NSLog(@"strBusinessName = %@", strBusinessName);
    NSString *textToShare = [NSString stringWithFormat: @"%@ \n%@", strBusinessName,strLink];
    
    
    /// If user suddenly click and link got empty then this condition executes
    if (strLink == nil) {
       // strLink=@"";
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"" message:NSLocalizedString(@"Need to add business before sharing business",nil) preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            
        }];
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];

    }  else {
        NSURL *myWebsite = [NSURL URLWithString:strLink];
        NSArray *objectsToShare = @[strBusinessName, myWebsite];
        NSLog(@"objectsToShare....%@",objectsToShare);
        
        UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
        NSArray *excludeActivities = @[];
        activityVC.excludedActivityTypes = excludeActivities;
        [self presentViewController:activityVC animated:YES completion:nil];
    }
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
- (IBAction)btn_CancelView:(id)sender {
    [self.view_PopUp removeFromSuperview];
}

- (IBAction)btn_Waze:(id)sender {
    double wsLat = [setwsLat doubleValue];
    double wsLong  = [setwsLong doubleValue];
    [self navigateToLatitude:wsLat
                   longitude:wsLong];
}

- (IBAction)btn_GoogleMap:(id)sender {
    double wsLat = [setwsLat doubleValue];
    double wsLong  = [setwsLong doubleValue];
    
    if ([[UIApplication sharedApplication] canOpenURL:
         [NSURL URLWithString:@"comgooglemaps://"]]) {
        NSString* url = [NSString stringWithFormat:@"http://maps.google.com/maps?saddr=%f,%f&daddr=%f,%f",self.lat, self.longs, wsLat, wsLong];
        [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
        
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL
                                                    URLWithString:@"https://itunes.apple.com/in/app/google-maps-real-time-navigation/id585027354?mt=8"]];
    }
}
@end

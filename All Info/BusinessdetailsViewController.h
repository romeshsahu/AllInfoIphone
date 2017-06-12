//
//  BusinessdetailsViewController.h
//  All Info
//
//  Created by Mahendra Suryavanshi on 3/7/16.
//  Copyright © 2016 PS.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "RateView.h"
#import <CoreLocation/CoreLocation.h>

@interface BusinessdetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *view_Images;
@property (weak, nonatomic) IBOutlet UIButton *btn_TableUrl;
@property (weak, nonatomic) IBOutlet UIButton *btn_MenuUrl;
- (IBAction)btn_CancelView:(id)sender;
- (IBAction)btn_Waze:(id)sender;
- (IBAction)btn_GoogleMap:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *view_PopUp;

- (IBAction)btn_TableUrl:(id)sender;
- (IBAction)btn_MenuUrl:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Status1;
- (IBAction)btn_Share:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *lbl_Status;
    // Rating:
@property (weak, nonatomic) IBOutlet UIImageView *Starimg1;
@property (weak, nonatomic) IBOutlet UIImageView *Starimg2;
@property (weak, nonatomic) IBOutlet UIImageView *Starimg3;
@property (weak, nonatomic) IBOutlet UIImageView *Starimg4;
@property (weak, nonatomic) IBOutlet UIImageView *Starimg5;
@property (weak, nonatomic) IBOutlet UILabel *lbl_ImgCounter;


- (IBAction)ActionOnMenu:(id)sender;
@property (weak, nonatomic) IBOutlet RateView *IBRaingView;

- (IBAction)ActionOnHome:(id)sender;
@property bool isserchsetview;
@property (weak, nonatomic) IBOutlet UILabel *PhoneNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *AddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *DistanceLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *BusinesScrollView;

@property (weak, nonatomic) IBOutlet UILabel *placehoderLabel;

@property (weak, nonatomic) IBOutlet UIImageView *UserImage;
@property NSMutableDictionary *getBussnessDic;
@property BOOL ishistoty;
@property bool ishistoryselected;
@property (weak, nonatomic) IBOutlet UILabel *BusnessnameLabel;
@property (nonatomic) double lat;
@property (nonatomic) double longs;
- (IBAction)ActiononFavirateBtn:(id)sender;
- (IBAction)ActionOnOpenapp:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *OderBtnOut;

- (IBAction)ActionOnOderBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *changeimageview;
@property (weak, nonatomic) IBOutlet UIButton *LikeBtnout;

@property (weak, nonatomic) IBOutlet UILabel *BusinesshoursLabel;
@property (weak, nonatomic) IBOutlet UIButton *ActionOnFacebookBtn;

- (IBAction)ActionFb:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *ReadLabel;
@property (weak, nonatomic) IBOutlet UILabel *WrightLabel;
@property (weak, nonatomic) IBOutlet UIButton *VisitBtn;
@property (weak, nonatomic) IBOutlet UIButton *VideoBtn;

- (IBAction)ReadBtnAction:(id)sender;

- (IBAction)WrightBtnAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *LinkBtn;
@property (weak, nonatomic) IBOutlet UIImageView *ProfileImage1;
@property (weak, nonatomic) IBOutlet UIImageView *ProfileImage5;
@property (weak, nonatomic) IBOutlet UIImageView *ProfileImage6;


- (IBAction)ActionONvideo:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *start_timeLabel;

- (IBAction)ActionOnvisitBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *ProfileImage2;
@property (weak, nonatomic) IBOutlet UIImageView *ProfileImage3;
@property (weak, nonatomic) IBOutlet UIImageView *ProfileImage4;


@property (weak, nonatomic) IBOutlet UILabel *SubcategryLab;
- (IBAction)ActionOnmap:(id)sender;
- (IBAction)RatingBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *DetailsTextView;
@property (weak, nonatomic) IBOutlet UICollectionView *BusnessCollectionView;
- (IBAction)ActionOncallIng:(id)sender;

- (IBAction)ActionOnmessage:(id)sender;
- (IBAction)BackBtn:(id)sender;

@end

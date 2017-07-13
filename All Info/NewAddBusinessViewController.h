//
//  NewAddBusinessViewController.h
//  All Info
//
//  Created by iPhones on 5/5/16.
//  Copyright © 2016 PS.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntrestCatViewController.h"


@protocol NewAddBusinessViewControllerDelegates <NSObject>

-(void)callweb;

@end
@interface NewAddBusinessViewController : UIViewController {

    IBOutlet UITextView *tv_ParkingAvailable;
    IBOutlet UITextView *tv_PeopleAccess;
    IBOutlet UILabel *lbl_PlaceholderPeople;
    
    IBOutlet UILabel *lbl_PlaceholderParking;
}

@property BOOL flagIsParkingAvaialble, flagIsPeopleAccess;
@property NSString * strPeopleAccess, * strParkingAvailable;
@property (strong, nonatomic) IBOutlet UIButton *btn_PeopleAccess;
- (IBAction)btn_PeopleAccess:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btn_ParkingAvailable;
- (IBAction)btn_ParkingAvailable:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *lbl_PEmail;
@property (weak, nonatomic) IBOutlet UILabel *lbl_PPhone;
@property (weak, nonatomic) IBOutlet UILabel *lbl_PAddress;
@property (weak, nonatomic) IBOutlet UILabel *lbl_PName;
@property (weak, nonatomic) IBOutlet UILabel *lbl_PCategory;
@property (weak, nonatomic) IBOutlet UILabel *lbl_PSubCategory;

@property (weak, nonatomic) IBOutlet UILabel *lbl_BussinetTypeTextfiled;
@property (weak, nonatomic) IBOutlet UILabel *lbl_WeburlTextFiled;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Videourl;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Facebooktextfiled;
@property (weak, nonatomic) IBOutlet UILabel *lbl_TfTblUrl;
@property (weak, nonatomic) IBOutlet UILabel *lbl_TfMenuUrl;


@property NSDictionary*editbusinesdic ;
@property BOOL iseditNew;
@property BOOL flagIsOpen;
    @property int intBusinessHourStatus;
    
    @property (weak, nonatomic) IBOutlet UITextField *tf_TblUrl;
    @property (weak, nonatomic) IBOutlet UITextField *tf_MenuUrl;
@property (weak, nonatomic) IBOutlet UIButton *btn_Share;
- (IBAction)btn_Share:(id)sender;
    
    
- (IBAction)ActionOnback:(id)sender;
@property (nonatomic,strong) id <NewAddBusinessViewControllerDelegates>delegates;
- (IBAction)ActionOnMenu:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *CategoryTableView;
@property (weak, nonatomic) IBOutlet UIView *CategeryShowView;
- (IBAction)ActionOnCategory:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *CategeryTextFiled;
@property (weak, nonatomic) IBOutlet UITextView *AddressTextFiled;

@property (weak, nonatomic) IBOutlet UITextField *Bussinessemiltextfiled;

@property (weak, nonatomic) IBOutlet UILabel *lbl_AddPictures;
@property (weak, nonatomic) IBOutlet UITextField *facebooktextfiled;

@property (weak, nonatomic) IBOutlet UITextField *BussinesNameText;
@property (weak, nonatomic) IBOutlet UITextField *WeburlTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *SubCategryTextfiled;
@property (weak, nonatomic) IBOutlet UITextField *BussinetTypeTextfiled;
@property (weak, nonatomic) IBOutlet UITextView *DescriptionTextView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView_Images;

@property (weak, nonatomic) IBOutlet UITextField *phonetextfiled;

@property (weak, nonatomic) IBOutlet UITextField *videourl;
@property NSString *lat;
@property NSString *Long;
- (IBAction)btn_Status:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn_Status;

- (IBAction)btn_CloseCategoryView:(id)sender;
- (IBAction)btn_OkCategoryView:(id)sender;
- (IBAction)btn_OkSubCategoryView:(id)sender;
- (IBAction)btn_CancelSubCategoryView:(id)sender;


- (IBAction)ActionOnRegister:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *SubcategoryshowView;
@property (weak, nonatomic) IBOutlet UITableView *SubcategoryTableview;
- (IBAction)ActionOnSubcategory:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *BusinessView;
@property (weak, nonatomic) IBOutlet UITableView *BusinessTableView;
- (IBAction)ActionOnBusiness:(id)sender;

- (IBAction)ActionOnHome:(id)sender;
@property NSString *userlat;
@property NSString *userlong;
@property (nonatomic ,assign) BOOL Isprofile;
@property (nonatomic ,assign) BOOL Isaddimg1;
@property (nonatomic ,assign) BOOL Isaddimg2;
@property (nonatomic ,assign) BOOL Isaddimg3;
@property (nonatomic ,assign) BOOL Isaddimg4;
@property (nonatomic ,assign) BOOL Isaddimg5;
@property (nonatomic ,assign) BOOL Isaddimg6;
@property (nonatomic ,assign) BOOL Isaddimg7;
@property (nonatomic ,assign) BOOL Isaddimg8;
@property (nonatomic ,assign) BOOL Isaddimg9;
@property (nonatomic ,assign) BOOL Isaddimg10;

@property (weak, nonatomic) IBOutlet UILabel *Placeholder;
@property (weak, nonatomic) IBOutlet UITextView *BusinesHoursTextFiled;

@property (weak, nonatomic) IBOutlet UILabel *PlacehoderHoures;

@property (weak, nonatomic) IBOutlet UILabel *placeAddreslable;
@property (weak, nonatomic) IBOutlet UIButton *Addimgebtn1;
@property (weak, nonatomic) IBOutlet UIButton *Addimgebtn2;
@property (weak, nonatomic) IBOutlet UIButton *Addimgebtn3;
@property (weak, nonatomic) IBOutlet UIButton *Addimgebtn4;
@property (weak, nonatomic) IBOutlet UIButton *Addimgebtn5;
@property (weak, nonatomic) IBOutlet UIButton *Addimgebtn6;
@property (weak, nonatomic) IBOutlet UIButton *SentBtnOut;
- (IBAction)ActionOnMapView:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *AddImg1;
@property (weak, nonatomic) IBOutlet UIImageView *AddImg2;
@property (weak, nonatomic) IBOutlet UIImageView *AddImg3;

@property (weak, nonatomic) IBOutlet UIImageView *AddImg4;
@property (weak, nonatomic) IBOutlet UIImageView *AddImg5;

@property (weak, nonatomic) IBOutlet UIImageView *AddImg6;
@property (weak, nonatomic) IBOutlet UIImageView *AddImg7;
@property (weak, nonatomic) IBOutlet UIImageView *AddImg8;

- (IBAction)ActionOnAddImg1:(id)sender;
- (IBAction)ActionOnAddImg2:(id)sender;
- (IBAction)ActionOnAddImg3:(id)sender;
- (IBAction)ActionOnAddImg4:(id)sender;
- (IBAction)ActionOnAddImg5:(id)sender;
- (IBAction)ActionOnAddImg6:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *ActionOnAddImg7;
- (IBAction)ActionOnAddImg7:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *ActionOnAddImg8;
- (IBAction)ActionOnAddImg8:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *AddImg9;
@property (weak, nonatomic) IBOutlet UIButton *ActionOnAddImg9;
- (IBAction)ActionOnAddImg9:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *AddImg10;
@property (weak, nonatomic) IBOutlet UIButton *ActionOnAddImg10;
- (IBAction)ActionOnAddImg10:(id)sender;


@property (weak, nonatomic) IBOutlet UIScrollView *NewScVicw;



@end

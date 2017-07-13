//
//  RegistrationViewController.h
//  All Info
//
//  Created by Mahendra Suryavanshi on 3/3/16.
//  Copyright © 2016 PS.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntrestCatViewController.h"

@interface RegistrationViewController : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UINavigationControllerDelegate,UIScrollViewDelegate>{
    
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

@property (weak, nonatomic) IBOutlet UILabel *lbl_PPassword;
@property (weak, nonatomic) IBOutlet UILabel *lbl_PUserEmail;
@property (weak, nonatomic) IBOutlet UILabel *lbl_PEmail;
@property (weak, nonatomic) IBOutlet UILabel *lbl_PPhone;
@property (weak, nonatomic) IBOutlet UILabel *lbl_PAddress;
@property (weak, nonatomic) IBOutlet UILabel *lbl_PName;
@property (weak, nonatomic) IBOutlet UILabel *lbl_PCategory;
@property (weak, nonatomic) IBOutlet UILabel *lbl_PSubCategory;


@property (weak, nonatomic) IBOutlet UITextField *tf_TblUrl;
@property (weak, nonatomic) IBOutlet UITextField *tf_MenuUrl;
@property BOOL flagIsOpen;
@property int intBusinessHourStatus;

- (IBAction)btn_CloseCategoryView:(id)sender;
- (IBAction)btn_OkCategoryView:(id)sender;
- (IBAction)btn_OkSubCategoryView:(id)sender;
- (IBAction)btn_CancelSubCategoryView:(id)sender;


- (IBAction)ActionOnmenu:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *facebooktextfiled;

- (IBAction)ActionOnBack:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *CategoryTableView;
@property (weak, nonatomic) IBOutlet UIView *CategeryShowView;
- (IBAction)ActionOnCategory:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *CategeryTextFiled;
@property (weak, nonatomic) IBOutlet UITextView *AddressTextFiled;

@property (weak, nonatomic) IBOutlet UITextField *NametextFiled;
@property (weak, nonatomic) IBOutlet UITextField *PasswordTextfiled;
@property (weak, nonatomic) IBOutlet UITextField *EmailtextFiled;

@property (weak, nonatomic) IBOutlet UITextField *Bussinessemiltextfiled;

- (IBAction)ActionOnHome:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *BussinesNameText;
@property (weak, nonatomic) IBOutlet UITextField *WeburlTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *SubCategryTextfiled;
@property (weak, nonatomic) IBOutlet UITextField *BussinetTypeTextfiled;
@property (weak, nonatomic) IBOutlet UITextView *DescriptionTextView;
@property (weak, nonatomic) IBOutlet UITextField *videourl;

@property NSString *userlat;
@property NSString *userlong;

- (IBAction)btn_Status:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn_Status;


@property (weak, nonatomic) IBOutlet UIButton *SubcatBtnOut;

- (IBAction)ActionOnRegister:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *SubcategoryshowView;
@property (weak, nonatomic) IBOutlet UITableView *SubcategoryTableview;
- (IBAction)ActionOnSubcategory:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *BusinessView;
@property (weak, nonatomic) IBOutlet UITableView *BusinessTableView;
- (IBAction)ActionOnBusiness:(id)sender;
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
@property (weak, nonatomic) IBOutlet UIScrollView *RegistScrollView;

@property (weak, nonatomic) IBOutlet UILabel *placehoderLabel;

@property (weak, nonatomic) IBOutlet UIImageView *ProfileImageView;
- (IBAction)ActionOnPicImg:(id)sender;

- (IBAction)ActionOnMapView:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *phonetextfiled;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView_Images;


@property (weak, nonatomic) IBOutlet UIImageView *AddImg1;
@property (weak, nonatomic) IBOutlet UIImageView *AddImg2;
@property (weak, nonatomic) IBOutlet UIImageView *AddImg3;

@property (weak, nonatomic) IBOutlet UIImageView *AddImg4;
@property (weak, nonatomic) IBOutlet UIImageView *AddImg5;

@property (weak, nonatomic) IBOutlet UIImageView *AddImg6;
@property (weak, nonatomic) IBOutlet UIImageView *AddImg7;
@property (weak, nonatomic) IBOutlet UIImageView *AddImg8;
@property (weak, nonatomic) IBOutlet UIImageView *AddImg10;
@property (weak, nonatomic) IBOutlet UIImageView *AddImg9;





- (IBAction)ActionOnAddImg1:(id)sender;
- (IBAction)ActionOnAddImg2:(id)sender;
- (IBAction)ActionOnAddImg3:(id)sender;
- (IBAction)ActionOnAddImg4:(id)sender;
- (IBAction)ActionOnAddImg5:(id)sender;
- (IBAction)ActionOnAddImg6:(id)sender;
- (IBAction)ActionOnAddImg7:(id)sender;
- (IBAction)ActionOnAddImg8:(id)sender;
- (IBAction)ActionOnAddImg9:(id)sender;
- (IBAction)ActionOnAddImg10:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *ProfileImageBtnOut;


@property (weak, nonatomic) IBOutlet UIButton *IbaddBtnout1;

@property (weak, nonatomic) IBOutlet UIButton *IbaddBtnout3;
@property (weak, nonatomic) IBOutlet UIButton *IbaddBtnout2;

@property (weak, nonatomic) IBOutlet UIButton *ResterBtnOut;
@property (weak, nonatomic) IBOutlet UILabel *placehoderLabel2;


@property (weak, nonatomic) IBOutlet UIButton *IbaddBtnout5;
@property (weak, nonatomic) IBOutlet UIButton *IbaddBtnout4;

@property (weak, nonatomic) IBOutlet UIButton *IbaddBtnout6;
@property (weak, nonatomic) IBOutlet UIButton *IbaddBtnout7;
@property (weak, nonatomic) IBOutlet UIButton *IbaddBtnout9;
@property (weak, nonatomic) IBOutlet UIButton *IbaddBtnout10;

@property (weak, nonatomic) IBOutlet UIButton *IbaddBtnout8;


@property (weak, nonatomic) IBOutlet UITextView *BusinesshoursText;
@property (weak, nonatomic) IBOutlet UILabel *PlaceholderLabelh;






@end

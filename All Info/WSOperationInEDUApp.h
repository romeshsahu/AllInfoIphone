//
//  WSOperationInSoloblend.h
//  Soloblend
//
//  Created by  Parkhya Solution on 11/26/14.
//  Copyright (c) 2014 ParkhyaSolutions. All rights reserved.
//
//--- class for stablish connection  device to server.
#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "MBProgressHUD.h"


@interface WSOperationInEDUApp : NSObject<NSURLConnectionDelegate,UINavigationControllerDelegate,UINavigationBarDelegate>
{
    NSMutableData *responseData;
	id _delegate;
	SEL _callback;
    AppDelegate *appDelegate;
    NSString *dateString;
    NSURLConnection *conn;
    NSString *fileName;
    NSDictionary *LoginUserDic;
   // MBProgressHUD *HUD;
}
@property(nonatomic,retain) id _delegate;
@property(nonatomic,assign) SEL _callback;

-(id)initWithDelegate:(id)delegate callback:(SEL)callback;
-(void)Get_category:(NSString *)language_id;
-(void)get_subcategory:(NSString*)category_id;
- (void)getMultipleSubCategoriesfromCatId:(NSArray *) arrCatIds andLanguage:(NSString *) strLan;
-(void)sendmessage:(NSString*)name phone:(NSString*)phone business_id:(NSString*)business_id email_id:(NSString*)email_id message:(NSString*)message;
-(void)get_business_type;
- (void)getLastUpdate;
-(void)addbusinessList:(NSString*)login_id language_id:(NSString*)language_id page_no:(NSString*)page_no limit:(NSString*)limit;


-(void)Login:(NSString*)language_id email:(NSString*)email password:(NSString*)password;
-(void)contact_request:(NSString*)name email:(NSString*)email phone:(NSString*)phone subject:(NSString*)subject message:(NSString*)message;
-(void)Editeprofile:(NSString*)Fname Lname:(NSString*)Lname emilid:(NSString*)emilid  AndImage:(UIImage*)ProfileImage  facebookid:(NSString*)facebookid;
-(void)UserRegistraion:(NSString*)username  email:(NSString*)email password:(NSString*)password  phone:(NSString*)phone address:(NSString*)address latitude:(NSString*)latitude longitude:(NSString*)longitude business_name:(NSString*)business_name business_type_id:(NSString*)business_type_id description:(NSString*)description website_url:(NSString*)website_url sub_cat_id:(NSString*)sub_cat_id user_image:(UIImage*)ProfileImage Addimg1:(UIImage*)Addimg1 Addimg2:(UIImage*)Addimg2 Addimg3:(UIImage*)Addimg3 Addimg4:(UIImage*)Addimg4 Addimg5:(UIImage*)Addimg5 Addimg6:(UIImage*)Addimg6 Addimg7:(UIImage*)Addimg7 Addimg8:(UIImage*)Addimg8 Addimg9:(UIImage*)Addimg9 Addimg10:(UIImage*)Addimg10 business_email:(NSString*)business_email facebook_url:(NSString*)facebook_url video_url:(NSString*)video_url language_id:(NSString*)language_id start_time:(NSString*)start_time end_time:(NSString*)end_time MenuUrl:(NSString *) menuUrl TableUrl:(NSString *) tableUrl BusinessHoursStatus:(NSString *) status PeopleAccessStatus:(NSString *) strPeople ParkingAvailable:(NSString *) strParking;
-(void)searchBusiness:(NSString*)latitude longitude:(NSString*)longitude ;
//-(void)AddbusinessRegi:(NSString*)login_id  phone:(NSString*)phone address:(NSString*)address latitude:(NSString*)latitude longitude:(NSString*)longitude business_name:(NSString*)business_name business_type_id:(NSString*)business_type_id description:(NSString*)description website_url:(NSString*)website_url sub_cat_id:(NSString*)sub_cat_id Addimg1:(UIImage*)Addimg1 Addimg2:(UIImage*)Addimg2 Addimg3:(UIImage*)Addimg3 Addimg4:(UIImage*)Addimg4 Addimg5:(UIImage*)Addimg5 Addimg6:(UIImage*)Addimg6 business_email:(NSString*)business_email facebook_url:(NSString*)facebook_url video_url:(NSString*)video_url ;
    
- (void)AddbusinessRegi:(NSString*)phone login_id:(NSString*)login_id address:(NSString*)address latitude:(NSString*)latitude longitude:(NSString*)longitude business_name:(NSString*)business_name business_type_id:(NSString*)business_type_id description:(NSString*)description website_url:(NSString*)website_url sub_cat_id:(NSString*)sub_cat_id Addimg1:(UIImage*)Addimg1 Addimg2:(UIImage*)Addimg2 Addimg3:(UIImage*)Addimg3 Addimg4:(UIImage*)Addimg4 Addimg5:(UIImage*)Addimg5 Addimg6:(UIImage*)Addimg6 Addimg7:(UIImage*)Addimg7 Addimg8:(UIImage*)Addimg8 Addimg9:(UIImage*)Addimg9 Addimg10:(UIImage*)Addimg10 business_email:(NSString*)business_email facebook_url:(NSString*)facebook_url video_url:(NSString*)video_url language_id:(NSString*)language_id start_time:(NSString*)start_time end_time:(NSString*)end_time MenuUrl:(NSString *) menuUrl TableUrl:(NSString *) tableUrl BusinessHoursStatus:(NSString *) status PeopleAccessStatus:(NSString *) strPeople ParkingAvailable:(NSString *) strParking;

-(void)SlectedbySubId:(NSString*)sub_cat_id language_id:(NSString*)language_id latitude:(NSString*)latitude longitude:(NSString*)longitude;

-(void)readReview:(NSString*)user_id;
-(void)WriteReview:(NSString*)user_id language_id:(NSString*)language_id business_id:(NSString*)business_id name:(NSString*)name comment:(NSString*)comment rating:(NSString*)rating;

-(void)Mapaddess:(NSString*)language input:(NSString*)input key:(NSString*)key ;
-(void)oderResrvation:(NSString*)user_id name:(NSString*)name date:(NSString*)date time:(NSString*)time phone:(NSString*)phone no_of_people:(NSString*)no_of_people message:(NSString*)message;

-(void)GatBusinesid:(NSString*)language ;

- (void)updatebusinessRegi:(NSString*)phone user_id:(NSString*)user_id address:(NSString*)address latitude:(NSString*)latitude longitude:(NSString*)longitude business_name:(NSString*)business_name business_type_id:(NSString*)business_type_id description:(NSString*)description website_url:(NSString*)website_url sub_cat_id:(NSString*)sub_cat_id Addimg1:(UIImage*)Addimg1 Addimg2:(UIImage*)Addimg2 Addimg3:(UIImage*)Addimg3 Addimg4:(UIImage*)Addimg4 Addimg5:(UIImage*)Addimg5 Addimg6:(UIImage*)Addimg6 Addimg7:(UIImage*)Addimg7 Addimg8:(UIImage*)Addimg8 Addimg9:(UIImage*)Addimg9 Addimg10:(UIImage*)Addimg10 business_email:(NSString*)business_email facebook_url:(NSString*)facebook_url video_url:(NSString*)video_url language_id:(NSString*)language_id start_time:(NSString*)start_time end_time:(NSString*)end_time MenuUrl:(NSString *) menuUrl TableUrl:(NSString *) tableUrl BusinessHoursStatus:(NSString *) status PeopleAccessStatus:(NSString *) strPeople ParkingAvailable:(NSString *) strParking;

-(void)GOOGLELogin_action:(NSString*)action social_id:(NSString*)social_id language_id:(NSString*)language_id email:(NSString*)email username:(NSString*)username profile_image:(NSString*)profile_image social_type:(NSString*)social_type;
-(void)FBLogin_action:(NSString*)action social_id:(NSString*)social_id language_id:(NSString*)language_id email:(NSString*)email username:(NSString*)username profile_image:(NSString*)profile_image social_type:(NSString*)social_type;
-(void)share_page_user_id:(NSString*)user_id;
-(void)interest_category_login_id:(NSString*)login_id category_id:(NSString*)category_id device_id:(NSString*)device_id device_type:(NSString*)device_type;
- (void) getInterestedCategories:(NSString *) userid;
- (void) addDeviceInfo:(NSString *) strNotificationId;
//http://allinfo.co.il/all_info/webservice/master.php?action=search&string=קונדיטוריה%20ממתקיי%20אלסראיא&latitude=31.725798&longitude=35.219639

@end

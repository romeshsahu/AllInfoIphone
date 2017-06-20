//
//  NewAddBusinessViewController.m
//  All Info
//
//  Created by iPhones on 5/5/16.
//  Copyright © 2016 PS.com. All rights reserved.
//

#import "NewAddBusinessViewController.h"
#import "MapViewController.h"
#import "MenuViewController.h"
#import "SubcatTableViewCell.h"
#import "WSOperationInEDUApp.h"
#import "UIScrollView+TPKeyboardAvoidingAdditions.h"
#import "AppDelegate.h"
#import "FMDBManager.h"
#import "UIImageView+WebCache.h"
#import "ContectUsViewController.h"
#import "LoginViewController.h"

@interface NewAddBusinessViewController ()<MenuViewControllerDelegates,MapViewControllerDelegates>
{
    NSMutableArray *categrtArray, * arrCategory;
    NSMutableArray *SubcategrtArray;
    NSMutableArray *BusinessArray;
    NSDictionary *categrDic;
    NSDictionary *businessDic;
    NSDictionary *SubcategrtDic;
    NSMutableArray *addcontent, * arrAddCategory, *arrCatId, * arrCatName;
    
    NSMutableArray *sendIdarr;
    NSMutableArray *sendsubname;
    NSString *Bussines_id;
    NSString *SubCateId_id, * strCatId;
    NSString *SubCatename, * strCatName;
    NSString *Catigry_id;
    NSString *sendId;
    NSString *sendnamearr;
    UINavigationController *nav;
    MenuViewController * sample;
    NSDictionary *UserDict;
    NSString *latitude,*longitude;
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    NSString *imageToLoad1;
    NSString *imageToLoad2;
    NSString *imageToLoad3;
    NSString *imageToLoad4;
    NSString *imageToLoad5;
    NSString *imageToLoad6;
    NSString *imageToLoad7;
    NSString *imageToLoad8;
    NSString *imageToLoad9;
    NSString *imageToLoad10;
}

@end

@implementation NewAddBusinessViewController
bool isShownaddbusines;

@synthesize flagIsOpen;

-(void)viewWillAppear:(BOOL)animated
{
    self.intBusinessHourStatus = 1;
    flagIsOpen = YES;
    UserDict =[[NSUserDefaults standardUserDefaults] objectForKey:@"userdata"];
    [self get_busineList];
    sendIdarr=[[NSMutableArray alloc]init];
    sendsubname=[[NSMutableArray alloc]init];
    addcontent=[[NSMutableArray alloc]init];
    arrAddCategory =[[NSMutableArray alloc]init];
    arrCatId =[[NSMutableArray alloc]init];
    arrCatName=[[NSMutableArray alloc]init];
    
}
- (void)viewDidLayoutSubviews
{
    [self.scrollView_Images setContentSize:CGSizeMake(414, 170)];
    
    NSLog(@"self.scrollView_Images = %@", NSStringFromCGSize(self.scrollView_Images.contentSize));
    NSLog(@"self.scrollView_Images = %@", NSStringFromCGRect(self.scrollView_Images.frame));
    
    [ self.NewScVicw setContentSize:CGSizeMake(320, 1420)];
}

- (IBAction)doneClicked:(id)sender
{
    
    [self.CategeryTextFiled resignFirstResponder];
    [self.AddressTextFiled resignFirstResponder];
    [self.Bussinessemiltextfiled resignFirstResponder];
    [self.facebooktextfiled resignFirstResponder];
    [self.BussinesNameText resignFirstResponder];
    [self.WeburlTextFiled resignFirstResponder];
    [self.phonetextfiled resignFirstResponder];
    [self.SubCategryTextfiled resignFirstResponder];
    [self.BusinesHoursTextFiled resignFirstResponder];
    [self.DescriptionTextView resignFirstResponder ];
    [self.videourl resignFirstResponder ];
    [self.tf_TblUrl resignFirstResponder ];
    [self.tf_MenuUrl resignFirstResponder];
    
}
- (void)viewDidLoad {
    
    [self.lbl_PName setHidden:YES];
    [self.lbl_PCategory setHidden:YES];
    [self.lbl_PSubCategory setHidden:YES];
    [self.lbl_PPhone setHidden:YES];
    [self.lbl_PAddress setHidden:YES];
    [self.lbl_PEmail setHidden:YES];
    
    [super viewDidLoad];
    [self.scrollView_Images setContentSize:CGSizeMake(414, 170)];
    [ self.NewScVicw setContentSize:CGSizeMake(320, 1420)];
    
    UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStyleDone target:self action:@selector(doneClicked:)];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
    self.CategeryTextFiled.inputAccessoryView = keyboardDoneButtonView;
    self.AddressTextFiled.inputAccessoryView = keyboardDoneButtonView;
    self.Bussinessemiltextfiled.inputAccessoryView = keyboardDoneButtonView;
    self.facebooktextfiled.inputAccessoryView = keyboardDoneButtonView;
    
    self.BussinesNameText.inputAccessoryView = keyboardDoneButtonView;
    self.WeburlTextFiled.inputAccessoryView = keyboardDoneButtonView;
    self.phonetextfiled.inputAccessoryView = keyboardDoneButtonView;
    self.SubCategryTextfiled.inputAccessoryView = keyboardDoneButtonView;
    self.videourl.inputAccessoryView = keyboardDoneButtonView;
    self.tf_TblUrl.inputAccessoryView = keyboardDoneButtonView;
    self.tf_MenuUrl.inputAccessoryView = keyboardDoneButtonView;
    
    self.BusinesHoursTextFiled.inputAccessoryView = keyboardDoneButtonView;
    self.DescriptionTextView.inputAccessoryView = keyboardDoneButtonView;
    
    
#pragma mark - Edit:
    
    /// For Edit
    if (self.iseditNew==YES) {
        categrtArray = [[NSMutableArray alloc]init];
        SubcategrtArray = [[NSMutableArray alloc]init];
        BusinessArray =[[NSMutableArray alloc]init];
        [self GetcategoryList];
        [self get_busineList];
        
        
        self.lbl_AddPictures.text=NSLocalizedString(@"Add Pictures To Gallery",nil);
        
        flagIsOpen = ! flagIsOpen;
        
        if([self.editbusinesdic[@"is_open"] intValue] == 1) {
            [_btn_Status setBackgroundImage:[UIImage imageNamed:@"open_hours.png"] forState:UIControlStateNormal];
            self.intBusinessHourStatus = 1;
        } else if ([self.editbusinesdic[@"is_open"] intValue] == 2) {
            [_btn_Status setBackgroundImage:[UIImage imageNamed:@"close_hours.png"] forState:UIControlStateNormal];
            self.intBusinessHourStatus = 2;
        }
        
        
        NSLog(@"self.editbusinesdic = %@", self.editbusinesdic);
        
        NSString* userlat1=[self.editbusinesdic objectForKey:@"latitude"];
        if ([userlat1 isEqual:[NSNull null]]) {
            userlat1=@"";
        }else if ([userlat1 isEqual:@""]) {
            userlat1=@"";
        }else if(userlat1 == nil){
            userlat1=@"";
        }else{
            
            if ([userlat1 canBeConvertedToEncoding:NSASCIIStringEncoding]){
                NSData *data = [userlat1 dataUsingEncoding:NSUTF8StringEncoding];
                NSString *string = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding];
                self.userlat=[NSString stringWithFormat:@"%@",string];
            }else{
                self.userlat=[NSString stringWithFormat:@"%@",userlat1];
            }
        }
        
        NSString* userlong1 =[self.editbusinesdic objectForKey:@"longitude"];
        if ([userlong1 isEqual:[NSNull null]]) {
            userlong1=@"";
        }else if ([userlong1 isEqual:@""]) {
            userlong1=@"";
        }else if(userlong1 == nil){
            userlong1=@"";
        }else{
            
            if ([userlong1 canBeConvertedToEncoding:NSASCIIStringEncoding]){
                NSData *data = [userlong1 dataUsingEncoding:NSUTF8StringEncoding];
                NSString *string = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding];
                self.userlong=[NSString stringWithFormat:@"%@",string];
                
            }else{
                self.userlong=[NSString stringWithFormat:@"%@",userlong1];
            }
        }
        
        
        NSString* strUnicodeString=[self.editbusinesdic objectForKey:@"category_name"];
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
                self.CategeryTextFiled.text=[NSString stringWithFormat:@"%@",string];
                
            }else{
                self.CategeryTextFiled.text=[NSString stringWithFormat:@"%@",strUnicodeString];
            }
        }
        
        // Catigry_id=[self.editbusinesdic objectForKey:@"category_id"];
        
        NSArray * arrCateList = [self.editbusinesdic objectForKey:@"category_list"];
        arrCatId = [[NSMutableArray alloc] init];
        arrCatName = [[NSMutableArray alloc] init];
        arrCategory  = [[NSMutableArray alloc] init];
        for (int i = 0; i<arrCateList.count ; i++) {
            NSDictionary * dict = arrCateList[i];
            [arrCatId addObject:dict[@"category_id"]];
            
            NSString* strUnicodeString=[dict objectForKey:@"category_name"];
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
                    [arrCatName addObject:string];
                    //self.CategeryTextFiled.text=[NSString stringWithFormat:@"%@",string];
                    
                }else{
                    [arrCatName addObject:strUnicodeString];
                    self.CategeryTextFiled.text=[NSString stringWithFormat:@"%@",strUnicodeString];
                }
            }
            
            
            
        }
        
        
        for (int j = 0; j < arrCatId.count; j ++) {
            NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
            [dict setObject:arrCatId[j] forKey:@"cat_id"];
            [arrCategory addObject:dict];
        }
        NSLog(@"arrCategory = %@", arrCategory);
        WSOperationInEDUApp *ws=[[WSOperationInEDUApp alloc]initWithDelegate:self callback:@selector(getSelectedSubCategories:)];
        [ws getMultipleSubCategoriesfromCatId:arrCategory andLanguage:@"2"];
        
        
        Catigry_id = [arrCatId componentsJoinedByString:@","];
        self.CategeryTextFiled.text = [arrCatName componentsJoinedByString:@","];
        SubcategrtArray = [[NSMutableArray alloc] init];
        FMDBManager *fm = [[FMDBManager alloc] init];
        [fm openDataBase];
        
        for (int i = 0; i< categrtArray.count; i++) {
            NSMutableDictionary * dictC = categrtArray[i];
            for (int j = 0; j < arrCateList.count ; j++) {
                NSMutableDictionary * dictC1 = arrCateList[j];
                
                if([dictC[@"category_id"] intValue] == [dictC1[@"category_id"] intValue]) {
                    [dictC setObject:@"1" forKey:@"isChecked"];
                    [categrtArray replaceObjectAtIndex:i withObject:dictC];
                }
                
            }
        }
        [self.CategoryTableView reloadData];
        
        
        for (int j = 0; j <arrCatId.count ; j++) {
            
            NSLog(@"arrCatId = %@", arrCatId[j]);
            
            NSArray * arrSC = [fm SubCategryarry:arrCatId[j]];
            NSLog(@"arrSC = %d", (int)arrSC.count);
            
            
            
            [SubcategrtArray addObjectsFromArray:arrSC];
            //[SubcategrtArray arrayByAddingObjectsFromArray:arrSC];
            
            NSLog(@"SubcategrtArray.count in loop = %d", (int) SubcategrtArray.count);
        }
        
        NSMutableArray * arrSC = [[NSMutableArray alloc] init];
        NSLog(@"SubcategrtArray = %d", (int) SubcategrtArray.count);
        for (int i = 0; i < SubcategrtArray.count; i++) {
            NSMutableDictionary * dict = SubcategrtArray[i];
            [dict setObject:@"0" forKey:@"isChecked"];
            
            [arrSC addObject:dict];
        }
        
        SubcategrtArray = arrSC;
        NSLog(@"SubcategrtArray = %@", SubcategrtArray);
        [self.SubcategoryTableview reloadData];
        // SubcategrtArray = [fm SubCategryarry:[self.editbusinesdic objectForKey:@"category_id"]];
        // [self.SubcategoryTableview reloadData];
        // [self subcategiryList];
        self.CategeryShowView.hidden=YES;
        self.BusinessView.hidden=YES;
        NSMutableArray *updatesubcat=[[NSMutableArray alloc]init];
        updatesubcat=[self.editbusinesdic objectForKey:@"sub_category_list"];
        NSMutableArray *subidarr=[[NSMutableArray alloc]init];
        NSMutableArray *subname=[[NSMutableArray alloc]init];
        for (int i=0; i<updatesubcat.count; i++) {
            NSMutableArray *dataarr=[[NSMutableArray alloc]init];
            
            NSMutableDictionary *savendic=[[NSMutableDictionary alloc]init];
            savendic=[updatesubcat objectAtIndex:i];
            NSString *subid=[savendic objectForKey:@"sub_cat_id"];
            BOOL iseual=NO;
            NSLog(@"SubcategrtArray.count = %d", (int) SubcategrtArray.count);
            for (int j=0; j<SubcategrtArray.count; j++) {
                NSMutableDictionary *datedic=[SubcategrtArray objectAtIndex:j];
                
                SubCatename=[datedic objectForKey:@"sub_category_name"];
                SubCateId_id=[datedic objectForKey:@"sub_cat_id"];
                // NSLog(@"%@ SubCatename", SubCateId_id)
                if ([SubCateId_id isEqualToString:subid]) {
                    iseual=YES;
                    //[dataarr addObject:datedic];
                    [subidarr addObject:[datedic objectForKey:@"sub_cat_id"]];
                    [subname addObject:[datedic objectForKey:@"sub_category_name"]];
                    [datedic setObject:@"1" forKey:@"isChecked"];
                    sendId = [subidarr componentsJoinedByString:@","];
                    sendnamearr = [subname componentsJoinedByString:@","];
                    [SubcategrtArray replaceObjectAtIndex:j withObject:datedic];
                }
            }
        }
        NSLog(@"Updated SubcategrtArray = %@", SubcategrtArray);
        [self.SubcategoryTableview reloadData];
        NSLog(@"subname = %@", subname);
        NSString* subn=[subname componentsJoinedByString:@","];
        if ([subn isEqual:[NSNull null]]) {
            subn=@"";
        }else if ([subn isEqual:@""]) {
            subn=@"";
        }else if(subn == nil){
            subn=@"";
        }else{
            if ([subn canBeConvertedToEncoding:NSASCIIStringEncoding]){
                NSData *data = [subn dataUsingEncoding:NSUTF8StringEncoding];
                NSString *string = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding];
                self.SubCategryTextfiled.text =[NSString stringWithFormat:@"%@",string];
                
            }else{
                self.SubCategryTextfiled.text =[NSString stringWithFormat:@"%@",subn];
            }
        }
        
        //        self.SubCategryTextfiled.text = [subname componentsJoinedByString:@","];
        
        
        NSString* Bussinessemilt=[self.editbusinesdic objectForKey:@"business_email"];
        if ([Bussinessemilt isEqual:[NSNull null]]) {
            Bussinessemilt=@"";
        }else if ([Bussinessemilt isEqual:@""]) {
            Bussinessemilt=@"";
        }else if(Bussinessemilt == nil){
            Bussinessemilt=@"";
        }else{
            if ([Bussinessemilt canBeConvertedToEncoding:NSASCIIStringEncoding]){
                NSData *data = [Bussinessemilt dataUsingEncoding:NSUTF8StringEncoding];
                NSString *string = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding];
                self.Bussinessemiltextfiled.text =[NSString stringWithFormat:@"%@",string];
                
            }else{
                self.Bussinessemiltextfiled.text =[NSString stringWithFormat:@"%@",Bussinessemilt];
            }
        }
        
        /// Set the value for menu url
        NSString * strMenuUrl = [self.editbusinesdic objectForKey:@"menu_url"];
        if ([strMenuUrl isEqual:[NSNull null]]) {
            strMenuUrl=@"";
        } else if ([strMenuUrl isEqual:@""]) {
            strMenuUrl=@"";
        } else if(strMenuUrl == nil) {
            strMenuUrl=@"";
        } else {
            if ([strMenuUrl isEqualToString:@""]) {
                strMenuUrl=@"";
            } else {
                [strMenuUrl stringByReplacingOccurrencesOfString:@""
                                                      withString:@""];
                if ([strMenuUrl canBeConvertedToEncoding:NSASCIIStringEncoding]){
                    NSData *data = [strMenuUrl dataUsingEncoding:NSUTF8StringEncoding];
                    NSString *string = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding];
                    self.tf_MenuUrl.text=[NSString stringWithFormat:@"%@",string];
                    
                }else{
                    self.tf_MenuUrl.text=[NSString stringWithFormat:@"%@",strMenuUrl];
                }
            }
        }
        
        /// Sety the value of table Url
        NSString * strTableUrll = [self.editbusinesdic objectForKey:@"table_reservation_url"];
        if ([strTableUrll isEqual:[NSNull null]]) {
            strTableUrll=@"";
        } else if ([strTableUrll isEqual:@""]) {
            strTableUrll=@"";
        } else if(strTableUrll == nil) {
            strTableUrll=@"";
        } else {
            if ([strTableUrll isEqualToString:@""]) {
                strTableUrll=@"";
            } else {
                [strTableUrll stringByReplacingOccurrencesOfString:@""
                                                        withString:@""];
                if ([strTableUrll canBeConvertedToEncoding:NSASCIIStringEncoding]){
                    NSData *data = [strTableUrll dataUsingEncoding:NSUTF8StringEncoding];
                    NSString *string = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding];
                    self.tf_TblUrl.text=[NSString stringWithFormat:@"%@",string];
                    
                }else{
                    self.tf_TblUrl.text=[NSString stringWithFormat:@"%@",strTableUrll];
                }
            }
        }
        
        NSString *phonetext=[self.editbusinesdic objectForKey:@"phone"];
        if ([phonetext isEqual:[NSNull null]]) {
            phonetext=@"";
        }else if ([phonetext isEqual:@""]) {
            phonetext=@"";
        }else if(phonetext == nil){
            phonetext=@"";
        }else{
            if ([phonetext isEqualToString:@""]) {
            }else{
                
                [phonetext stringByReplacingOccurrencesOfString:@""
                                                     withString:@""];
                if ([phonetext canBeConvertedToEncoding:NSASCIIStringEncoding]){
                    NSData *data = [phonetext dataUsingEncoding:NSUTF8StringEncoding];
                    NSString *string = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding];
                    self.phonetextfiled.text=[NSString stringWithFormat:@"%@",string];
                    
                }else{
                    ;
                    self.phonetextfiled.text=[NSString stringWithFormat:@"%@",phonetext];
                }
            }
        }
        
        NSString *BussinesNam=[self.editbusinesdic objectForKey:@"business_name"];
        if ([BussinesNam isEqual:[NSNull null]]) {
            BussinesNam=@"";
        }else if ([BussinesNam isEqual:@""]) {
            BussinesNam=@"";
        }else if(BussinesNam == nil){
            BussinesNam=@"";
        }else{
            if ([BussinesNam isEqualToString:@""]) {
            }else{
                
                [BussinesNam stringByReplacingOccurrencesOfString:@""
                                                       withString:@""];
                if ([BussinesNam canBeConvertedToEncoding:NSASCIIStringEncoding]){
                    NSData *data = [BussinesNam dataUsingEncoding:NSUTF8StringEncoding];
                    NSString *string = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding];
                    self.BussinesNameText.text=[NSString stringWithFormat:@"%@",string];
                    
                }else{
                    ;
                    self.BussinesNameText.text=[NSString stringWithFormat:@"%@",BussinesNam];
                }
            }
        }
        
        
        NSString *Weburl=[self.editbusinesdic objectForKey:@"website_url"];
        if ([Weburl isEqual:[NSNull null]]) {
            Weburl=@"";
        }else if ([Weburl isEqual:@""]) {
            Weburl=@"";
        }else if(Weburl == nil){
            Weburl=@"";
        }else{
            if ([Weburl isEqualToString:@""]) {
            }else{
                
                [Weburl stringByReplacingOccurrencesOfString:@""
                                                  withString:@""];
                if ([Weburl canBeConvertedToEncoding:NSASCIIStringEncoding]){
                    NSData *data = [Weburl dataUsingEncoding:NSUTF8StringEncoding];
                    NSString *string = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding];
                    self.WeburlTextFiled.text=[NSString stringWithFormat:@"%@",string];
                    
                }else{
                    ;
                    self.WeburlTextFiled.text=[NSString stringWithFormat:@"%@",Weburl];
                }
            }
        }
        NSLog(@"b type = %@", [self.editbusinesdic objectForKey:@"business_type"]);
        
        NSString *businessType=[self.editbusinesdic objectForKey:@"business_type"];
        if ([businessType isEqual:[NSNull null]]) {
            businessType=@"";
        }else if ([businessType isEqual:@""]) {
            businessType=@"";
        }else if(businessType == nil){
            businessType=@"";
        } else {
            self.BussinetTypeTextfiled.text=[self.editbusinesdic objectForKey:@"business_type"];
        }
        
        
        
        NSString *videourl=[self.editbusinesdic objectForKey:@"video_url"];
        if ([videourl isEqual:[NSNull null]]) {
            videourl=@"";
        }else if ([videourl isEqual:@""]) {
            videourl=@"";
        }else if(videourl == nil){
            videourl=@"";
        }else{
            if ([videourl isEqualToString:@""]) {
            }else{
                
                [videourl stringByReplacingOccurrencesOfString:@""
                                                    withString:@""];
                if ([videourl canBeConvertedToEncoding:NSASCIIStringEncoding]){
                    NSData *data = [videourl dataUsingEncoding:NSUTF8StringEncoding];
                    NSString *string = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding];
                    self.videourl.text=[NSString stringWithFormat:@"%@",string];
                    
                }else{
                    ;
                    self.videourl.text=[NSString stringWithFormat:@"%@",videourl];
                }
            }
        }
        
        NSString *fburl=[self.editbusinesdic objectForKey:@"facebook_url"];
        if ([fburl isEqual:[NSNull null]]) {
            fburl=@"";
        }else if ([fburl isEqual:@""]) {
            fburl=@"";
        }else if(fburl == nil){
            fburl=@"";
        }else{
            if ([fburl isEqualToString:@""]) {
            }else{
                
                [fburl stringByReplacingOccurrencesOfString:@""
                                                 withString:@""];
                if ([fburl canBeConvertedToEncoding:NSASCIIStringEncoding]){
                    NSData *data = [fburl dataUsingEncoding:NSUTF8StringEncoding];
                    NSString *string = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding];
                    self.facebooktextfiled.text=[NSString stringWithFormat:@"%@",string];
                    
                }else{
                    ;
                    self.facebooktextfiled.text=[NSString stringWithFormat:@"%@",fburl];
                }
            }
        }
        
        NSString *businessTypeId=[self.editbusinesdic objectForKey:@"business_type_id"];
        if ([businessTypeId isEqual:[NSNull null]]) {
            businessTypeId=@"";
        }else if ([businessTypeId isEqual:@""]) {
            businessTypeId=@"";
        }else if(businessTypeId == nil){
            businessTypeId=@"";
        } else {
            
            Bussines_id=[self.editbusinesdic objectForKey:@"business_type_id"];
        }
        NSString *bstime=[self.editbusinesdic objectForKey:@"start_time"];
        if ([bstime isEqual:[NSNull null]]) {
            bstime=@"";
            self.PlacehoderHoures.hidden=NO;
        }else if ([bstime isEqual:@""]) {
            bstime=@"";
            self.PlacehoderHoures.hidden=NO;
        }else if(bstime == nil){
            bstime=@"";
            self.PlacehoderHoures.hidden=NO;
        }else{
            if ([bstime isEqualToString:@""]) {
            }else{
                
                [bstime stringByReplacingOccurrencesOfString:@""
                                                  withString:@""];
                if ([bstime canBeConvertedToEncoding:NSASCIIStringEncoding]){
                    NSData *data = [bstime dataUsingEncoding:NSUTF8StringEncoding];
                    NSString *string = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding];
                    self.BusinesHoursTextFiled.text=[NSString stringWithFormat:@"%@",string];
                    self.PlacehoderHoures.hidden=YES;
                    
                }else{
                    ;
                    self.BusinesHoursTextFiled.text=[NSString stringWithFormat:@"%@",bstime];
                    self.PlacehoderHoures.hidden=YES;
                }
            }
            
        }
        
        
        NSString *newReplacedString=[NSString stringWithFormat:@"%@",[self.editbusinesdic objectForKey:@"description"]];
        NSString * showdescription = [newReplacedString stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
        if ([showdescription isEqualToString:@""]) {
            self.Placeholder.hidden=NO;
        }else{
            
            self.Placeholder.hidden=YES;
            
            if ([showdescription canBeConvertedToEncoding:NSASCIIStringEncoding]){
                NSData *data = [showdescription dataUsingEncoding:NSUTF8StringEncoding];
                NSString *string = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding];
                self.DescriptionTextView.text=[NSString stringWithFormat:@"%@",string];
                self.Placeholder.hidden=YES;
                
            }else{
                self.Placeholder.hidden=YES;
                self.DescriptionTextView.text=[NSString stringWithFormat:@"%@",showdescription];
            }
        }
        
        NSString *showadd=[NSString stringWithFormat:@"%@",[self.editbusinesdic objectForKey:@"address"]];
        if ([showadd isEqual:[NSNull null]]) {
            showadd=@"";
        }else if ([showadd isEqual:@""]) {
            showadd=@"";
        }else if(showadd == nil){
            showadd=@"";
        }else{
            
            if ([showadd isEqualToString:@""]) {
                self.placeAddreslable.hidden=NO;
            }else{
                
                [showadd stringByReplacingOccurrencesOfString:@""
                                                   withString:@""];
                if ([showadd canBeConvertedToEncoding:NSASCIIStringEncoding]){
                    NSData *data = [showadd dataUsingEncoding:NSUTF8StringEncoding];
                    NSString *string = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding];
                    self.AddressTextFiled.text=[NSString stringWithFormat:@"%@",string];
                    self.placeAddreslable.hidden=YES;
                    
                }else{
                    self.placeAddreslable.hidden=YES;
                    self.AddressTextFiled.text=[NSString stringWithFormat:@"%@",showadd];
                }
            }
            
        }
        imageToLoad1 = [self.editbusinesdic objectForKey:@"product_image1"];
        [self.AddImg1 sd_setImageWithURL:[NSURL URLWithString:imageToLoad1] placeholderImage:[UIImage imageNamed:@"ALLINFO_App_registration_n_b screen_profile pic display.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            // URL is as expected, but Image is wrong
        }];
        imageToLoad2 = [self.editbusinesdic objectForKey:@"product_image2"];
        [self.AddImg2 sd_setImageWithURL:[NSURL URLWithString:imageToLoad2] placeholderImage:[UIImage imageNamed:@"ALLINFO_App_registration_n_b screen_profile pic display.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            // URL is as expected, but Image is wrong
        }];
        imageToLoad3 = [self.editbusinesdic objectForKey:@"product_image3"];
        [self.AddImg3 sd_setImageWithURL:[NSURL URLWithString:imageToLoad3] placeholderImage:[UIImage imageNamed:@"ALLINFO_App_registration_n_b screen_profile pic display.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            // URL is as expected, but Image is wrong
        }];
        imageToLoad4 = [self.editbusinesdic objectForKey:@"product_image4"];
        [self.AddImg4 sd_setImageWithURL:[NSURL URLWithString:imageToLoad4] placeholderImage:[UIImage imageNamed:@"ALLINFO_App_registration_n_b screen_profile pic display.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            // URL is as expected, but Image is wrong
        }];
        imageToLoad5= [self.editbusinesdic objectForKey:@"product_image5"];
        [self.AddImg5 sd_setImageWithURL:[NSURL URLWithString:imageToLoad5] placeholderImage:[UIImage imageNamed:@"ALLINFO_App_registration_n_b screen_profile pic display.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            // URL is as expected, but Image is wrong
        }];
        imageToLoad6= [self.editbusinesdic objectForKey:@"product_image6"];
        [self.AddImg6 sd_setImageWithURL:[NSURL URLWithString:imageToLoad6] placeholderImage:[UIImage imageNamed:@"ALLINFO_App_registration_n_b screen_profile pic display.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            // URL is as expected, but Image is wrong
        }];
        
        imageToLoad7= [self.editbusinesdic objectForKey:@"product_image7"];
        [self.AddImg7 sd_setImageWithURL:[NSURL URLWithString:imageToLoad7] placeholderImage:[UIImage imageNamed:@"ALLINFO_App_registration_n_b screen_profile pic display.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            // URL is as expected, but Image is wrong
        }];
        
        imageToLoad8= [self.editbusinesdic objectForKey:@"product_image8"];
        [self.AddImg8 sd_setImageWithURL:[NSURL URLWithString:imageToLoad8] placeholderImage:[UIImage imageNamed:@"ALLINFO_App_registration_n_b screen_profile pic display.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            // URL is as expected, but Image is wrong
        }];
        
        imageToLoad9= [self.editbusinesdic objectForKey:@"product_image9"];
        [self.AddImg9 sd_setImageWithURL:[NSURL URLWithString:imageToLoad9] placeholderImage:[UIImage imageNamed:@"ALLINFO_App_registration_n_b screen_profile pic display.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            // URL is as expected, but Image is wrong
        }];
        
        imageToLoad10= [self.editbusinesdic objectForKey:@"product_image10"];
        [self.AddImg10 sd_setImageWithURL:[NSURL URLWithString:imageToLoad10] placeholderImage:[UIImage imageNamed:@"ALLINFO_App_registration_n_b screen_profile pic display.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            // URL is as expected, but Image is wrong
        }];
        
        
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        UserDict =[[NSUserDefaults standardUserDefaults] objectForKey:@"userdata"];
        
        if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization )]) {
            [locationManager requestWhenInUseAuthorization];
        }
        [locationManager startUpdatingLocation];
        if ([self.Bussinessemiltextfiled respondsToSelector:@selector(setAttributedPlaceholder:)]) {
            UIColor *color = [UIColor lightGrayColor];
            self.CategeryTextFiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"SelectCategory",nil) attributes:@{NSForegroundColorAttributeName: color}];
            self.Bussinessemiltextfiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Business Email",nil) attributes:@{NSForegroundColorAttributeName: color}];
            self.phonetextfiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString: NSLocalizedString(@"Phone",nil) attributes:@{NSForegroundColorAttributeName: color}];
            self.BussinesNameText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Business Name",nil) attributes:@{NSForegroundColorAttributeName: color}];
            self.SubCategryTextfiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Select Sub Category",nil) attributes:@{NSForegroundColorAttributeName: color}];
            self.WeburlTextFiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"WebURL",nil) attributes:@{NSForegroundColorAttributeName: color}];
            self.BussinetTypeTextfiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Business type",nil) attributes:@{NSForegroundColorAttributeName: color}];
            self.videourl.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Video Url",nil) attributes:@{NSForegroundColorAttributeName: color}];
            self.facebooktextfiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString: NSLocalizedString(@"facebook Url",nil) attributes:@{NSForegroundColorAttributeName: color}];
            self.Placeholder.text=NSLocalizedString(@"Description of Business",nil);
            //            [self.Addimgebtn1 setTitle:NSLocalizedString(@"ADD IMAGE",nil) forState:UIControlStateNormal];
            //            [self.Addimgebtn2 setTitle:NSLocalizedString(@"ADD IMAGE",nil) forState:UIControlStateNormal];
            //            [self.Addimgebtn3 setTitle:NSLocalizedString(@"ADD IMAGE",nil) forState:UIControlStateNormal];
            //            [self.Addimgebtn4 setTitle:NSLocalizedString(@"ADD IMAGE",nil) forState:UIControlStateNormal];
            //            [self.Addimgebtn5 setTitle:NSLocalizedString(@"ADD IMAGE",nil) forState:UIControlStateNormal];
            //            [self.Addimgebtn6 setTitle:NSLocalizedString(@"ADD IMAGE",nil) forState:UIControlStateNormal];
            [self.SentBtnOut setTitle:NSLocalizedString(@"Save",nil) forState:UIControlStateNormal];
            
            self.placeAddreslable.text=NSLocalizedString(@"Address",nil);
            self.PlacehoderHoures.text=NSLocalizedString(@"Business hours",nil);
            
            [self.CategoryTableView setSeparatorInset:UIEdgeInsetsZero];
            self.CategoryTableView .tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
            [self.SubcategoryTableview setSeparatorInset:UIEdgeInsetsZero];
            self.SubcategoryTableview .tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
            //            UITapGestureRecognizer *Business =
            //            [[UITapGestureRecognizer alloc] initWithTarget:self
            //                                                    action:@selector(BusinesshandleSingleTap:)];
            // [self.NewScVicw addGestureRecognizer:Business];
            self.BusinessView.layer.masksToBounds = NO;
            self.BusinessView.layer.shadowColor = [UIColor blackColor].CGColor;
            self.BusinessView.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
            self.BusinessView.layer.shadowOpacity = 0.8f;
            self.SubcategoryshowView.layer.masksToBounds = NO;
            self.SubcategoryshowView.layer.shadowColor = [UIColor blackColor].CGColor;
            self.SubcategoryshowView.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
            self.SubcategoryshowView.layer.shadowOpacity = 0.8f;
            
            
        }
    }else{
#pragma mark - Add:
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        UserDict =[[NSUserDefaults standardUserDefaults] objectForKey:@"userdata"];
        
        if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization )]) {
            [locationManager requestWhenInUseAuthorization];
        }
        [locationManager startUpdatingLocation];
        
        if ([self.Bussinessemiltextfiled respondsToSelector:@selector(setAttributedPlaceholder:)]) {
            UIColor *color = [UIColor lightGrayColor];
            self.CategeryTextFiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"SelectCategory",nil) attributes:@{NSForegroundColorAttributeName: color}];
            self.Bussinessemiltextfiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Business Email",nil) attributes:@{NSForegroundColorAttributeName: color}];
            self.phonetextfiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString: NSLocalizedString(@"Phone",nil) attributes:@{NSForegroundColorAttributeName: color}];
            self.BussinesNameText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Business Name",nil) attributes:@{NSForegroundColorAttributeName: color}];
            self.SubCategryTextfiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Select Sub Category",nil) attributes:@{NSForegroundColorAttributeName: color}];
            self.WeburlTextFiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"WebURL",nil) attributes:@{NSForegroundColorAttributeName: color}];
            self.BussinetTypeTextfiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Business type",nil) attributes:@{NSForegroundColorAttributeName: color}];
            self.videourl.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Video Url",nil) attributes:@{NSForegroundColorAttributeName: color}];
            self.facebooktextfiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString: NSLocalizedString(@"facebook Url",nil) attributes:@{NSForegroundColorAttributeName: color}];
            self.tf_MenuUrl.attributedPlaceholder = [[NSAttributedString alloc] initWithString: NSLocalizedString(@"Menu url",nil) attributes:@{NSForegroundColorAttributeName: color}];
            self.tf_TblUrl.attributedPlaceholder = [[NSAttributedString alloc] initWithString: NSLocalizedString(@"Table url",nil) attributes:@{NSForegroundColorAttributeName: color}];
            self.Placeholder.text=NSLocalizedString(@"Description of Business",nil);
            
            //            [self.Addimgebtn1 setTitle:NSLocalizedString(@"ADD IMAGE",nil) forState:UIControlStateNormal];
            //            [self.Addimgebtn2 setTitle:NSLocalizedString(@"ADD IMAGE",nil) forState:UIControlStateNormal];
            //            [self.Addimgebtn3 setTitle:NSLocalizedString(@"ADD IMAGE",nil) forState:UIControlStateNormal];
            //            [self.Addimgebtn4 setTitle:NSLocalizedString(@"ADD IMAGE",nil) forState:UIControlStateNormal];
            //            [self.Addimgebtn5 setTitle:NSLocalizedString(@"ADD IMAGE",nil) forState:UIControlStateNormal];
            //            [self.Addimgebtn6 setTitle:NSLocalizedString(@"ADD IMAGE",nil) forState:UIControlStateNormal];
            [self.SentBtnOut setTitle:NSLocalizedString(@"Send",nil) forState:UIControlStateNormal];
            self.PlacehoderHoures.text=NSLocalizedString(@"Business hours",nil);
            self.placeAddreslable.text=NSLocalizedString(@"Address",nil);
            self.lbl_AddPictures.text=NSLocalizedString(@"Add Pictures To Gallery",nil);
            categrtArray = [[NSMutableArray alloc]init];
            SubcategrtArray = [[NSMutableArray alloc]init];
            BusinessArray =[[NSMutableArray alloc]init];
            [self.CategoryTableView setSeparatorInset:UIEdgeInsetsZero];
            self.CategoryTableView .tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
            [self.SubcategoryTableview setSeparatorInset:UIEdgeInsetsZero];
            self.SubcategoryTableview .tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
            //            UITapGestureRecognizer *Business =
            //            [[UITapGestureRecognizer alloc] initWithTarget:self
            //                                                    action:@selector(BusinesshandleSingleTap:)];
            //            [self.NewScVicw addGestureRecognizer:Business];
            
            self.BusinessView.layer.masksToBounds = NO;
            self.BusinessView.layer.shadowColor = [UIColor blackColor].CGColor;
            self.BusinessView.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
            self.BusinessView.layer.shadowOpacity = 0.8f;
            self.SubcategoryshowView.layer.masksToBounds = NO;
            self.SubcategoryshowView.layer.shadowColor = [UIColor blackColor].CGColor;
            self.SubcategoryshowView.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
            self.SubcategoryshowView.layer.shadowOpacity = 0.8f;
            
            
            //The event handling method
            
            [self GetcategoryList];
            [self get_busineList];
            
        }
        
        
    }
    
    
    
    
    
    // Do any additional setup after loading the view.
}
#pragma mark - Address map delegates


-(void)MapAddress:(NSString *)placeMark La:(NSString *)la log:(NSString *)log
{
    self.placeAddreslable.hidden=YES;
    self.AddressTextFiled.text = [NSString stringWithFormat:@"%@",placeMark];
    if(self.AddressTextFiled.text.length > 0) {
        [self.lbl_PAddress setHidden:YES];
    }
    self.placeAddreslable.hidden=YES;
    self.userlat = [NSString stringWithFormat:@"%@", la];
    self.userlong = [NSString stringWithFormat:@"%@", log];
    
    
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if (self.DescriptionTextView  == textView) {
        NSMutableString *newString=[[NSMutableString alloc]initWithString:self.DescriptionTextView.text];
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
            self.Placeholder.hidden = NO;
        }else if(newString.length>0){
            self.Placeholder.hidden = YES;
            
        }
    }else  if (self.AddressTextFiled==textView) {
        NSMutableString *newString2=[[NSMutableString alloc]initWithString:self.AddressTextFiled.text];
        
        if ([text isEqualToString: @""])
        {
            
            if (newString2.length==0) {
                
            }else{
                
                NSRange ran=NSMakeRange(0, newString2.length-1);
                
                NSString *str=[newString2 stringByReplacingCharactersInRange:ran withString:@""];
                
                NSRange NewRan=[newString2 rangeOfString:str];
                
                
                
                newString2=[newString2 stringByReplacingCharactersInRange:NewRan withString:@""];
            }
        }else{
            [newString2 appendString:text];
        }
        
        
        if ([newString2 isEqualToString:@""]) {
            
            self.placeAddreslable.hidden = NO;
        }else if(newString2.length>0){
            self.PlacehoderHoures.hidden = YES;
        }
    }else if (self.BusinesHoursTextFiled==textView) {
        
        NSMutableString *newString3=[[NSMutableString alloc]initWithString:self.BusinesHoursTextFiled.text];
        
        if ([text isEqualToString: @""])
        {
            
            if (newString3.length==0) {
                
            }else{
                NSRange ran=NSMakeRange(0, newString3.length-1);
                NSString *str=[newString3 stringByReplacingCharactersInRange:ran withString:@""];
                NSRange NewRan=[newString3 rangeOfString:str];
                
                newString3=[newString3 stringByReplacingCharactersInRange:NewRan withString:@""];
            }
        }else{
            [newString3 appendString:text];
        }
        
        if ([newString3 isEqualToString:@""]) {
            self.PlacehoderHoures.hidden = NO;
        }else if(newString3.length>0){
            self.PlacehoderHoures.hidden = YES;
        }
    }
    
    
    if(textView == self.AddressTextFiled) {
        if(self.AddressTextFiled.text.length > 0) {
            [self.lbl_PAddress setHidden:YES];
        }
    }
    
    
    return YES;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:NSLocalizedString(@"Error",nil)
                               message:NSLocalizedString(@"Failed to Get Your Location",nil)
                               delegate:nil
                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
                               otherButtonTitles:nil];
    [errorAlert show];
}
-(CLLocationCoordinate2D) getLocation{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
    CLLocation *location = [locationManager location];
    CLLocationCoordinate2D coordinate = [location coordinate];
    
    return coordinate;
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    currentLocation = [locations objectAtIndex:0];
    [locationManager stopUpdatingLocation];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    CLLocationCoordinate2D coordinate = [self getLocation];
    //self.userlat = [NSString stringWithFormat:@"%f", coordinate.latitude];
    // self.userlong = [NSString stringWithFormat:@"%f", coordinate.longitude];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (void) textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField == self.Bussinessemiltextfiled) {
        if(self.Bussinessemiltextfiled.text.length > 0) {
            [self.lbl_PEmail setHidden:YES];
        }
    } else if (textField == self.phonetextfiled) {
        if(self.phonetextfiled.text.length > 0) {
            [self.lbl_PPhone setHidden:YES];
        }
    } else if (textField == self.BussinesNameText) {
        if(self.BussinesNameText.text.length > 0) {
            [self.lbl_PName setHidden:YES];
        }
    } else if (textField == self.CategeryTextFiled) {
        if(self.CategeryTextFiled.text.length > 0) {
            [self.lbl_PCategory setHidden:YES];
        }
    } else if (textField == self.SubCategryTextfiled) {
        if(self.SubCategryTextfiled.text.length > 0) {
            [self.lbl_PSubCategory setHidden:YES];
        }
    }
    
    return YES;
}

#pragma mark - UITableView DataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.CategoryTableView) {
        return categrtArray.count;
    }else if (tableView==self.SubcategoryTableview){
        return SubcategrtArray.count;
    }else if (tableView==self.BusinessTableView){
        return BusinessArray.count;
    }
    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView==self.CategoryTableView) {
        static NSString *reuseIdentifier=@"SubcatgrryCell";
        
        //        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        //        if (!cell) {
        //            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        //        }
        
        SubcatTableViewCell *cell=[self.SubcategoryTableview dequeueReusableCellWithIdentifier:reuseIdentifier];
        if (!cell) {
            cell=[[SubcatTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        }
        
        categrDic=[categrtArray objectAtIndex:indexPath.row];
        cell.backgroundColor = [UIColor darkGrayColor];
        cell.textLabel.textColor = [UIColor whiteColor];
        
        
        //        cell.textLabel.text=[categrDic objectForKey:@"category_name"];
        //        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        //
        cell.backgroundColor = [UIColor darkGrayColor];
        cell.titallabel.text=[categrDic objectForKey:@"category_name"];
        cell.titallabel.textColor = [UIColor whiteColor];
        cell.titallabel.textAlignment = NSTextAlignmentLeft;
        
        
        if([categrDic[@"isChecked"] intValue] == 0) {
            cell.images.image=[UIImage imageNamed:@"Login_05"];
        } else if([categrDic[@"isChecked"] intValue] == 1){
            cell.images.image=[UIImage imageNamed:@"Login_03"];
        }
        
        
        /*if ([arrAddCategory containsObject:indexPath]) {
         //cell.images.image=[UIImage imageNamed:@"Login_03.png"];
         cell.images.image=[UIImage imageNamed:@"Login_03"];
         } else {
         //cell.images.image=[UIImage imageNamed:@"Login_05.png"];
         cell.images.image=[UIImage imageNamed:@"Login_05"];
         } */
        
        if (self.iseditNew==YES) { }
        
        
        NSLog(@"cell.images = %@", NSStringFromCGRect(cell.images.frame));
        return cell;
    }else if (tableView==self.SubcategoryTableview) {
        static NSString *reuseIdentifier=@"SubcatgrryCell";
        
        SubcatTableViewCell *cell=[self.SubcategoryTableview dequeueReusableCellWithIdentifier:reuseIdentifier];
        if (!cell) {
            cell=[[SubcatTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        }
        SubcategrtDic=[SubcategrtArray objectAtIndex:indexPath.row];
        //NSLog(@"SubcategrtDic = %@", SubcategrtDic);
        cell.backgroundColor = [UIColor darkGrayColor];
        cell.titallabel.text=[SubcategrtDic objectForKey:@"sub_category_name"];
        cell.titallabel.textColor = [UIColor whiteColor];
        cell.titallabel.textAlignment = NSTextAlignmentLeft;
        
        if([SubcategrtDic[@"isChecked"] intValue] == 0) {
            cell.images.image=[UIImage imageNamed:@"Login_05"];
        } else if([SubcategrtDic[@"isChecked"] intValue] == 1){
            cell.images.image=[UIImage imageNamed:@"Login_03"];
        }
        
        
        //        if ([addcontent containsObject:indexPath])
        //        {
        //            cell.images.image=[UIImage imageNamed:@"Login_03.png"];
        //
        //        }else
        //        {
        //           cell.images.image=[UIImage imageNamed:@"Login_05.png"];
        //
        //        }
        return cell;
    }else if (tableView==self.BusinessTableView) {
        static NSString *reuseIdentifier=@"BusinessCell";
        
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        }
        
        businessDic=[BusinessArray objectAtIndex:indexPath.row];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.text=[businessDic objectForKey:@"business_type"];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.backgroundColor = [UIColor darkGrayColor];
        return cell;
    }
    
    return nil;
}

#pragma mark - UITableView Delegates

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView==self.CategoryTableView) {
        categrDic=[categrtArray objectAtIndex:indexPath.row];
        self.CategeryTextFiled.text=[categrDic objectForKey:@"category_name"];
        Catigry_id=[categrDic objectForKey:@"category_id"];
        
        FMDBManager *fm = [[FMDBManager alloc] init];
        [fm openDataBase];
        SubcategrtArray = [fm SubCategryarry:[categrDic objectForKey:@"category_id"]];
        [self.SubcategoryTableview reloadData];
        // [self subcategiryList];
        // self.CategeryShowView.hidden=YES;
        self.BusinessView.hidden=YES;
        
        strCatName=[categrDic objectForKey:@"category_name"];
        strCatId=[categrDic objectForKey:@"category_id"];
        
        NSMutableDictionary * dict = (NSMutableDictionary *)categrDic;
        
        if([categrDic[@"isChecked"] intValue] == 0){
            [dict setObject:@"1" forKey:@"isChecked"];
        } else if ([categrDic[@"isChecked"] intValue] == 1) {
            [dict setObject:@"0" forKey:@"isChecked"];
        }
        
        [categrtArray replaceObjectAtIndex:indexPath.row withObject:dict];
        if ([arrAddCategory containsObject:indexPath]) {
            [arrAddCategory removeObject:indexPath];
            [arrCatId removeObject:strCatId];
            [arrCatName removeObject:strCatName];
        } else {
            [arrAddCategory addObject:indexPath];
            [arrCatId addObject:strCatId];
            [arrCatName addObject:strCatName];
            
        }
        
        [self.CategoryTableView reloadData];
    }else if(tableView==self.SubcategoryTableview){
        //NSString*catid =[SubcategrtArray objectAtIndex:indexPath.row];
        //NSString*catid =[SubcategrtArray objectAtIndex:indexPath.row];
        SubcategrtDic=[SubcategrtArray objectAtIndex:indexPath.row];
        SubCatename=[SubcategrtDic objectForKey:@"sub_category_name"];
        SubCateId_id=[SubcategrtDic objectForKey:@"sub_cat_id"];
        
        NSMutableDictionary * dict = (NSMutableDictionary *)SubcategrtDic;
        
        if([SubcategrtDic[@"isChecked"] intValue] == 0){
            [dict setObject:@"1" forKey:@"isChecked"];
        } else if ([SubcategrtDic[@"isChecked"] intValue] == 1) {
            [dict setObject:@"0" forKey:@"isChecked"];
        }
        
        [SubcategrtArray replaceObjectAtIndex:indexPath.row withObject:dict];
        
        //   NSLog(@"SubcategrtArray setted = %@", SubcategrtArray[indexPath.row]);
        
        if ([addcontent containsObject:indexPath]) {
            [addcontent removeObject:indexPath];
            
            [sendIdarr removeObject:SubCateId_id];
            [sendsubname removeObject:SubCatename];
        } else {
            
            [addcontent addObject:indexPath];
            [sendIdarr addObject:SubCateId_id];
            [sendsubname addObject:SubCatename];
        }
        
        [self.SubcategoryTableview reloadData];
        
        //        SubcategrtDic=[SubcategrtArray objectAtIndex:indexPath.row];
        //        self.SubCategryTextfiled.text=[SubcategrtDic objectForKey:@"sub_category_name"];
        //
        //        SubCateId_id=[categrDic objectForKey:@"sub_cat_id"];
        
        
    }else if(tableView==self.BusinessTableView){
        businessDic=[BusinessArray objectAtIndex:indexPath.row];
        self.BussinetTypeTextfiled.text=[businessDic objectForKey:@"business_type"];
        Bussines_id=[businessDic objectForKey:@"business_type_id"];
        self.CategeryShowView.hidden=YES;
        self.SubcategoryshowView.hidden=YES;
        self.BusinessView.hidden=YES;
        
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
#pragma mark - UIActionSheet delegate

#pragma mark - UIActionSheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag==1) {
        if ([[actionSheet buttonTitleAtIndex:buttonIndex]isEqualToString:@"Take Photo"]) {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.delegate = self;
                picker.allowsEditing = YES;
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:picker animated:YES completion:nil];
                
            }
            else{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Camera Unavailable",nil) message:NSLocalizedString(@"Unable to find a camera on your device.",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK" ,nil)otherButtonTitles:nil, nil];
                [alert show];
                alert = nil;
            }
        }else if ([[actionSheet buttonTitleAtIndex:buttonIndex]isEqualToString:@"Select Photo"]) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            //picker.allowsEditing = NO;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            [self presentViewController:picker animated:YES completion:NULL];
            
        }
    }
}
#pragma mark - ImagePickerDelegate method

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage* SelectedImage = info[UIImagePickerControllerOriginalImage];
    if (self.Isaddimg1==YES){
        self.AddImg1.image = SelectedImage;
    }
    else if (self.Isaddimg2==YES){
        self.AddImg2.image = SelectedImage;
    }
    else if (self.Isaddimg3==YES){
        self.AddImg3.image = SelectedImage;
    }
    else if (self.Isaddimg4==YES){
        self.AddImg4.image = SelectedImage;
    }
    else if (self.Isaddimg5==YES){
        self.AddImg5.image = SelectedImage;
    } else if (self.Isaddimg6==YES){
        self.AddImg6.image = SelectedImage;
    }  else if (self.Isaddimg7==YES){
        self.AddImg7.image = SelectedImage;
    }  else if (self.Isaddimg8==YES){
        self.AddImg8.image = SelectedImage;
    } else if (self.Isaddimg9==YES){
        self.AddImg9.image = SelectedImage;
    } else if (self.Isaddimg10==YES){
        self.AddImg10.image = SelectedImage;
    }
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (IBAction)ActionOnCategory:(id)sender {
    self.CategeryShowView.hidden=NO;
    self.SubcategoryshowView.hidden=YES;
    [self.phonetextfiled resignFirstResponder];
    [self.BussinesNameText resignFirstResponder];
    [self.AddressTextFiled resignFirstResponder];
    [self.BussinetTypeTextfiled resignFirstResponder];
    [self.DescriptionTextView resignFirstResponder];
    [self.WeburlTextFiled resignFirstResponder];
    [self.videourl resignFirstResponder];
    [self.facebooktextfiled resignFirstResponder];
    [self.videourl resignFirstResponder ];
}
- (IBAction)ActionOnSubcategory:(id)sender {
    //  if ([sender isSelected]) {
    //      [sender setSelected: NO];
    
    self.CategeryShowView.hidden=YES;
    self.SubcategoryshowView.hidden=NO;
    self.BusinessView.hidden=YES;
    [self.phonetextfiled resignFirstResponder];
    [self.AddressTextFiled resignFirstResponder];
    [self.BussinetTypeTextfiled resignFirstResponder];
    [self.BussinesNameText resignFirstResponder];
    [self.videourl resignFirstResponder ];
    [self.DescriptionTextView resignFirstResponder];
    [self.WeburlTextFiled resignFirstResponder];
    [self.videourl resignFirstResponder];
    [self.facebooktextfiled resignFirstResponder];
    /* } else {
     [sender setSelected: YES];
     sendId = [sendIdarr componentsJoinedByString:@","];
     self.SubCategryTextfiled.text = [sendsubname componentsJoinedByString:@","];
     self.CategeryShowView.hidden=YES;
     self.SubcategoryshowView.hidden=YES;
     self.BusinessView.hidden=YES;
     [self.AddressTextFiled resignFirstResponder];
     [self.BussinetTypeTextfiled resignFirstResponder];
     [self.phonetextfiled resignFirstResponder];
     [self.BussinesNameText resignFirstResponder];
     [self.DescriptionTextView resignFirstResponder];
     [self.WeburlTextFiled resignFirstResponder];
     [self.videourl resignFirstResponder];
     [self.facebooktextfiled resignFirstResponder];
     } */
    
    
}
- (IBAction)ActionOnBusiness:(id)sender {
    self.CategeryShowView.hidden=YES;
    self.SubcategoryshowView.hidden=YES;
    self.BusinessView.hidden=NO;
    //self.SubcategoryshowView.hidden=NO;
    [self.phonetextfiled resignFirstResponder];
    [self.AddressTextFiled resignFirstResponder];
    [self.BussinetTypeTextfiled resignFirstResponder];
    [self.BussinesNameText resignFirstResponder];
    [self.DescriptionTextView resignFirstResponder];
    [self.WeburlTextFiled resignFirstResponder];
    [self.videourl resignFirstResponder];
    [self.facebooktextfiled resignFirstResponder];
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
- (IBAction)ActionOnPicImg:(id)sender {
    self.Isprofile=YES;
    self.Isaddimg1=NO;
    self.Isaddimg2=NO;
    self.Isaddimg3=NO;
    self.Isaddimg4=NO;
    self.Isaddimg5=NO;
    self.Isaddimg6=NO;
    self.Isaddimg7=NO;
    self.Isaddimg8=NO;
    self.Isaddimg9=NO;
    self.Isaddimg10=NO;
    
    UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Take Photo" otherButtonTitles:@"Select Photo", nil];
    action.tag=1;
    [action showInView:self.view];
}

- (IBAction)ActionOnMapView:(id)sender {
    [self performSegueWithIdentifier:@"MapView" sender:self];
}
- (IBAction)ActionOnAddImg1:(id)sender {
    self.Isprofile=NO;
    self.Isaddimg1=YES;
    self.Isaddimg2=NO;
    self.Isaddimg3=NO;
    self.Isaddimg4=NO;
    self.Isaddimg5=NO;
    self.Isaddimg6=NO;
    self.Isaddimg7=NO;
    self.Isaddimg8=NO;
    self.Isaddimg9=NO;
    self.Isaddimg10=NO;
    UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Take Photo" otherButtonTitles:@"Select Photo", nil];
    action.tag=1;
    [action showInView:self.view];
}

- (IBAction)ActionOnAddImg2:(id)sender {
    self.Isprofile=NO;
    self.Isaddimg1=NO;
    self.Isaddimg2=YES;
    self.Isaddimg3=NO;
    self.Isaddimg4=NO;
    self.Isaddimg5=NO;
    self.Isaddimg6=NO;
    self.Isaddimg7=NO;
    self.Isaddimg8=NO;
    self.Isaddimg9=NO;
    self.Isaddimg10=NO;
    UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Take Photo" otherButtonTitles:@"Select Photo", nil];
    action.tag=1;
    [action showInView:self.view];
}

- (IBAction)ActionOnAddImg3:(id)sender {
    self.Isprofile=NO;
    self.Isaddimg1=NO;
    self.Isaddimg2=NO;
    self.Isaddimg3=YES;
    self.Isaddimg4=NO;
    self.Isaddimg5=NO;
    self.Isaddimg6=NO;
    self.Isaddimg7=NO;
    self.Isaddimg8=NO;
    self.Isaddimg9=NO;
    self.Isaddimg10=NO;
    UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Take Photo" otherButtonTitles:@"Select Photo", nil];
    action.tag=1;
    [action showInView:self.view];
}

- (IBAction)ActionOnAddImg4:(id)sender {
    self.Isprofile=NO;
    self.Isaddimg1=NO;
    self.Isaddimg2=NO;
    self.Isaddimg3=NO;
    self.Isaddimg4=YES;
    self.Isaddimg5=NO;
    self.Isaddimg6=NO;
    self.Isaddimg7=NO;
    self.Isaddimg8=NO;
    self.Isaddimg9=NO;
    self.Isaddimg10=NO;
    UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Take Photo" otherButtonTitles:@"Select Photo", nil];
    action.tag=1;
    [action showInView:self.view];
}

- (IBAction)ActionOnAddImg5:(id)sender {
    self.Isprofile=NO;
    self.Isaddimg1=NO;
    self.Isaddimg2=NO;
    self.Isaddimg3=NO;
    self.Isaddimg4=NO;
    self.Isaddimg5=YES;
    self.Isaddimg6=NO;
    self.Isaddimg7=NO;
    self.Isaddimg8=NO;
    self.Isaddimg9=NO;
    self.Isaddimg10=NO;
    UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Take Photo" otherButtonTitles:@"Select Photo", nil];
    action.tag=1;
    [action showInView:self.view];
}

- (IBAction)ActionOnAddImg6:(id)sender {
    self.Isprofile=NO;
    self.Isaddimg1=NO;
    self.Isaddimg2=NO;
    self.Isaddimg3=NO;
    self.Isaddimg4=NO;
    self.Isaddimg5=NO;
    self.Isaddimg6=YES;
    self.Isaddimg7=NO;
    self.Isaddimg8=NO;
    self.Isaddimg9=NO;
    self.Isaddimg10=NO;
    UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Take Photo" otherButtonTitles:@"Select Photo", nil];
    action.tag=1;
    [action showInView:self.view];
}
-(void)GetcategoryList{
    FMDBManager *fms = [[FMDBManager alloc] init];
    [fms openDataBase];
    //   categrtArray
    
    NSMutableArray * arrCat = [fms Categryarry];
    
    for (int i = 0; i < arrCat.count; i++) {
        NSMutableDictionary * dict = arrCat[i];
        [dict setObject:@"0" forKey:@"isChecked"];
        
        [categrtArray addObject:dict];
    }
    
    
    [self.CategoryTableView reloadData];
}

-(void)Getcategory:(id)response
{
    @try {
        NSDictionary *responseDic=response;
        if ([response isKindOfClass:[NSDictionary class]]) {
            if ([[responseDic objectForKey:@"message"]isEqualToString:@"success"]) {
                NSMutableArray * arrCat =[responseDic objectForKey:@"result"];
                
                
                
                for (int i = 0; i < arrCat.count; i++) {
                    NSMutableDictionary * dict = arrCat[i];
                    [dict setObject:@"0" forKey:@"isChecked"];
                    
                    [categrtArray addObject:dict];
                }
                
            }
            [self.CategoryTableView reloadData];
        }
        
    } @catch (NSException *exception) {
        NSLog(@"exception....%@",exception);
    }
}
-(void)subcategiryList{
    WSOperationInEDUApp *ws=[[WSOperationInEDUApp alloc]initWithDelegate:self callback:@selector(subcategiry:)];
    
    [ws get_subcategory:Catigry_id];
    
}

-(void)subcategiry:(id)response
{
    NSDictionary *responseDic=response;
    if ([response isKindOfClass:[NSDictionary class]]) {
        if ([[responseDic objectForKey:@"message"]isEqualToString:@"success"]) {
            NSMutableArray * arrSubCat  =[responseDic objectForKey:@"result"];
            
            for (int i = 0; i < arrSubCat.count; i++) {
                NSMutableDictionary * dict = arrSubCat[i];
                [dict setObject:@"0" forKey:@"isChecked"];
                
                [SubcategrtArray addObject:dict];
            }
            
        }
        [self.SubcategoryTableview reloadData];
    }
}
-(void)get_busineList{
    WSOperationInEDUApp *ws=[[WSOperationInEDUApp alloc]initWithDelegate:self callback:@selector(getbusinesstype:)];
    [ws GatBusinesid:@"2"];
    
    //FMDBManager *fm = [[FMDBManager alloc] init];
    //[fm openDataBase];
    //BusinessArray = [fm getBusinessarr];
    //[self.BusinessTableView reloadData];
}

-(void)getbusinesstype:(id)response
{
    NSDictionary *responseDic=response;
    if ([response isKindOfClass:[NSDictionary class]]) {
        if ([[responseDic objectForKey:@"message"]isEqualToString:@"success"]) {
            BusinessArray=[responseDic objectForKey:@"result"];
        }
        [self.BusinessTableView reloadData];
    }
}
#pragma mark - Email Validation

//-(BOOL)EmailCheck:(NSString*)sender
//{
//    NSString *emailRegex = @"[a-zA-Z0-9._-]+@[a-z_-]+\\.+[a-z]+";
//    NSPredicate *emailValidation = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
//    if (![emailValidation evaluateWithObject:sender]) {
//        return NO;
//    }
//    return YES;
//}
-(BOOL)EmailCheck:(NSString*)sender
{
    // NSString *emailRegex = @"[a-zA-Z0-9._-]+@[a-z_-]+\\.+[a-z]+";
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailValidation = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    if (![emailValidation evaluateWithObject:self.Bussinessemiltextfiled.text]) {
        return NO;
    }
    return YES;
}

- (IBAction)btn_Status:(id)sender {
    
    if(flagIsOpen) {
        [_btn_Status setBackgroundImage:[UIImage imageNamed:@"close_hours.png"] forState:UIControlStateNormal];
        self.intBusinessHourStatus = 2;
    } else {
        [_btn_Status setBackgroundImage:[UIImage imageNamed:@"open_hours.png"] forState:UIControlStateNormal];
        self.intBusinessHourStatus = 1;
    }
    
    flagIsOpen = !flagIsOpen;
}

- (IBAction)btn_CloseCategoryView:(id)sender {
    self.CategeryShowView.hidden = YES;
}

- (IBAction)btn_OkCategoryView:(id)sender {
    arrCategory = [[NSMutableArray alloc] init];
    Catigry_id =    [arrCatId componentsJoinedByString:@","];//[categrDic objectForKey:@"category_id"];
    
    for (int j = 0; j < arrCatId.count; j ++) {
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
        [dict setObject:arrCatId[j] forKey:@"cat_id"];
        [arrCategory addObject:dict];
    }
    NSLog(@"arrCategory = %@", arrCategory);
    WSOperationInEDUApp *ws=[[WSOperationInEDUApp alloc]initWithDelegate:self callback:@selector(getSubCategories:)];
    [ws getMultipleSubCategoriesfromCatId:arrCategory andLanguage:@"2"];
    
    //[self getMSD:arrCategory andLang:@"2"];
    
    /*
     FMDBManager *fm = [[FMDBManager alloc] init];
     [fm openDataBase];
     
     
     SubcategrtArray = [[NSMutableArray alloc] init];
     for (int i = 0; i < arrCatId.count; i++) {
     NSMutableArray * arrSubCat =     [fm SubCategryarry:arrCatId[i]];
     
     for (int i = 0; i < arrSubCat.count; i++) {
     NSMutableDictionary * dict = arrSubCat[i];
     [dict setObject:@"0" forKey:@"isChecked"];
     
     [SubcategrtArray addObject:dict];
     }
     */
    // [SubcategrtArray addObjectsFromArray:arrSubCat];
    // }
    
    [self.SubcategoryTableview reloadData];
    
    self.CategeryTextFiled.text = [arrCatName componentsJoinedByString:@","];
    
    if(self.CategeryTextFiled.text.length > 0) {
        [self.lbl_PCategory setHidden:YES];
    }
    
    self.CategeryShowView.hidden = YES;
}

- (void) getSubCategories:(id)response {
    NSMutableDictionary *responseDic=response;
    NSLog(@"responseDic = %@", responseDic);
    if ([response isKindOfClass:[NSDictionary class]]) {
        if ([[responseDic objectForKey:@"message"]isEqualToString:@"success"]) {
            NSMutableArray * arrSubCat =     [responseDic[@"result"] mutableCopy];
            
            for (int i = 0; i < arrSubCat.count; i++) {
                NSMutableDictionary * dict = [arrSubCat[i] mutableCopy];
                [dict setObject:@"0" forKey:@"isChecked"];
                
                [SubcategrtArray addObject:dict];
            }
            [self.SubcategoryTableview reloadData];
        }
    }
}

- (void) getSelectedSubCategories:(id)response {
    NSMutableDictionary *responseDic=response;
    NSLog(@"responseDic = %@", responseDic);
    if ([response isKindOfClass:[NSDictionary class]]) {
        if ([[responseDic objectForKey:@"message"]isEqualToString:@"success"]) {
            NSMutableArray * arrSubCat =     [responseDic[@"result"] mutableCopy];
            
            for (int i = 0; i < arrSubCat.count; i++) {
                NSMutableDictionary * dict = [arrSubCat[i] mutableCopy];
                [dict setObject:@"0" forKey:@"isChecked"];
                
                [SubcategrtArray addObject:dict];
            }
            
            NSMutableArray *updatesubcat=[[NSMutableArray alloc]init];
            updatesubcat=[self.editbusinesdic objectForKey:@"sub_category_list"];
            NSMutableArray *subidarr=[[NSMutableArray alloc]init];
            NSMutableArray *subname=[[NSMutableArray alloc]init];
            for (int i=0; i<updatesubcat.count; i++) {
                NSMutableArray *dataarr=[[NSMutableArray alloc]init];
                
                NSMutableDictionary *savendic=[[NSMutableDictionary alloc]init];
                savendic=[updatesubcat objectAtIndex:i];
                NSString *subid=[savendic objectForKey:@"sub_cat_id"];
                BOOL iseual=NO;
                NSLog(@"SubcategrtArray.count = %d", (int) SubcategrtArray.count);
                for (int j=0; j<SubcategrtArray.count; j++) {
                    NSMutableDictionary *datedic=[SubcategrtArray objectAtIndex:j];
                    
                    SubCatename=[datedic objectForKey:@"sub_category_name"];
                    SubCateId_id=[datedic objectForKey:@"sub_cat_id"];
                    // NSLog(@"%@ SubCatename", SubCateId_id)
                    if ([SubCateId_id isEqualToString:subid]) {
                        iseual=YES;
                        //[dataarr addObject:datedic];
                        [subidarr addObject:[datedic objectForKey:@"sub_cat_id"]];
                        [subname addObject:[datedic objectForKey:@"sub_category_name"]];
                        [datedic setObject:@"1" forKey:@"isChecked"];
                        sendId = [subidarr componentsJoinedByString:@","];
                        sendnamearr = [subname componentsJoinedByString:@","];
                        [SubcategrtArray replaceObjectAtIndex:j withObject:datedic];
                    }
                }
            }
            
            
            
            [self.SubcategoryTableview reloadData];
        }
    }
}


- (IBAction)btn_OkSubCategoryView:(id)sender {
    NSLog(@"sendIdarr = %d", (int)sendIdarr.count);
    sendId = [sendIdarr componentsJoinedByString:@","];
    
    self.SubCategryTextfiled.text = [sendsubname componentsJoinedByString:@","];
    if(self.SubCategryTextfiled.text.length > 0) {
        [self.lbl_PSubCategory setHidden:YES];
    }
    self.SubcategoryshowView.hidden=YES;
}

- (IBAction)btn_CancelSubCategoryView:(id)sender {
    self.SubcategoryshowView.hidden=YES;
}

-(NSMutableAttributedString *)setColorForText:(NSString*) textToFind originalText:(NSString *)originalString withColor:(UIColor*)color {
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:originalString];
    NSRange range = [originalString rangeOfString:textToFind];
    NSLog(@"range = %d", (int)range.length);
    [attString addAttribute:NSForegroundColorAttributeName value:color range:range];
    NSLog(@"attString = %@", attString);
    
    if (range.location != NSNotFound) {
        [attString addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
    
    NSLog(@"attstr - %@", [NSString stringWithFormat:@"%@", attString.string]);
    return attString;
    
}


- (IBAction)ActionOnRegister:(id)sender {
    if (self.Bussinessemiltextfiled.text.length==0){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Fill Business Email Field",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
        [alert show];
        
        [self.lbl_PEmail setHidden:NO];
        
    }else if (![self EmailCheck:self.Bussinessemiltextfiled.text]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Fill valid Email Field",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
        [alert show];
        
        [self.lbl_PEmail setHidden:NO];
        
    }else if (self.phonetextfiled.text.length==0){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Fill Phone Field",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
        [alert show];
        [self.lbl_PPhone setHidden:NO];
        
        
    }else if (self.AddressTextFiled.text.length==0){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Fill Address Field",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
        [alert show];
        [self.lbl_PAddress setHidden:NO];
        
    }else if (self.BussinesNameText.text.length==0){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Fill Business Name  Field",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
        [alert show];
        [self.lbl_PName setHidden:NO];
        
        
    }else if (self.CategeryTextFiled.text.length==0){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Select Category",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
        [alert show];
        [self.lbl_PCategory setHidden:NO];
        
        
    }else if (self.SubCategryTextfiled.text.length==0){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Select Sub Category",nil)message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
        [alert show];
        
        [self.lbl_PSubCategory setHidden:NO];
    }
    
    else{
        NSLog(@"_intBusinessHourStatus =  %d", self.intBusinessHourStatus);
        
        if (Bussines_id.length == 0) {
            if(BusinessArray.count > 0) {
                businessDic=[BusinessArray objectAtIndex:0];
                self.BussinetTypeTextfiled.text=[businessDic objectForKey:@"business_type"];
                Bussines_id=[businessDic objectForKey:@"business_type_id"];
            }
            
        }
        
        if (self.iseditNew==YES)
        {
            WSOperationInEDUApp *ws=[[WSOperationInEDUApp alloc]initWithDelegate:self callback:@selector(Register:)];
            [ws updatebusinessRegi:self.phonetextfiled.text
                           user_id:[self.editbusinesdic objectForKey:@"user_id"]
                           address:self.AddressTextFiled.text
                          latitude:_userlat
                         longitude:_userlong
                     business_name:self.BussinesNameText.text
                  business_type_id:Bussines_id
                       description:self.DescriptionTextView.text
                       website_url:self.WeburlTextFiled.text
                        sub_cat_id:sendId
                           Addimg1:self.AddImg1.image
                           Addimg2:self.AddImg2.image
                           Addimg3:self.AddImg3.image
                           Addimg4:self.AddImg4.image
                           Addimg5:self.AddImg5.image
                           Addimg6:self.AddImg6.image
                           Addimg7:self.AddImg7.image
                           Addimg8:self.AddImg8.image
                           Addimg9:self.AddImg9.image
                          Addimg10:self.AddImg10.image
                    business_email:self.Bussinessemiltextfiled.text
                      facebook_url:self.facebooktextfiled.text
                         video_url:self.videourl.text
                       language_id:@"2"
                        start_time:self.BusinesHoursTextFiled.text
                          end_time:@"0"
                           MenuUrl:_tf_MenuUrl.text
                          TableUrl:_tf_TblUrl.text
               BusinessHoursStatus:[NSString stringWithFormat:@"%d",
                                    self.intBusinessHourStatus]];
        }
        else
        {
            UIImage *secondImage = [UIImage imageNamed:@"ALLINFO_App_registration_n_b screen_profile pic display.png"];
            WSOperationInEDUApp *ws=[[WSOperationInEDUApp alloc]initWithDelegate:self callback:@selector(Register:)];
            
            [ws AddbusinessRegi:self.phonetextfiled.text
                       login_id:[UserDict objectForKey:@"login_id"]
                        address:self.AddressTextFiled.text
                       latitude:_userlat
                      longitude:_userlong
                  business_name:self.BussinesNameText.text
               business_type_id:Bussines_id
                    description:self.DescriptionTextView.text
                    website_url:self.WeburlTextFiled.text
                     sub_cat_id:sendId
                        Addimg1:self.AddImg1.image
                        Addimg2:self.AddImg2.image
                        Addimg3:self.AddImg3.image
                        Addimg4:self.AddImg4.image
                        Addimg5:self.AddImg5.image
                        Addimg6:self.AddImg6.image
                        Addimg7:self.AddImg7.image
                        Addimg8:self.AddImg8.image
                        Addimg9:self.AddImg9.image
                       Addimg10:self.AddImg10.image
                 business_email:self.Bussinessemiltextfiled.text
                   facebook_url:self.facebooktextfiled.text
                      video_url:self.videourl.text
                    language_id:@"2"
                     start_time:self.BusinesHoursTextFiled.text
                       end_time:@"0"
                        MenuUrl:_tf_MenuUrl.text
                       TableUrl:_tf_TblUrl.text
            BusinessHoursStatus:[NSString stringWithFormat:@"%d", self.intBusinessHourStatus]];
        }
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==1) {
        if (buttonIndex == 0){
            
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"login"];
            
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"userdata"];
            
            
            //login
        }
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
            //            RegistrationViewController *registerView = [self.storyboard instantiateViewControllerWithIdentifier:@"RegistrationViewController"];
            //            registerView.tabBarController.tabBar.hidden = YES;
            //            [self.navigationController pushViewController:registerView animated:YES];
        }
            break;
        case 3:
            
            break;
        case 4:
            
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
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Alert",nil) message:NSLocalizedString(@"Are you sure you want to logout?",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:NSLocalizedString(@"Cancel",nil), nil];
            alert.tag=1;
            [alert show];
        }
            
            break;
        case 7:
        {
            UserDict =[[NSUserDefaults standardUserDefaults] objectForKey:@"userdata"];
            if (UserDict == nil) {
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Alert",nil) message:NSLocalizedString(@"Please login first",nil) preferredStyle:UIAlertControllerStyleAlert];
                
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
            
            
        default:
            break;
    }
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
    [self.phonetextfiled resignFirstResponder];
    [self.AddressTextFiled resignFirstResponder];
    [self.BussinetTypeTextfiled resignFirstResponder];
    [self.BussinesNameText resignFirstResponder];
    [self.DescriptionTextView resignFirstResponder];
    [self.WeburlTextFiled resignFirstResponder];
    [self.videourl resignFirstResponder];
    [self.facebooktextfiled resignFirstResponder];
    CATransition *transition = [CATransition animation];
    transition.duration = 1;
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromRight;
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [sample.view.layer addAnimation:transition forKey:nil];
    [sample.view removeFromSuperview];
    
    
    isShownaddbusines = false;
}

-(void)Register:(id)response
{
    
    NSDictionary *responseDic=response;
    if ([response isKindOfClass:[NSDictionary class]]) {
        if ([[responseDic objectForKey:@"message"]isEqualToString:@"success"]) {
            NSDictionary *imagedic=[responseDic objectForKey:@"image_array"];
            if(imagedic == NULL){
                NSString*img1=[imagedic objectForKey:@"product_image1"];
                NSString*img2=[imagedic objectForKey:@"product_image2"];
                NSString*img3=[imagedic objectForKey:@"product_image3"];
                NSString*img4=[imagedic objectForKey:@"product_image4"];
                NSString*img5=[imagedic objectForKey:@"product_image5"];
                NSString*img6=[imagedic objectForKey:@"product_image6"];
                
                NSString*img7=[imagedic objectForKey:@"product_image7"];
                NSString*img8=[imagedic objectForKey:@"product_image8"];
                NSString*img9=[imagedic objectForKey:@"product_image9"];
                NSString*img10=[imagedic objectForKey:@"product_image10"];
                
                
                FMDBManager *fm = [[FMDBManager alloc] init];
                [fm openDataBase];
                [fm updateFave:[self.editbusinesdic objectForKey:@"user_id"]address:self.AddressTextFiled.text business_name:self.BussinesNameText.text business_type:self.BussinetTypeTextfiled.text business_type_id:Bussines_id category_id:Catigry_id category_name:self.CategeryTextFiled.text create_date:[self.editbusinesdic objectForKey:@"create_date"] description:self.DescriptionTextView.text distance:@"" email:self.Bussinessemiltextfiled.text end_time:@"0" facebook_url:self.facebooktextfiled.text   language_id:@"2" latitude:self.userlat longitude:self.userlong phone:self.phonetextfiled.text product_image1:img1 product_image2:img2 product_image3:img3 product_image4:img4 product_image5:img5 product_image6:img6 product_image7:img7 product_image8:img8 product_image9:img9 product_image10:img10 rating:[self.editbusinesdic objectForKey:@"rating"] start_time:self.BusinesHoursTextFiled.text user_image:[UserDict objectForKey:@"user_image"] username:[UserDict objectForKey:@"username"] website_url:self.WeburlTextFiled.text video_url:self.videourl.text];
                [fm updatehistory:[self.editbusinesdic objectForKey:@"user_id"]address:self.AddressTextFiled.text business_name:self.BussinesNameText.text business_type:self.BussinetTypeTextfiled.text business_type_id:Bussines_id category_id:Catigry_id category_name:self.CategeryTextFiled.text create_date:[self.editbusinesdic objectForKey:@"create_date"] description:self.DescriptionTextView.text distance:@"" email:self.Bussinessemiltextfiled.text end_time:@"0" facebook_url:self.facebooktextfiled.text   language_id:@"2" latitude:self.userlat longitude:self.userlong phone:self.phonetextfiled.text product_image1:img1 product_image2:img2 product_image3:img3 product_image4:img4 product_image5:img5 product_image6:img6 product_image7:img7 product_image8:img8 product_image9:img9 product_image10:img10  rating:[self.editbusinesdic objectForKey:@"rating"] start_time:self.BusinesHoursTextFiled.text user_image:[UserDict objectForKey:@"user_image"] username:[UserDict objectForKey:@"username"] website_url:self.WeburlTextFiled.text video_url:self.videourl.text];
                [self.delegates callweb];
                [[NSUserDefaults standardUserDefaults]setObject:@"Yes" forKey:@"upda"];
                [self .navigationController popViewControllerAnimated:YES];
            }else{
                NSString*img1=@"";
                NSString*img2=@"";
                NSString*img3=@"";
                NSString*img4=@"";
                NSString*img5=@"";
                NSString*img6=@"";
                
                NSString*img7=@"";
                NSString*img8=@"";
                NSString*img9=@"";
                NSString*img10=@"";
                
                FMDBManager *fm = [[FMDBManager alloc] init];
                [fm openDataBase];
                [fm updateFave:[self.editbusinesdic objectForKey:@"user_id"]address:self.AddressTextFiled.text business_name:self.BussinesNameText.text business_type:self.BussinetTypeTextfiled.text business_type_id:Bussines_id category_id:Catigry_id category_name:self.CategeryTextFiled.text create_date:[self.editbusinesdic objectForKey:@"create_date"] description:self.DescriptionTextView.text distance:@"" email:self.Bussinessemiltextfiled.text end_time:@"0" facebook_url:self.facebooktextfiled.text   language_id:@"2" latitude:self.userlat longitude:self.userlong phone:self.phonetextfiled.text product_image1:img1 product_image2:img2 product_image3:img3 product_image4:img4 product_image5:img5 product_image6:img6 product_image7:img7 product_image8:img8 product_image9:img9 product_image10:img10  rating:[self.editbusinesdic objectForKey:@"rating"] start_time:self.BusinesHoursTextFiled.text user_image:[UserDict objectForKey:@"user_image"] username:[UserDict objectForKey:@"username"] website_url:self.WeburlTextFiled.text video_url:self.videourl.text];
                [fm updatehistory:[self.editbusinesdic objectForKey:@"user_id"]address:self.AddressTextFiled.text business_name:self.BussinesNameText.text business_type:self.BussinetTypeTextfiled.text business_type_id:Bussines_id category_id:Catigry_id category_name:self.CategeryTextFiled.text create_date:[self.editbusinesdic objectForKey:@"create_date"] description:self.DescriptionTextView.text distance:@"" email:self.Bussinessemiltextfiled.text end_time:@"0" facebook_url:self.facebooktextfiled.text   language_id:@"2" latitude:self.userlat longitude:self.userlong phone:self.phonetextfiled.text product_image1:img1 product_image2:img2 product_image3:img3 product_image4:img4 product_image5:img5 product_image6:img6 product_image7:img7 product_image8:img8 product_image9:img9 product_image10:img10  rating:[self.editbusinesdic objectForKey:@"rating"] start_time:self.BusinesHoursTextFiled.text user_image:[UserDict objectForKey:@"user_image"] username:[UserDict objectForKey:@"username"] website_url:self.WeburlTextFiled.text video_url:self.videourl.text];
                [self.delegates callweb];
                [[NSUserDefaults standardUserDefaults]setObject:@"Yes" forKey:@"upda"];
                [self .navigationController popViewControllerAnimated:YES];
            }
        }
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

- (IBAction)ActionOnback:(id)sender {
    [self .navigationController popViewControllerAnimated:YES];
}

- (IBAction)ActionOnMenu:(id)sender {
    if (!isShownaddbusines) {
        
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
        
        isShownaddbusines = true;
        
    } else {
        
        CATransition *transition = [CATransition animation];
        transition.duration =0.5;
        transition.type = kCATransitionReveal;
        transition.subtype = kCATransitionFromRight;
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [sample.view.layer addAnimation:transition forKey:nil];
        [sample.view performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.5];
        
        isShownaddbusines = false;
    }
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    //([segue.identifier isEqualToString:@"Exiscixe"])
    if ([segue.identifier isEqualToString:@"MapView"]) {
        MapViewController *MapView = segue.destinationViewController;
        MapView.delegates = self;
        MapView.isaddnew=YES;
        
    }
}
- (IBAction)ActionOnAddImg7:(id)sender {
    self.Isprofile=NO;
    self.Isaddimg1=NO;
    self.Isaddimg2=NO;
    self.Isaddimg3=NO;
    self.Isaddimg4=NO;
    self.Isaddimg5=NO;
    self.Isaddimg6=NO;
    self.Isaddimg7=YES;
    self.Isaddimg8=NO;
    self.Isaddimg9=NO;
    self.Isaddimg10=NO;
    UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Take Photo" otherButtonTitles:@"Select Photo", nil];
    action.tag=1;
    [action showInView:self.view];
}
- (IBAction)ActionOnAddImg8:(id)sender {
    self.Isprofile=NO;
    self.Isaddimg1=NO;
    self.Isaddimg2=NO;
    self.Isaddimg3=NO;
    self.Isaddimg4=NO;
    self.Isaddimg5=NO;
    self.Isaddimg6=NO;
    self.Isaddimg7=NO;
    self.Isaddimg8=YES;
    self.Isaddimg9=NO;
    self.Isaddimg10=NO;
    UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Take Photo" otherButtonTitles:@"Select Photo", nil];
    action.tag=1;
    [action showInView:self.view];
}
- (IBAction)ActionOnAddImg9:(id)sender {
    self.Isprofile=NO;
    self.Isaddimg1=NO;
    self.Isaddimg2=NO;
    self.Isaddimg3=NO;
    self.Isaddimg4=NO;
    self.Isaddimg5=NO;
    self.Isaddimg6=NO;
    self.Isaddimg7=NO;
    self.Isaddimg8=NO;
    self.Isaddimg9=YES;
    self.Isaddimg10=NO;
    UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Take Photo" otherButtonTitles:@"Select Photo", nil];
    action.tag=1;
    [action showInView:self.view];
}
- (IBAction)ActionOnAddImg10:(id)sender {
    self.Isprofile=NO;
    self.Isaddimg1=NO;
    self.Isaddimg2=NO;
    self.Isaddimg3=NO;
    self.Isaddimg4=NO;
    self.Isaddimg5=NO;
    self.Isaddimg6=NO;
    self.Isaddimg7=NO;
    self.Isaddimg8=NO;
    self.Isaddimg9=NO;
    self.Isaddimg10=YES;
    UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Take Photo" otherButtonTitles:@"Select Photo", nil];
    action.tag=1;
    [action showInView:self.view];
}



- (void) getMSD:(NSArray *) arr andLang:(NSString *) str{
    NSError * error;
    NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:&error];
    NSString *strJsonArr = [[NSString alloc] initWithData:jsonData2 encoding:NSUTF8StringEncoding];
    
    NSLog(@"strJsonArr = %@", strJsonArr);
    
    NSString *body=[NSString stringWithFormat:@"category_id=%@&language_id=%@", strJsonArr, str];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
    
    NSData *data=[body dataUsingEncoding:NSUTF8StringEncoding];
    [request setURL:[NSURL URLWithString:@"http://allinfo.co.il/all_info/webservice/master.php?action=all_subcategory"]];
    
    
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    // [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:data];
    
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        NSLog(@"requestReply: %@", requestReply);
        NSLog(@"response: %@", response);
        NSDictionary * ddd = response;
        NSLog(@"ddd: %@", ddd);
        
    }] resume];
}

@end


//
//  RegistrationViewController.m
//  All Info
//
//  Created by Mahendra Suryavanshi on 3/3/16.
//  Copyright © 2016 PS.com. All rights reserved.
//
#import "LocationViewController.h"
#import "RegistrationViewController.h"
#import "MapViewController.h"
#import "MenuViewController.h"
#import "SubcatTableViewCell.h"
#import "WSOperationInEDUApp.h"
#import "UIScrollView+TPKeyboardAvoidingAdditions.h"
#import "AddbusinessViewController.h"
#import "LoginViewController.h"
#import "BundleLocalization.h"
#import "FMDBManager.h"
#import "MapViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"
#import "ContectUsViewController.h"
@interface RegistrationViewController ()<MenuViewControllerDelegates,
MapViewControllerDelegates,UITextFieldDelegate,UIScrollViewDelegate>

{

    NSMutableArray *categrtArray;
    NSMutableArray *SubcategrtArray;
    NSMutableArray *BusinessArray;
    NSDictionary *categrDic;
    NSDictionary *businessDic;
    NSDictionary *SubcategrtDic;
    NSString *sendId;
    NSMutableArray *addcontent;
    NSMutableArray *sendIdarr;
    NSString *Bussines_id;
    NSString *SubCateId_id;
    NSString *Catigry_id;
    NSString *SubCatename;
    NSMutableArray *sendsubname;
    UINavigationController *nav;
    MenuViewController * sample;
    NSString *latitude,*longitude;
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    NSString *post;
   
    
    NSMutableArray * arrCatId, * arrCatName, * arrAddCategory;
    
    
    NSString  * strCatId;
    NSString  * strCatName;

    NSString *sendnamearr;
    
}

@end

@implementation RegistrationViewController
bool isShownreg = false;

@synthesize flagIsPeopleAccess, flagIsParkingAvaialble;

-(void)viewWillAppear:(BOOL)animated
{
    
    [self.lbl_PName setHidden:YES];
    [self.lbl_PCategory setHidden:YES];
    [self.lbl_PSubCategory setHidden:YES];
    [self.lbl_PPhone setHidden:YES];
    [self.lbl_PAddress setHidden:YES];
    [self.lbl_PEmail setHidden:YES];
    [self.lbl_PUserEmail setHidden:YES];
    [self.lbl_PPassword setHidden:YES];
    
    sendsubname=[[NSMutableArray alloc]init];
    sendIdarr=[[NSMutableArray alloc]init];
    addcontent=[[NSMutableArray alloc]init];
    
    sendIdarr=[[NSMutableArray alloc]init];
    sendsubname=[[NSMutableArray alloc]init];
    addcontent=[[NSMutableArray alloc]init];
    arrAddCategory =[[NSMutableArray alloc]init];
    arrCatId =[[NSMutableArray alloc]init];
    arrCatName=[[NSMutableArray alloc]init];
    
    //self.RegistScrollView.contentSize = CGSizeMake(320, 2500);
     [self.RegistScrollView setContentSize:CGSizeMake(320, 1900)];
     [self.scrollView_Images setContentSize:CGSizeMake(414, 170)];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization )]) {
        [locationManager requestWhenInUseAuthorization];
    }
    [locationManager startUpdatingLocation];
    self.intBusinessHourStatus = 1;
 [self GetcategoryList];
  
}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"%f", scrollView.contentOffset.y);
//    self.RegistScrollView.contentSize = CGSizeMake(320, 2500);
//    
//    
//}
- (void)viewDidLayoutSubviews
{
    
    [ self.RegistScrollView setContentSize:CGSizeMake(320, 1900)];
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
         self.PlaceholderLabelh.hidden = NO;
        
    }else if(newString.length>0){
        self.placehoderLabel.hidden = YES;
        self.PlaceholderLabelh.hidden = YES;
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
  //  [errorAlert show];
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
   // self.userlat = [NSString stringWithFormat:@"%f", coordinate.latitude];
   // self.userlong = [NSString stringWithFormat:@"%f", coordinate.longitude];
}
- (IBAction)doneClicked:(id)sender
{
    self.CategeryShowView.hidden=YES;
    self.SubcategoryshowView.hidden=YES;
    self.BusinessView.hidden=YES;
    [self.phonetextfiled resignFirstResponder];
    [self.AddressTextFiled resignFirstResponder];
    [self.BussinetTypeTextfiled resignFirstResponder];
    [self.BussinesNameText resignFirstResponder];
    [self.DescriptionTextView resignFirstResponder];
    [self.WeburlTextFiled resignFirstResponder];
    [self.videourl resignFirstResponder];
    [self.facebooktextfiled resignFirstResponder];
    [self.BusinesshoursText resignFirstResponder];
    [self.PasswordTextfiled resignFirstResponder];
    [self.NametextFiled resignFirstResponder];
    [self.EmailtextFiled resignFirstResponder];
    [self.Bussinessemiltextfiled resignFirstResponder];
    [self.tf_TblUrl resignFirstResponder];
    [self.tf_MenuUrl resignFirstResponder];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStyleDone target:self action:@selector(doneClicked:)];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
    self.phonetextfiled.inputAccessoryView = keyboardDoneButtonView;
    self.PasswordTextfiled.inputAccessoryView = keyboardDoneButtonView;
    self.NametextFiled.inputAccessoryView = keyboardDoneButtonView;
    self.CategeryTextFiled.inputAccessoryView = keyboardDoneButtonView;
    self.EmailtextFiled.inputAccessoryView = keyboardDoneButtonView;
    self.Bussinessemiltextfiled.inputAccessoryView = keyboardDoneButtonView;
    self.BussinesNameText.inputAccessoryView = keyboardDoneButtonView;
    self.WeburlTextFiled.inputAccessoryView = keyboardDoneButtonView;
    self.videourl.inputAccessoryView = keyboardDoneButtonView;
    self.facebooktextfiled.inputAccessoryView = keyboardDoneButtonView;
    self.BusinesshoursText.inputAccessoryView = keyboardDoneButtonView;
     self.DescriptionTextView.inputAccessoryView = keyboardDoneButtonView;
    self.tf_TblUrl.inputAccessoryView = keyboardDoneButtonView;
    self.tf_MenuUrl.inputAccessoryView = keyboardDoneButtonView;
    tv_PeopleAccess.inputAccessoryView = keyboardDoneButtonView;
    tv_ParkingAvailable.inputAccessoryView = keyboardDoneButtonView;
    
        if ([self.NametextFiled respondsToSelector:@selector(setAttributedPlaceholder:)]) {
            UIColor *color = [UIColor lightGrayColor];
             self.NametextFiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Name",nil) attributes:@{NSForegroundColorAttributeName: color}];
             self.CategeryTextFiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString: NSLocalizedString(@"SelectCategory",nil) attributes:@{NSForegroundColorAttributeName: color}];
             self.PasswordTextfiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Password",nil) attributes:@{NSForegroundColorAttributeName: color}];
             self.EmailtextFiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Email",nil) attributes:@{NSForegroundColorAttributeName: color}];
            self.Bussinessemiltextfiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Business Email",nil) attributes:@{NSForegroundColorAttributeName: color}];
             self.phonetextfiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Phone",nil) attributes:@{NSForegroundColorAttributeName: color}];
             self.BussinesNameText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Business Name",nil) attributes:@{NSForegroundColorAttributeName: color}];
             self.SubCategryTextfiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Select Sub Category",nil) attributes:@{NSForegroundColorAttributeName: color}];
             self.WeburlTextFiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"WebURL",nil) attributes:@{NSForegroundColorAttributeName: color}];
             self.BussinetTypeTextfiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Business type",nil) attributes:@{NSForegroundColorAttributeName: color}];
            self.videourl.attributedPlaceholder = [[NSAttributedString alloc] initWithString: NSLocalizedString(@"Video Url",nil) attributes:@{NSForegroundColorAttributeName: color}];
            self.facebooktextfiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"facebook Url",nil)attributes:@{NSForegroundColorAttributeName: color}];
            self.tf_MenuUrl.attributedPlaceholder = [[NSAttributedString alloc] initWithString: NSLocalizedString(@"Menu url",nil) attributes:@{NSForegroundColorAttributeName: color}];
            self.tf_TblUrl.attributedPlaceholder = [[NSAttributedString alloc] initWithString: NSLocalizedString(@"Table url",nil) attributes:@{NSForegroundColorAttributeName: color}];
           
            self.placehoderLabel2.text=NSLocalizedString(@"Address",nil);
            self.PlaceholderLabelh.text=NSLocalizedString(@"Business hours",nil);
            self.placehoderLabel.text=NSLocalizedString(@"Description",nil);
            [self.ProfileImageBtnOut setTitle:NSLocalizedString(@"PROFILE IMAGE",nil) forState:UIControlStateNormal];
            [self.ResterBtnOut setTitle:NSLocalizedString(@"Send",nil) forState:UIControlStateNormal];
        
            
            lbl_PlaceholderPeople.text=NSLocalizedString(@"PeopleAccess",nil);
            lbl_PlaceholderParking.text=NSLocalizedString(@"ParkingAvailable",nil);
            
            [_btn_ParkingAvailable setBackgroundImage:[UIImage imageNamed:@"open_hours.png"] forState:UIControlStateNormal];
            self.strParkingAvailable = @"1";
            
            flagIsPeopleAccess = NO;
            flagIsParkingAvaialble = NO;
            
            [_btn_PeopleAccess setBackgroundImage:[UIImage imageNamed:@"open_hours.png"] forState:UIControlStateNormal];
            self.strPeopleAccess = @"1";
            
            
        }
    self.tabBarController.tabBar.hidden=YES;
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Mapdata"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"longitude"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"latitude"];
     categrtArray = [[NSMutableArray alloc]init];
     SubcategrtArray = [[NSMutableArray alloc]init];
     BusinessArray =[[NSMutableArray alloc]init];
    [self.CategoryTableView setSeparatorInset:UIEdgeInsetsZero];
    self.CategoryTableView .tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.SubcategoryTableview setSeparatorInset:UIEdgeInsetsZero];
    self.SubcategoryTableview .tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.BusinessView.layer.masksToBounds = NO;
    self.BusinessView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.BusinessView.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    self.BusinessView.layer.shadowOpacity = 0.8f;
    
    self.SubcategoryshowView.layer.masksToBounds = NO;
    self.SubcategoryshowView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.SubcategoryshowView.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    self.SubcategoryshowView.layer.shadowOpacity = 0.8f;
        //  [self.SubcatBtnOut setEnabled: NO];
    
    //The event handling method
    
    [self GetcategoryList];
    [self get_busineList];
    // Do any additional setup after loading the view.
}
//- (void)SubcategoryhandleSingleTap:(UITapGestureRecognizer *)recognizer {
//   
//    self.SubcategoryshowView.hidden=YES;
//    self.CategeryShowView.hidden=YES;
//    self.BusinessView.hidden=YES;
//    //Do stuff here...
//}
//- (void)CategeryhandleSingleTap:(UITapGestureRecognizer *)recognizer {
//    
//    self.SubcategoryshowView.hidden=YES;
//    self.CategeryShowView.hidden=YES;
//    self.BusinessView.hidden=YES;
//    //Do stuff here...
//}
//- (void)BusinesshandleSingleTap:(UITapGestureRecognizer *)recognizer {
//    
//    self.SubcategoryshowView.hidden=YES;
//    self.CategeryShowView.hidden=YES;
//    self.BusinessView.hidden=YES;
//    //Do stuff here...
//}
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
#pragma mark - text field delegates
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==self.NametextFiled) {
        [self.EmailtextFiled becomeFirstResponder];
    }else if (textField==self.EmailtextFiled){
        [self.PasswordTextfiled becomeFirstResponder];
    }else if (textField==self.PasswordTextfiled){
        [self.Bussinessemiltextfiled becomeFirstResponder];
    }else if (textField==self.Bussinessemiltextfiled){
        [self.phonetextfiled becomeFirstResponder];
    }else if (textField==self.phonetextfiled){
        [self.BussinesNameText becomeFirstResponder];
    }else if (textField==self.BussinesNameText){
        [self.BusinesshoursText becomeFirstResponder];
    }else if (textField==self.BusinesshoursText){
        [self.DescriptionTextView becomeFirstResponder];
    }else if (textField==self.BussinesNameText){
        [self.WeburlTextFiled becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
//    if (textField==self.NametextFiled)
//    {
//        
//        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-120, self.view.frame.size.width, self.view.frame.size.height);
//    }else if (textField==self.PasswordTextfiled){
//        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-160, self.view.frame.size.width, self.view.frame.size.height);
//        
//    }else if (textField==self.EmailtextFiled){
//        
//        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-180, self.view.frame.size.width, self.view.frame.size.height);
//        
//    }else if (textField==self.phonetextfiled){
//        
//        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-220, self.view.frame.size.width, self.view.frame.size.height);
//        
//    }else if (textField==self.BussinesNameText){
//        
//        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-260, self.view.frame.size.width, self.view.frame.size.height);
//        
//    }else if (textField==self.WeburlTextFiled){
//        
//        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-300, self.view.frame.size.width, self.view.frame.size.height);
//        
//    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField ==  self.EmailtextFiled) {
        if(self.EmailtextFiled.text.length > 0) {
            [self.lbl_PUserEmail setHidden:YES];
        }
    } else if(textField == self.PasswordTextfiled) {
        if(self.PasswordTextfiled.text.length > 0) {
            [self.lbl_PPassword setHidden:YES];
        }
    } else if(textField == self.Bussinessemiltextfiled) {
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
        
        SubcatTableViewCell *cell=[self.SubcategoryTableview dequeueReusableCellWithIdentifier:reuseIdentifier];
        if (!cell) {
            cell=[[SubcatTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        }

        categrDic=[categrtArray objectAtIndex:indexPath.row];
        cell.backgroundColor = [UIColor darkGrayColor];
        cell.textLabel.textColor = [UIColor whiteColor];
        
        
            //cell.textLabel.text=[categrDic objectForKey:@"category_name"];
            //cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.titallabel.text=[categrDic objectForKey:@"category_name"];
        cell.titallabel.textColor = [UIColor whiteColor];
        cell.titallabel.textAlignment = NSTextAlignmentLeft;
        
        if ([arrAddCategory containsObject:indexPath]) {
                //cell.images.image=[UIImage imageNamed:@"Login_03.png"];
            cell.images.image=[UIImage imageNamed:@"Login_03"];
        } else {
                //cell.images.image=[UIImage imageNamed:@"Login_05.png"];
            cell.images.image=[UIImage imageNamed:@"Login_05"];
        }
        
                return cell;
    }else if (tableView==self.SubcategoryTableview) {
        static NSString *reuseIdentifier=@"SubcatgrryCell";
        
        SubcatTableViewCell *cell=[self.SubcategoryTableview dequeueReusableCellWithIdentifier:reuseIdentifier];
        if (!cell) {
            cell=[[SubcatTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        }
        SubcategrtDic=[SubcategrtArray objectAtIndex:indexPath.row];
        cell.backgroundColor = [UIColor darkGrayColor];
        cell.titallabel.text=[SubcategrtDic objectForKey:@"sub_category_name"];
        cell.titallabel.textColor = [UIColor whiteColor];
        cell.titallabel.textAlignment = NSTextAlignmentLeft;
        if ([addcontent containsObject:indexPath])
        {
            cell.images.image=[UIImage imageNamed:@"Login_03.png"];
            
        }
        else
        {
            cell.images.image=[UIImage imageNamed:@"Login_05.png"];
            
        }


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
        if ([addcontent containsObject:indexPath])
          {
            [addcontent removeObject:indexPath];
            
            [sendIdarr removeObject:SubCateId_id];
            [sendsubname removeObject:SubCatename];
          }
        else
          {
            
            
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
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Camera Unavailable",nil) message:NSLocalizedString(@"Unable to find a camera on your device.",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil, nil];
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
    //UIImage* SelectedImage = info[UIImagePickerControllerEditedImage];
    if (self.Isprofile==YES) {
       self.ProfileImageView.image = SelectedImage;
    }else if (self.Isaddimg1==YES){
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
    } else if (self.Isaddimg7==YES){
        
        self.AddImg7.image = SelectedImage;
    }else if (self.Isaddimg8==YES){
        
        self.AddImg8.image = SelectedImage;
    }else if (self.Isaddimg9==YES){
        
        self.AddImg9.image = SelectedImage;
    } else if (self.Isaddimg10==YES){
        
        self.AddImg10.image = SelectedImage;
    }
   
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (IBAction)ActionOnmenu:(id)sender {
    if (!isShownreg) {
        
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
        
        isShownreg = true;
        
    } else {
        
        CATransition *transition = [CATransition animation];
        transition.duration =0.5;
        transition.type = kCATransitionReveal;
        
        transition.subtype = kCATransitionFromRight;
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [sample.view.layer addAnimation:transition forKey:nil];
        [sample.view performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.5];
        isShownreg = false;
    }

}

- (IBAction)ActionOnBack:(id)sender {
     [self .navigationController popViewControllerAnimated:YES];
}
- (IBAction)ActionOnCategory:(id)sender {
    self.CategeryShowView.hidden=NO;
    self.SubcategoryshowView.hidden=YES;
}
- (IBAction)ActionOnSubcategory:(id)sender {
        // if ([sender isSelected]) {
        // [sender setSelected: NO];
    
        self.CategeryShowView.hidden=YES;
        self.SubcategoryshowView.hidden=NO;
        self.BusinessView.hidden=YES;
        [self.phonetextfiled resignFirstResponder];
        [self.AddressTextFiled resignFirstResponder];
        [self.BussinetTypeTextfiled resignFirstResponder];
        [self.BussinesNameText resignFirstResponder];
        [self.DescriptionTextView resignFirstResponder];
        [self.WeburlTextFiled resignFirstResponder];
        [self.videourl resignFirstResponder];
        [self.facebooktextfiled resignFirstResponder];
        [self.BusinesshoursText resignFirstResponder];
/*    } else {
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
         [self.BusinesshoursText resignFirstResponder];
    } */

}
- (IBAction)ActionOnBusiness:(id)sender {
    self.CategeryShowView.hidden=YES;
    self.SubcategoryshowView.hidden=YES;
    self.BusinessView.hidden=NO;
}
- (IBAction)ActionOnPicImg:(id)sender {
    self.Isprofile=YES;
    self.Isaddimg1=NO;
    self.Isaddimg2=NO;
    self.Isaddimg3=NO;
    self.Isaddimg4=NO;
    self.Isaddimg5=NO;
    self.Isaddimg6=NO;
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


- (IBAction)btn_CloseCategoryView:(id)sender {
    self.CategeryShowView.hidden = YES;
}

- (IBAction)btn_OkCategoryView:(id)sender {
    
    Catigry_id =   [arrCatId componentsJoinedByString:@","];//[categrDic objectForKey:@"category_id"];
    
    
    
    FMDBManager *fm = [[FMDBManager alloc] init];
    [fm openDataBase];
    
    
    
    for (int i = 0; i < arrCatId.count; i++) {
        NSMutableArray * arrSubCat =     [fm SubCategryarry:arrCatId[i]];
        [SubcategrtArray addObjectsFromArray:arrSubCat];
    }
    
    [self.SubcategoryTableview reloadData];
    
    self.CategeryTextFiled.text = [arrCatName componentsJoinedByString:@","];
    if(self.CategeryTextFiled.text.length > 0) {
        [self.lbl_PCategory setHidden:YES];
    }

    self.CategeryShowView.hidden = YES;
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



-(void)GetcategoryList{
    FMDBManager *fms = [[FMDBManager alloc] init];
    [fms openDataBase];
    categrtArray = [fms Categryarry];
     [self.CategoryTableView reloadData];

    
}

#pragma mark - Address map delegates

-(void)MapAddress:(NSString *)placeMark La:(NSString *)la log:(NSString *)log
{
    self.placehoderLabel2.hidden=YES;
    self.AddressTextFiled.text = [NSString stringWithFormat:@"%@",placeMark];
    self.userlat = [NSString stringWithFormat:@"%@", la];
    self.userlong = [NSString stringWithFormat:@"%@", log];
    if(self.AddressTextFiled.text.length > 0) {
        [self.lbl_PAddress setHidden:YES];
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
            SubcategrtArray=[responseDic objectForKey:@"result"];
        }
        [self.SubcategoryTableview reloadData];
    }
}
-(void)get_busineList{
    WSOperationInEDUApp *ws=[[WSOperationInEDUApp alloc]initWithDelegate:self callback:@selector(getbusinesstype:)];
    [ws GatBusinesid:@"2"];

    
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

-(BOOL)EmailCheck:(NSString*)sender
{
    // NSString *emailRegex = @"[a-zA-Z0-9._-]+@[a-z_-]+\\.+[a-z]+";
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailValidation = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    if (![emailValidation evaluateWithObject:self.EmailtextFiled.text]) {
        return NO;
    }
    
    return YES;
    
    
}
#pragma mark - Email Validation

-(BOOL)EmailCheck2:(NSString*)sender
{
    // NSString *emailRegex = @"[a-zA-Z0-9._-]+@[a-z_-]+\\.+[a-z]+";
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailValidation = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    if (![emailValidation evaluateWithObject:self.Bussinessemiltextfiled.text]) {
        return NO;
    }
    return YES;
    
    
}

-(NSString*)formatNumber:(NSString*)mobileNumber
{
    
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    NSLog(@"%@", mobileNumber);
    
    long int length = [mobileNumber length];
    if(length > 10)
    {
        mobileNumber = [mobileNumber substringFromIndex: length-10];
        NSLog(@"%@", mobileNumber);
        
    }
    
    
    return mobileNumber;
}


- (IBAction)ActionOnRegister:(id)sender {
    if (self.EmailtextFiled.text.length==0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Fill Email Field",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
        [alert show];
        [self.lbl_PUserEmail setHidden:NO];
    } else if (self.PasswordTextfiled.text.length==0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Fill Password Field",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
        [alert show];
        [self.lbl_PPassword setHidden:NO];
    } else if (self.Bussinessemiltextfiled.text.length==0){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Fill Business Email Field",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
        [alert show];
        
        [self.lbl_PEmail setHidden:NO];
        
    }/*else if (![self EmailCheck:self.Bussinessemiltextfiled.text]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Fill valid Email Field",nil) message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        [self.lbl_PEmail setHidden:NO];
        
    }*/else if (self.phonetextfiled.text.length==0){
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
    } else{

        if (Bussines_id.length == 0) {
            if(BusinessArray.count > 0) {
                businessDic=[BusinessArray objectAtIndex:0];
                self.BussinetTypeTextfiled.text=[businessDic objectForKey:@"business_type"];
                Bussines_id=[businessDic objectForKey:@"business_type_id"];
            }

        }
        
        
    WSOperationInEDUApp *ws=[[WSOperationInEDUApp alloc]initWithDelegate:self callback:@selector(Register:)];
    [ws UserRegistraion:self.NametextFiled.text email:self.EmailtextFiled.text password:self.PasswordTextfiled.text  phone:self.phonetextfiled.text address:self.AddressTextFiled.text latitude:self.userlat longitude: self.userlong business_name:self.BussinesNameText.text business_type_id:Bussines_id description:self.DescriptionTextView.text website_url:self.WeburlTextFiled.text sub_cat_id:sendId user_image:self.ProfileImageView.image Addimg1:self.AddImg1.image Addimg2:self.AddImg2.image  Addimg3:self.AddImg3.image  Addimg4:self.AddImg4.image  Addimg5:self.AddImg5.image  Addimg6:self.AddImg6.image Addimg7:self.AddImg7.image Addimg8:self.AddImg8.image Addimg9:self.AddImg9.image Addimg10:self.AddImg10.image  business_email:self.Bussinessemiltextfiled.text facebook_url:self.facebooktextfiled.text video_url:self.videourl.text  language_id:@"2" start_time:self.BusinesshoursText.text end_time:@"" MenuUrl:_tf_MenuUrl.text TableUrl:_tf_TblUrl.text BusinessHoursStatus:[NSString stringWithFormat:@"%d", _intBusinessHourStatus] PeopleAccessStatus:_strPeopleAccess ParkingAvailable:_strParkingAvailable];
    }
    
}
#pragma mark - Menu delegates

#pragma mark - Menu delegates
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==1) {
        if (buttonIndex == 0){
            
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"login"];
            
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"userdata"];
            
            
            //login
            
        }
        
        
    }
}
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
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Are you sure you want to logout?",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK" ,nil) otherButtonTitles:NSLocalizedString(@"Cancel",nil), nil];
            alert.tag=1;
            [alert show];
        }
            break;
        case 7:
        {
            NSDictionary *UserDict =[[NSUserDefaults standardUserDefaults] objectForKey:@"userdata"];
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
              //  price1.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
              //  price1.modalPresentationStyle = UIModalPresentationFormSheet;
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

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.PasswordTextfiled resignFirstResponder];
    [self.EmailtextFiled resignFirstResponder];
    [self.phonetextfiled resignFirstResponder];
    [self.BussinesNameText resignFirstResponder];
    [self.DescriptionTextView resignFirstResponder];
    [self.WeburlTextFiled resignFirstResponder];
    [self.videourl resignFirstResponder];
    [self.BusinesshoursText resignFirstResponder];
    CATransition *transition = [CATransition animation];
    transition.duration = 1;
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromLeft;
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [sample.view.layer addAnimation:transition forKey:nil];
    [sample.view removeFromSuperview];
    
    
    isShownreg = false;
}

-(void)Register:(id)response
{
    
    NSDictionary *responseDic=response;
    NSLog(@"responseDic = %@", responseDic);
    if ([response isKindOfClass:[NSDictionary class]]) {
        if ([[responseDic objectForKey:@"message"]isEqualToString:@"success"]) {
            [self .navigationController popViewControllerAnimated:YES];
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Email already exists",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
            [alert show];

        }
    }
}

- (IBAction)btn_Status:(id)sender {
    
    if(_flagIsOpen) {
        [_btn_Status setBackgroundImage:[UIImage imageNamed:@"close_hours.png"] forState:UIControlStateNormal];
        self.intBusinessHourStatus = 2;
    } else {
        [_btn_Status setBackgroundImage:[UIImage imageNamed:@"open_hours.png"] forState:UIControlStateNormal];
        self.intBusinessHourStatus = 1;
    }
    
    _flagIsOpen = !_flagIsOpen;
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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    //([segue.identifier isEqualToString:@"Exiscixe"])
    if ([segue.identifier isEqualToString:@"MapView"]) {
        MapViewController *MapView = segue.destinationViewController;
        MapView.delegates = self;
    }
    
}

- (IBAction)btn_PeopleAccess:(id)sender {
    if(!flagIsPeopleAccess) {
        [_btn_PeopleAccess setBackgroundImage:[UIImage imageNamed:@"close_hours.png"] forState:UIControlStateNormal];
        self.strPeopleAccess = @"2";
    } else {
        [_btn_PeopleAccess setBackgroundImage:[UIImage imageNamed:@"open_hours.png"] forState:UIControlStateNormal];
        self.strPeopleAccess = @"1";
    }
    flagIsPeopleAccess = !flagIsPeopleAccess;
}
- (IBAction)btn_ParkingAvailable:(id)sender {
    if(!flagIsParkingAvaialble) {
        [_btn_ParkingAvailable setBackgroundImage:[UIImage imageNamed:@"close_hours.png"] forState:UIControlStateNormal];
        self.strParkingAvailable = @"2";
    } else {
        [_btn_ParkingAvailable setBackgroundImage:[UIImage imageNamed:@"open_hours.png"] forState:UIControlStateNormal];
        self.strParkingAvailable = @"1";
    }
    flagIsParkingAvaialble = !flagIsParkingAvaialble;
}

@end

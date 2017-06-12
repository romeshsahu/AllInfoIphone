//
//  ViewController.m
//  All Info
//
//  Created by Mahendra Suryavanshi on 3/3/16.
//  Copyright © 2016 PS.com. All rights reserved.
//

#import "ViewController.h"
#import "HomeCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "WSOperationInEDUApp.h"
#import "SubCategiryViewController.h"
#import "MenuViewController.h"
#import "RegistrationViewController.h"
#import "LoginViewController.h"
#import "GifFileViewController.h"
#import "AddbusinessViewController.h"
#import "Allinfo.h"
#import "HelpViewController.h"
#import "AppDelegate.h"
#import "ContectUsViewController.h"

@interface ViewController () <MenuViewControllerDelegates,UITabBarControllerDelegate>
{
    NSMutableArray *categrtArray;
    NSMutableArray *SubcategrtArray;
    NSString *catname;
    NSDictionary *categryDic;
    UINavigationController *nav;
    MenuViewController * sample;
    NSMutableArray *AllCatergryArr;
    NSArray *BissArr;
    NSMutableArray *AllBisArr;
    NSString * Userlong;
    NSString * Userlat;
    CLLocationManager *locationManager;
    BOOL isfirst;
    
    
  
}

@end
NSString *kCellID = @"cellID";
@implementation ViewController
bool isShown = false;

- (IBAction)doneClicked:(id)sender
{
    
    if (self.searchFiled.text.length==0) {
        [self.searchFiled resignFirstResponder];
        //        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter your User Name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //        [alert show];
    }else{
        [self.searchFiled resignFirstResponder];
        [self performSegueWithIdentifier:@"search" sender:self];
    }

    
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.HomeCollectionView setTransform:CGAffineTransformMakeScale(-1, 1)];
    [sample.view removeFromSuperview];
    self.tabBarController.tabBar.hidden=NO;
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    [self.searchFiled becomeFirstResponder];
    FMDBManager *fm = [[FMDBManager alloc] init];
    [fm openDataBase];
    AllBisArr = [fm getBusinessarr];
    FMDBManager *fms = [[FMDBManager alloc] init];
    [fms openDataBase];
    categrtArray = [fms Categryarry];
    
    NSSortDescriptor * descriptor = [NSSortDescriptor sortDescriptorWithKey:@"show_date" ascending:NO selector:@selector(localizedCaseInsensitiveCompare:)];
    NSArray * arrSorted = [NSArray arrayWithObject:descriptor];
    
    [categrtArray sortUsingDescriptors:arrSorted];
    
    
    [sample.view removeFromSuperview];
    self.tabBarController.tabBar.hidden=NO;
        //[self GetprodectList];
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarController.delegate = self;
    self.searchFiled.placeholder=NSLocalizedString(@"Search",nil);
    AllBisArr = [[NSMutableArray alloc]init];
    [self.searchFiled becomeFirstResponder];
    UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStyleDone target:self action:@selector(doneClicked:)];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
    
    self.searchFiled.inputAccessoryView = keyboardDoneButtonView;

//    NSString *hexString = @"abc123 mahi kua, bjjbj";
//    NSMutableArray *arr =[[NSMutableArray alloc] init];
//    for(int i =0 ;i<[hexString length]; i++) {
//        char character = [hexString characterAtIndex:i];
//        NSString* string = [NSString stringWithFormat:@"%c" , character];
//              unichar uc;
//        [string getBytes:&uc maxLength:2 usedLength:NULL encoding:NSUTF16LittleEndianStringEncoding options:0 range:NSMakeRange(0, 1) remainingRange:NULL];
//        NSLog(@"uc: %04x", uc);
//        NSString *u = [NSString stringWithFormat:@"\\u%04x", uc];
//        NSLog(@"%@", u);
//        [arr addObject:u];
//    }
//    NSLog(@"arr :%@",arr);
//    NSString * myString = [arr componentsJoinedByString:@""];
//    printf("%s", [myString UTF8String]);
//    NSData *newdata=[myString dataUsingEncoding:NSUTF8StringEncoding
//                                 allowLossyConversion:YES];
//    NSString *string=[[NSString alloc] initWithData:newdata encoding:NSNonLossyASCIIStringEncoding];
    

    [sample.view removeFromSuperview];
    self.tabBarController.tabBar.hidden=NO;
    categrtArray = [[NSMutableArray alloc]init];
    SubcategrtArray = [[NSMutableArray alloc]init];
    FMDBManager *fm = [[FMDBManager alloc] init];
    [fm openDataBase];
    AllBisArr = [fm getBusinessarr];
        //  [self addlistbusine];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    if (self.searchFiled.text.length==0) {
        [self.searchFiled resignFirstResponder];
        //        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter your User Name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //        [alert show];
    }else{
        [self.searchFiled resignFirstResponder];
        [self performSegueWithIdentifier:@"search" sender:self];
    }
    

    return YES;
}
-(void)GetBusinesList:(id)response
{
    NSDictionary *responseDic=response;
    if ([response isKindOfClass:[NSDictionary class]]) {
        if ([[responseDic objectForKey:@"message"]isEqualToString:@"success"]) {
            NSArray *BusinessArr=[responseDic objectForKey:@"result"];
            AllCatergryArr=[[NSMutableArray alloc]init];
            for (int i=0; i<BusinessArr.count; i++) {
                NSDictionary *BusinessDic=[BusinessArr objectAtIndex:i];
                Allinfo *BusinessArrInfo=[[Allinfo alloc]init];
                NSLog(@"BusinessDict = %@", [BusinessDic objectForKey:@"category_id"]);
                BusinessArrInfo.category_id=[BusinessDic objectForKey:@"category_id"];
                BusinessArrInfo.category_image=[BusinessDic objectForKey:@"category_image"];
                BusinessArrInfo.category_name=[BusinessDic objectForKey:@"category_name"];
                BusinessArrInfo.language_id=[BusinessDic objectForKey:@"language_id"];
                FMDBManager *fm = [[FMDBManager alloc] init];
                [fm openDataBase];
                [fm saveallBusinss:BusinessDic];
                
            }
            
        }
    }
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    CATransition *transition = [CATransition animation];
    transition.duration = 1;
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromRight;
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [sample.view.layer addAnimation:transition forKey:nil];
    [sample.view removeFromSuperview];
    
    
    isShown = false;
}
#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    //NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    if (currentLocation != nil) {
        Userlong = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        Userlat= [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
     
        
    }
}
-(void)addlistbusine{

        NSString *userlat=[[NSUserDefaults standardUserDefaults]
                           stringForKey:@"userlat"];
        NSString *userlong=[[NSUserDefaults standardUserDefaults]
                           stringForKey:@"userlong"];
    
      WSOperationInEDUApp *ws=[[WSOperationInEDUApp alloc]initWithDelegate:self callback:@selector(GetBusinesList:)];
    

}
-(void)UpdateGetBusinessList{

  
    
    [self.connection cancel];
    
    //initialize new mutable data
    NSMutableData *data = [[NSMutableData alloc] init];
    self.receivedData = data;
    // [data release];
    
    //initialize url that is going to be fetched.
    NSString *urlStr=[NSString stringWithFormat:@"http://allinfo.co.il/all_info/webservice/master.php?action=AllBusiness&latitude=%@&longitude=%@",Userlat,Userlong];
    
    //passcode
    
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    //initialize a request from url
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[url standardizedURL]];
    
    //set http method
    [request setHTTPMethod:@"POST"];
    
    
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    self.connection = connection;
    //[connection release];
    
    //start the connection
    [connection start];

    
    
}





-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    //initialize convert the received data to string with UTF8 encoding
    NSString *response=[[NSString alloc]initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    NSDictionary *responseDic =[NSJSONSerialization JSONObjectWithData:self.receivedData options:kNilOptions error:nil];
    if ([responseDic isKindOfClass:[NSDictionary class]]) {
        if ([[responseDic objectForKey:@"message"]isEqualToString:@"success"]) {
            NSArray *BusinessArr=[responseDic objectForKey:@"result"];
            AllCatergryArr=[[NSMutableArray alloc]init];
            for (int i=0; i<BusinessArr.count; i++) {
                NSDictionary *BusinessDic=[BusinessArr objectAtIndex:i];
                Allinfo *BusinessArrInfo=[[Allinfo alloc]init];
                BusinessArrInfo.category_id=[BusinessDic objectForKey:@"category_id"];
                BusinessArrInfo.category_image=[BusinessDic objectForKey:@"category_image"];
                BusinessArrInfo.category_name=[BusinessDic objectForKey:@"category_name"];
                BusinessArrInfo.language_id=[BusinessDic objectForKey:@"language_id"];
                FMDBManager *fm = [[FMDBManager alloc] init];
                [fm openDataBase];
                [fm AllBusinessupdateList:BusinessDic];
                
            }
            
        }
    }
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.receivedData appendData:data];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    // [HUD hide:YES];
    NSLog(@"%@" , error);
}



-(void)Getcategory:(id)response
{
    NSDictionary *responseDic=response;
    if ([response isKindOfClass:[NSDictionary class]]) {
        if ([[responseDic objectForKey:@"message"]isEqualToString:@"success"]) {
            
            //categrtArray=[responseDic objectForKey:@"result"];
            NSArray *CategrArr=[responseDic objectForKey:@"result"];
            AllCatergryArr=[[NSMutableArray alloc]init];
            for (int i=0; i<CategrArr.count; i++) {
                NSDictionary *CategrDic=[CategrArr objectAtIndex:i];
                Allinfo *CategrArrInfo=[[Allinfo alloc]init];
                CategrArrInfo.category_id=[CategrDic objectForKey:@"category_id"];
                CategrArrInfo.category_image=[CategrDic objectForKey:@"category_image"];
                CategrArrInfo.category_name=[CategrDic objectForKey:@"category_name"];
                CategrArrInfo.language_id=[CategrDic objectForKey:@"language_id"];
                FMDBManager *fm = [[FMDBManager alloc] init];
                [fm openDataBase];
                [fm saveallcatgery:CategrDic];
              
        }
            //if (CategrArr && CategrArr.count>0) {
            FMDBManager *fm = [[FMDBManager alloc] init];
            [fm openDataBase];
            categrtArray = [fm Categryarry];
           // }
        [self.HomeCollectionView reloadData];
    }
}
}
-(void)GetSubcategory:(id)response
{
    NSDictionary *responseDic=response;
    if ([response isKindOfClass:[NSDictionary class]]) {
        if ([[responseDic objectForKey:@"message"]isEqualToString:@"success"]) {
            NSArray *SubCategrArr=[responseDic objectForKey:@"result"];
            AllCatergryArr=[[NSMutableArray alloc]init];
            for (int i=0; i<SubCategrArr.count; i++) {
                NSDictionary *SubCategrDic=[SubCategrArr objectAtIndex:i];
                Allinfo *CategrArrInfo=[[Allinfo alloc]init];
                CategrArrInfo.category_id=[SubCategrDic objectForKey:@"category_id"];
                CategrArrInfo.category_name=[SubCategrDic objectForKey:@"category_name"];
                CategrArrInfo.create_date=[SubCategrDic objectForKey:@"create_date"];
                CategrArrInfo.sub_cat_id=[SubCategrDic objectForKey:@"sub_cat_id"];
                CategrArrInfo.sub_category_image=[SubCategrDic objectForKey:@"sub_category_image"];
                CategrArrInfo.sub_category_name=[SubCategrDic objectForKey:@"sub_category_name"];
                FMDBManager *fm = [[FMDBManager alloc] init];
                [fm openDataBase];
                [fm saveallSubcatgery:SubCategrDic];
            
        }
                }
}
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return categrtArray.count;
}

-(NSInteger)numberOfSectionsInCollectionView:
(UICollectionView *)collectionView
{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];

     [cell.contentView setTransform:CGAffineTransformMakeScale(-1, 1)];
    categryDic= [categrtArray objectAtIndex:indexPath.row];
    cell.Titallabel.text = [categryDic objectForKey:@"category_name"];
//    [cell.HomeImageView.layer setBorderColor: [[UIColor blackColor] CGColor]];
//    [cell.HomeImageView.layer setBorderWidth: 2.0];
//    cell.HomeImageView.layer.cornerRadius = 10;
    NSString *imageToLoad = [categryDic objectForKey:@"category_image"];
    //[cell.HomeImageView sd_setImageWithURL:[NSURL URLWithString:imageToLoad] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"]];
    [cell.HomeImageView sd_setImageWithURL:[NSURL URLWithString:imageToLoad] placeholderImage:[UIImage imageNamed:@"allinfo_logo_icon.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // URL is as expected, but Image is wrong
    }];
   
    
    return cell;
}
#pragma mark collection view cell layout / size
- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
           CGSize mElementSize = CGSizeMake(96, 92);
             return mElementSize;
        }
        if(result.height == 568)
        {
            CGSize mElementSize = CGSizeMake(96, 92);
             return mElementSize;
            
        }
        if(result.height == 667)
            
        {
            
           CGSize mElementSize = CGSizeMake(100, 105);
             return mElementSize;
        }
        
        
    }
    
    

    NSLog(@"SETTING SIZE FOR ITEM AT INDEX %d", indexPath.row);
    CGSize mElementSize = CGSizeMake(96, 92);
    return mElementSize; // will be w120xh100 or w190x100
    // if the width is higher, only one image will be shown in a line
}

#pragma mark collection view cell paddings
- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
           return UIEdgeInsetsMake(10, 7, 10, 7);
        }
        if(result.height == 568)
        {
          return UIEdgeInsetsMake(10, 7, 10, 7);
        
        }
        if(result.height == 667)
            
        {
            
            return UIEdgeInsetsMake(0, 20, 0, 15);
        }
        

    }
    return UIEdgeInsetsMake(10, 7, 10, 7);
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 7.0;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    
    categryDic=[categrtArray objectAtIndex:indexPath.row];
    FMDBManager *fm = [[FMDBManager alloc] init];
    [fm openDataBase];
    SubcategrtArray = [fm SubCategryarry:[categryDic objectForKey:@"category_id"]];
    catname=[categryDic objectForKey:@"category_name"];
    [self performSegueWithIdentifier:@"subcatgery" sender:self];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"subcatgery"]) {
        SubCategiryViewController *subcatgry=segue.destinationViewController;
        subcatgry.getsubArr=SubcategrtArray;
        subcatgry.catgeryName=catname;
        subcatgry.isserchsetview=true;
        
    }else if ([segue.identifier isEqualToString:@"search"]){
        GifFileViewController *gif=segue.destinationViewController;
        //gif.serchnamearr=BissArr;
        gif.serchByName=self.searchFiled.text;
        gif.issearch=YES;
        [self.searchFiled resignFirstResponder];
        self.searchFiled.text=@"";
    //GifFileViewController
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ActionOnmenuBtn:(id)sender {
    if (!isShown) {
        [self.searchFiled resignFirstResponder];
      
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
        
        isShown = true;
        
    } else {
        [self.searchFiled resignFirstResponder];
        CATransition *transition = [CATransition animation];
        transition.duration =0.5;
        transition.type = kCATransitionReveal;
        transition.subtype = kCATransitionFromRight;
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [sample.view.layer addAnimation:transition forKey:nil];
        [sample.view performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.5];
        
        isShown = false;
    }

   
}

- (IBAction)ActionOnRegistation:(id)sender {
     [self performSegueWithIdentifier:@"Registration" sender:self];
    
}

- (IBAction)ActionOncallView:(id)sender {
      [self performSegueWithIdentifier:@"CallDetails" sender:self];
    

    
    
    
}

- (IBAction)LoginBtn:(id)sender {
     [self performSegueWithIdentifier:@"Login" sender:self];
    /// [self performSegueWithIdentifier:@"Leavemssg" sender:self];
    
    
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
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:NSLocalizedString(@"Are you sure you want to logout?",nil) delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
            alert.tag=1;
            [alert show];
        }
            break;
        default:
            break;
    }
}
- (IBAction)actiononserch:(id)sender {
    if (self.searchFiled.text.length==0) {
//        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter your User Name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
    }else{
        [self.searchFiled resignFirstResponder];
        [self performSegueWithIdentifier:@"search" sender:self];
    }
    
}

//Do you want to close the Aolainfo NSLocalizedString(@"Alert",nil)
- (IBAction)ActionOnback:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Alert",nil) message:NSLocalizedString(@"Do you want to close the Allinfo",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:NSLocalizedString(@"Cancel",nil), nil];
    alert.tag=11;
    [alert show];

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==11) {
        if (buttonIndex == 0){
           
             exit(0);
            
        }
        
        
    }else if (alertView.tag==1) {
        if (buttonIndex == 0){
            
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"login"];
            
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"userdata"];
            
            
            //login
            
        }
        
        
    }

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if (textField==self.searchFiled) {
        
        NSMutableString *newString=[[NSMutableString alloc]initWithString:textField.text];
        if ([string isEqualToString: @""])
        {
            
            if (newString.length==0) {
                
            }else{
                
                NSRange ran=NSMakeRange(0, newString.length-1);
                
                NSString *str=[newString stringByReplacingCharactersInRange:ran withString:@""];
                
                NSRange NewRan=[newString rangeOfString:str];
                
                
                
                newString=[newString stringByReplacingCharactersInRange:NewRan withString:@""];
            }
        }else{
            [newString appendString:string];
        }
        
        
        
        if ([newString isEqualToString:@""]) {
            
            //  self.MedicineTable.hidden=YES;
            BissArr=AllBisArr;
            
        }else if(newString.length>0){
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"business_name contains[cd] %@", newString];
            BissArr=[[NSArray alloc]init] ;
            BissArr = [AllBisArr filteredArrayUsingPredicate:predicate];
            
                    }
        
        
    }
    
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    [[AppDelegate SharedInstance]getselectedTab:tabBarController.selectedIndex];
}
@end

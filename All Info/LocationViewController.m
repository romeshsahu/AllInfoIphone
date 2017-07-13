//
//  LocationViewController.m
//  All Info
//
//  Created by P S 305 on 28/06/17.
//  Copyright © 2017 PS.com. All rights reserved.
//

#import "LocationViewController.h"
#import "MenuViewController.h"
#import "LocationViewCell.h"
@interface LocationViewController (){
     MenuViewController * sample;
}

@end

@implementation LocationViewController

@synthesize arrLocation;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tblView_Location setSeparatorInset:UIEdgeInsetsZero];
    self.tblView_Location.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    pageNo = 1;
    reloads_=-1;
    
    pullToRefreshManager_ = [[MNMBottomPullToRefreshManager alloc]initWithPullToRefreshViewHeight:60.0f tableView:self.tblView_Location withClient:self];
    [self initFooterView];
    arrLocation = [[NSMutableArray alloc] init];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    //bookmarkArray = [[NSMutableArray alloc] init];
    [pullToRefreshManager_ relocatePullToRefreshView];
}

- (void) viewWillAppear:(BOOL)animated {
    dictLD = [[NSDictionary alloc] init];
    [self GetLocationData];
}

#pragma mark - UITableView Delegates

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath: (NSIndexPath *)indexPath {
    
    return  70;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.arrLocation.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LocationViewCell *cell = (LocationViewCell *)[tableView dequeueReusableCellWithIdentifier:@"LocationViewCell"];
   
    NSDictionary * dict = [arrLocation objectAtIndex:[indexPath row]];
    cell.lbl_Name.text = dict[@"location"];
    
    cell.imgView_Background.layer.cornerRadius = 5.0;
    cell.imgView_Background.layer.borderColor = [[UIColor clearColor] CGColor];
    cell.imgView_Background.clipsToBounds = YES;
    
    if([dict[@"isSelected"] intValue] == 0) {
        cell.imgView_CheckUnCheck.image = [UIImage imageNamed:@"Login_05.png"];
    } else {
        cell.imgView_CheckUnCheck.image = [UIImage imageNamed:@"Login_03.png"];
    }
    
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary * dict = arrLocation[indexPath.row];
    
    
    for (int i = 0; i< arrLocation.count; i++) {
        
        NSMutableDictionary * dict = [arrLocation[i] mutableCopy];
        [dict setObject:@"0" forKey:@"isSelected"];
        [arrLocation replaceObjectAtIndex:i withObject:dict];
    }
    
    [dict setObject:@"1" forKey:@"isSelected"];
    [arrLocation replaceObjectAtIndex:indexPath.row withObject:dict];
    [self.tblView_Location reloadData];
   
    dictLD = dict;
    
    strSelectedLat = dict[@"latitude"];
    strSelectedLong = dict[@"longitude"];
    
}

- (void)reloadData
{
    // Reload table data
    self.tblView_Location.tableFooterView = nil;
    [(UIActivityIndicatorView *)[footerView viewWithTag:10] stopAnimating];
    [self.tblView_Location reloadData];
    //[pullToRefreshManager_ tableViewReleased];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Pulled"];
}


/**
 * Tells client that refresh has been triggered
 * After reloading is completed must call [MNMBottomPullToRefreshManager tableViewReloadFinished]
 *
 * @param manager PTR manager
 */
-(void)initFooterView
{
    footerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 40.0)];
    //    footerView.backgroundColor = [UIColor blueColor];
    actInd = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    actInd.tag = 10;
    actInd.frame = CGRectMake(footerView.frame.size.width/2, 5.0, 20.0, 20.0);
    
    actInd.hidesWhenStopped = YES;
    actInd.hidden = NO;
    [footerView addSubview:actInd];
    //    actInd = nil;
    
}

-(void)GetLocationData{
    
    [self.connection cancel];
    
    //initialize new mutable data
    NSMutableData *data = [[NSMutableData alloc] init];
    self.receivedData = data;
    //[data release];
    HUD.delegate = self;
    HUD.labelText = @"Loading";
    [HUD show:NO];
    //initialize url that is going to be fetched.
    //NSString *urlStr=[NSString stringWithFormat:@"http://allinfo.co.il/all_info/webservice/master.php?action=searchBusiness&sub_cat_id=%@&language_id=%@&latitude=%@&longitude=%@&page_no=%@&limit=%@",[self.getSubcategryDic objectForKey:@"sub_cat_id"] ,@"2",lat,latonh,@"1",[NSString stringWithFormat:@"%li",(long)pageNo]];
    
    // dynamic
    NSString *urlStr= @"http://allinfo.co.il/all_info/webservice/master.php?action=location";
    
    //Static
    
    
    NSLog(@"urlStr = %@", urlStr);
    
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
    [self.connection start];
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    if (connection==self.connection) {
        if (self.receivedData != nil) {
            NSDictionary *responseDic =[NSJSONSerialization JSONObjectWithData:self.receivedData options:kNilOptions error:nil];
            if ([responseDic isKindOfClass:[NSDictionary class]]) {
                if ([[responseDic objectForKey:@"message"]isEqualToString:@"success"]) {
                    if (![[responseDic objectForKey:@"locations"] isKindOfClass:[NSNull class]]) {
                        
                        if (![Userlat isKindOfClass:[NSString class]]) {
                            Userlat = @"22.345345";
                        }
                        
                        if (![Userlong isKindOfClass:[NSString class]]) {
                            Userlong = @"75.86045";
                        }
                        
                        /// Add current location
                        NSMutableArray * arrLData = [[NSMutableArray alloc] init];
                        NSMutableDictionary * dictC = [[NSMutableDictionary alloc] init];
                        [dictC setObject:@"0000" forKey:@"location_id"];
                        [dictC setObject:Userlat forKey:@"latitude"];
                        [dictC setObject:Userlong forKey:@"longitude"];
                        [dictC setObject:@"המיקום שלי" forKey:@"location"];
                        [arrLData addObject:dictC];
                        
                        NSArray *responseArr = [responseDic objectForKey:@"locations"];
                        [arrLData addObjectsFromArray:[responseArr mutableCopy]];
                        for (int i = 0; i< arrLData.count; i++) {
                            
                            NSMutableDictionary * dict = [arrLData[i] mutableCopy];
                            NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
                            
                            if([defaults objectForKey:@"LocationData"] != nil) {
                                NSDictionary * dict1 = [defaults objectForKey:@"LocationData"];
                                if([dict1[@"location_id"] intValue] == [dict[@"location_id"] intValue]) {
                                    [dict setObject:@"1" forKey:@"isSelected"];
                                } else {
                                    
                                    [dict setObject:@"0" forKey:@"isSelected"];
                                }
                            } else {
                                [dict setObject:@"0" forKey:@"isSelected"];
                            }
                            
                            [arrLocation addObject:dict];
                        }
                        [self.tblView_Location reloadData];
                        
                    }
                    NSLog(@"arrLocation = %d", arrLocation.count);
                    
                    
                    
                    
                }else {
                    
                    [self reloadData];
                }
            }
        }
    }else  if (connection==self.connectionnew){
        
        if (self.receivedDatanew != nil) {
            NSDictionary *responseDic =[NSJSONSerialization JSONObjectWithData:self.receivedDatanew options:kNilOptions error:nil];
            if ([responseDic isKindOfClass:[NSDictionary class]]) {
                if ([[responseDic objectForKey:@"message"]isEqualToString:@"success"]) {
                    if (![[responseDic objectForKey:@"locations"] isKindOfClass:[NSNull class]]) {
                        
                        NSArray *responseArr = [responseDic objectForKey:@"locations"];
                        
                        for (NSDictionary *dic in responseArr) {
                            [arrLocation addObject:dic];
                        }
                        pageNo++;
                        [self.tblView_Location reloadData];
                        
                        
                    }
                    [self reloadData];
                    
                }else {
                    
                    //            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"No data found",nil) message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    //            [alert show];
                    [self reloadData];
                    
                }
            }
        }
    }
    
    
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [HUD hide:YES];
    [self.Activity stopAnimating];
    
    if (connection==self.connection) {
        [self.receivedData appendData:data];
    }else if (connection==self.connectionnew) {
        [self.receivedDatanew appendData:data];
    }
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [HUD hide:YES];
    [self.Activity stopAnimating];
    NSLog(@"%@" , error);
    [self reloadData];
}


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
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Are you sure you want to logout?",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK" ,nil)otherButtonTitles:NSLocalizedString(@"Cancel",nil), nil];
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
            } else {
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

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    [[AppDelegate SharedInstance]getselectedTab:tabBarController.selectedIndex];
}

- (IBAction)btn_Back:(id)sender {
    
    UIStoryboard *MainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    UINavigationController *controller = (UINavigationController*)[MainStoryboard instantiateViewControllerWithIdentifier: @"RootNavigationController"];
    UITabBarController *tabar = controller.viewControllers[0];
    [tabar setSelectedIndex:3];
    
    [AppDelegate SharedInstance].window.rootViewController=controller;
    [[AppDelegate SharedInstance].window makeKeyAndVisible];
}

- (IBAction)btn_Home:(id)sender {
    UIStoryboard *MainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    UINavigationController *controller = (UINavigationController*)[MainStoryboard instantiateViewControllerWithIdentifier: @"RootNavigationController"];
    UITabBarController *tabar = controller.viewControllers[0];
    [tabar setSelectedIndex:3];
    
    [AppDelegate SharedInstance].window.rootViewController=controller;
    [[AppDelegate SharedInstance].window makeKeyAndVisible];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:NSLocalizedString( @"Error",nil) message:NSLocalizedString(@"Failed to Get Your Location",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
   // [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    // NSLog(@"didUpdateToLocation: %f, long = %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    CLLocation *currentLocation = newLocation;
    if (currentLocation != nil) {
        
        if (![Userlat isEqualToString:[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude]] && ![Userlong isEqualToString:[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude]]) {
            
                
                if (Userlat == nil || [Userlat isKindOfClass:[NSNull class]] ||  Userlong == nil || [Userlong isKindOfClass:[NSNull class]] ) {
                    //do something
                }else{ }
                
        
            NSString * Userlong1 = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
            [[NSUserDefaults standardUserDefaults] setObject:Userlong1 forKey:@"Userlong"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            NSString *Userlat2= [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
            [[NSUserDefaults standardUserDefaults] setObject:Userlat2 forKey:@"Userlat"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            NSLog(@"currentLocation.coordinate.longitude = %f, currentLocation.coordinate.latitude = %f", currentLocation.coordinate.longitude, currentLocation.coordinate.latitude);
            
            Userlong= [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"Userlong"];
            Userlat = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"Userlat"];
        }
        
    }
}

- (IBAction)btn_Done:(id)sender {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:dictLD forKey:@"LocationData"];
    [defaults setObject:dictLD[@"latitude"] forKey:@"SelectedLatitude"];
    [defaults setObject:dictLD[@"longitude"] forKey:@"SelectedLongitude"];
    
    [defaults synchronize];
    
    kAppDelegate.strSelectedLatitude = strSelectedLat;
    kAppDelegate.strSelectedLongitude = strSelectedLong;
    
    
    UIStoryboard *MainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    UINavigationController *controller = (UINavigationController*)[MainStoryboard instantiateViewControllerWithIdentifier: @"RootNavigationController"];
    UITabBarController *tabar = controller.viewControllers[0];
    [tabar setSelectedIndex:3];
    
    [AppDelegate SharedInstance].window.rootViewController=controller;
    [[AppDelegate SharedInstance].window makeKeyAndVisible];
    
}
@end

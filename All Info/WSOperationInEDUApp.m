//
//  WSOperationInSoloblend.m
//  Soloblend
//
//  Created by  Parkhya Solution on 11/26/14.
//  Copyright (c) 2014 ParkhyaSolutions. All rights reserved.
//



#import "WSOperationInEDUApp.h"
#import "AppDelegate.h"
#import "Reachability.h"
@implementation WSOperationInEDUApp
@synthesize	_delegate;
@synthesize _callback;

-(id)initWithDelegate:(id)delegate callback:(SEL)callback{
     if (self = [super init]) {
		self._delegate = delegate;
		self._callback = callback;
	}
	return self;
}
-(void)Get_category:(NSString *)language_id
{
    if([[Reachability sharedReachability] internetConnectionStatus] == NotReachable )
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Please check network connection.",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK" ,nil)otherButtonTitles:nil];
        [alert show];
        
    }else{
        [self hideLoader];

        [self showLoader];
        responseData=[[NSMutableData alloc]init];
        NSString *body=[NSString stringWithFormat:@"language_id=%@",language_id];
        NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
        //http://allinfo.co.il/all_info/webservice/master.php?action=get_subcategory&language_id=2
       // http://allinfo.co.il/all_info/webservice/master.php?action=all_category&language_id=2
        NSData *data=[body dataUsingEncoding:NSUTF8StringEncoding];
        [request setURL:[NSURL URLWithString:@"http://allinfo.co.il/all_info/webservice/master.php?action=all_category"]];
        [request setHTTPMethod:@"POST"];
        [request setTimeoutInterval:120];
        [request setHTTPBody:data];
        [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        conn=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    }

    
}
//http://allinfo.co.il/all_info/webservice/master.php?action=readReview&user_id=2
-(void)readReview:(NSString*)user_id
{
    if([[Reachability sharedReachability] internetConnectionStatus] == NotReachable )
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Please check network connection.",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK" ,nil)otherButtonTitles:nil];
        [alert show];
        
    }else{
        [self hideLoader];

        [self showLoader];
        responseData=[[NSMutableData alloc]init];
        NSString *body=[NSString stringWithFormat:@"user_id=%@",user_id];
        NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
        
        NSData *data=[body dataUsingEncoding:NSUTF8StringEncoding];
        [request setURL:[NSURL URLWithString:@"http://allinfo.co.il/all_info/webservice/master.php?action=readReview"]];
        [request setHTTPMethod:@"POST"];
        [request setTimeoutInterval:120];
        [request setHTTPBody:data];
        [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        conn=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    }
    
}
-(void)WriteReview:(NSString*)user_id language_id:(NSString*)language_id business_id:(NSString*)business_id name:(NSString*)name comment:(NSString*)comment rating:(NSString*)rating
{
    if([[Reachability sharedReachability] internetConnectionStatus] == NotReachable )
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Please check network connection.",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK" ,nil)otherButtonTitles:nil];
        [alert show];
        
    }else{
        
        
        [self hideLoader];

        [self showLoader];
        responseData=[[NSMutableData alloc]init];
        NSString *body=[NSString stringWithFormat:@"user_id=%@&language_id=%@&business_id=%@&name=%@&comment=%@&rating=%@&device_id=%@",user_id,language_id,business_id,name,comment,rating, kAppDelegate.strDeviceId ];
        NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
        
        NSLog(@"body = %@", body);
        
        NSData *data=[body dataUsingEncoding:NSUTF8StringEncoding];
        [request setURL:[NSURL URLWithString:@"http://allinfo.co.il/all_info/webservice/master.php?action=addReview"]];
        [request setHTTPMethod:@"POST"];
        [request setTimeoutInterval:120];
        [request setHTTPBody:data];
        [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        conn=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    }
    
}

-(void)Mapaddess:(NSString*)language input:(NSString*)input key:(NSString*)key
{
    if([[Reachability sharedReachability] internetConnectionStatus] == NotReachable )
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Please check network connection.",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK" ,nil)otherButtonTitles:nil];
        [alert show];
        
    }else{
        [self hideLoader];

        [self showLoader];
        responseData=[[NSMutableData alloc]init];
        NSString *body=[NSString stringWithFormat:@"language=%@&input=%@&key=%@",language,input,key];
        NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
        
        NSData *data=[body dataUsingEncoding:NSUTF8StringEncoding];
        [request setURL:[NSURL URLWithString:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?"]];
        [request setHTTPMethod:@"POST"];
        [request setTimeoutInterval:120];
        [request setHTTPBody:data];
        [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        conn=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    }
    
}
//http://allinfo.co.il/all_info/webservice/master.php?action=businessList&login_id=2&language_id=2
-(void)addbusinessList:(NSString*)login_id language_id:(NSString*)language_id page_no:(NSString*)page_no limit:(NSString*)limit
{
    if([[Reachability sharedReachability] internetConnectionStatus] == NotReachable )
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Please check network connection.",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK" ,nil)otherButtonTitles:nil];
        [alert show];
        
    }else{
        [self hideLoader];

           [self showLoader];
        responseData=[[NSMutableData alloc]init];
        NSString *body=[NSString stringWithFormat:@"login_id=%@&language_id=%@&page_no=%@&limit=%@",login_id,language_id,page_no,limit];
        NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
        
        NSData *data=[body dataUsingEncoding:NSUTF8StringEncoding];
        [request setURL:[NSURL URLWithString:@"http://allinfo.co.il/all_info/webservice/master.php?action=businessList"]];
        [request setHTTPMethod:@"POST"];
        [request setTimeoutInterval:120];
        [request setHTTPBody:data];
        [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        conn=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    }
    
}

-(void)get_business_type
{
    if([[Reachability sharedReachability] internetConnectionStatus] == NotReachable )
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Please check network connection.",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK" ,nil)otherButtonTitles:nil];
        [alert show];
        
    }else{
        //[self showLoader];
        responseData=[[NSMutableData alloc]init];
        NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
        //NSData *data=[body dataUsingEncoding:NSUTF8StringEncoding];
        [request setURL:[NSURL URLWithString:@"http://parkhyamapps.co.in/all_in/webservice/master.php?action=all_business"]];
        [request setHTTPMethod:@"POST"];
        [request setTimeoutInterval:120];
        //[request setHTTPBody:data];
        [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        conn=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    }
    
}

//http://topperszone.com/All_in/webservice/master.php?action=all_business

- (void)getMultipleSubCategoriesfromCatId:(NSArray *) arrCatIds andLanguage:(NSString *) strLan {
    
    NSError * error;
    NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:arrCatIds options:NSJSONWritingPrettyPrinted error:&error];
    NSString *strJsonArr = [[NSString alloc] initWithData:jsonData2 encoding:NSUTF8StringEncoding];
    
    NSLog(@"strJsonArr = %@", strJsonArr);
    if([[Reachability sharedReachability] internetConnectionStatus] == NotReachable )
      {
          UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Please check network connection.",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK" ,nil)otherButtonTitles:nil];
        [alert show];
        
      }else{
          
          responseData=[[NSMutableData alloc]init];
          NSString *body=[NSString stringWithFormat:@"category_id=%@&language_id=%@", strJsonArr, strLan];
          NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
          
          NSData *data=[body dataUsingEncoding:NSUTF8StringEncoding];
          [request setURL:[NSURL URLWithString:@"http://allinfo.co.il/all_info/webservice/master.php?action=all_subcategory"]];
          [request setHTTPMethod:@"POST"];
          [request setTimeoutInterval:120];
          [request setHTTPBody:data];
          [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
          conn=[[NSURLConnection alloc]initWithRequest:request delegate:self];
          
          
          NSLog(@"conn = %@", conn);
          
      }
}


-(void)get_subcategory:(NSString*)category_id{
    if([[Reachability sharedReachability] internetConnectionStatus] == NotReachable )
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Please check network connection.",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK" ,nil)otherButtonTitles:nil];
        [alert show];
        
    }else{
       
        responseData=[[NSMutableData alloc]init];
        NSString *body=[NSString stringWithFormat:@"language_id=%@",category_id];
        NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
        
        NSData *data=[body dataUsingEncoding:NSUTF8StringEncoding];
        [request setURL:[NSURL URLWithString:@"http://allinfo.co.il/all_info/webservice/master.php?action=get_subcategory"]];
        [request setHTTPMethod:@"POST"];
        [request setTimeoutInterval:120];
        [request setHTTPBody:data];
        [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        conn=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    }
    
}


- (void)getLastUpdate {
    
    if([[Reachability sharedReachability] internetConnectionStatus] == NotReachable )
      {
          UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Please check network connection.",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK" ,nil)otherButtonTitles:nil];
        [alert show];
        
      }else{
          
          responseData=[[NSMutableData alloc]init];
          NSString *body= @"";
          NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
          
          NSData *data=[body dataUsingEncoding:NSUTF8StringEncoding];
          [request setURL:[NSURL URLWithString:@"http://allinfo.co.il/all_info/webservice/master.php?action=last_update"]];
          [request setHTTPMethod:@"POST"];
          [request setTimeoutInterval:120];
          [request setHTTPBody:data];
          [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
          conn=[[NSURLConnection alloc]initWithRequest:request delegate:self];
          
          
          NSLog(@"conn = %@", conn);
          
      }
}

//http://allinfo.co.il/all_info/webservice/master.php?action=enquiry&name=test&email=mahiteat@gmail.com&phone=12345&subject=dfsalkh&message=dsksldhh

-(void)contact_request:(NSString*)name email:(NSString*)email phone:(NSString*)phone subject:(NSString*)subject message:(NSString*)message {
    if([[Reachability sharedReachability] internetConnectionStatus] == NotReachable )
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Please check network connection.",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK" ,nil)otherButtonTitles:nil];
        [alert show];
        
    }else{
        [self hideLoader];

         [self showLoader];
        responseData=[[NSMutableData alloc]init];
        NSString *body=[NSString stringWithFormat:@"name=%@&email=%@&phone=%@&subject=%@&message=%@",name,email,phone,subject,message];
        NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
        
        NSData *data=[body dataUsingEncoding:NSUTF8StringEncoding];
        [request setURL:[NSURL URLWithString:@"http://allinfo.co.il/all_info/webservice/master.php?action=enquiry"]];
        [request setHTTPMethod:@"POST"];
        [request setTimeoutInterval:120];
        [request setHTTPBody:data];
        [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        conn=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    }
    
}
-(void)oderResrvation:(NSString*)user_id name:(NSString*)name date:(NSString*)date time:(NSString*)time phone:(NSString*)phone no_of_people:(NSString*)no_of_people message:(NSString*)message{
    
    
    
    if([[Reachability sharedReachability] internetConnectionStatus] == NotReachable )
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Please check network connection.",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK" ,nil)otherButtonTitles:nil];
        [alert show];
        
    }else{
        [self hideLoader];

        [self showLoader];
        responseData=[[NSMutableData alloc]init];
        NSString *body=[NSString stringWithFormat:@"user_id=%@&name=%@&date=%@&time=%@&phone=%@&no_of_people=%@&message=%@",user_id,name,date,time,phone,no_of_people,message];
        NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
        
        NSData *data=[body dataUsingEncoding:NSUTF8StringEncoding];
        [request setURL:[NSURL URLWithString:@"http://allinfo.co.il/all_info/webservice/master.php?action=orderReservation"]];
        [request setHTTPMethod:@"POST"];
        [request setTimeoutInterval:120];
        [request setHTTPBody:data];
        [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        conn=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    }

}//&user_id=16&name=test&date=23-12-1345&time=12:30&phone=1234567&no_of_people=14234&message=test
//name=sunil&phone=123456&business_id=16&email_id=test@gmail.com&message=test
-(void)sendmessage:(NSString*)name phone:(NSString*)phone business_id:(NSString*)business_id email_id:(NSString*)email_id message:(NSString*)message{

    if([[Reachability sharedReachability] internetConnectionStatus] == NotReachable )
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Please check network connection.",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK" ,nil)otherButtonTitles:nil];
        [alert show];
        
    }else{
        // [self showLoader];
        
        responseData=[[NSMutableData alloc]init];
        NSString *body=[NSString stringWithFormat:@"name=%@&phone=%@&business_id=%@&email_id=%@&message=%@",name,phone,business_id,email_id,message];
        NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
        
        NSData *data=[body dataUsingEncoding:NSUTF8StringEncoding];
        [request setURL:[NSURL URLWithString:@"http://allinfo.co.il/all_info/webservice/master.php?action=sendMessage"]];
        [request setHTTPMethod:@"POST"];
        [request setTimeoutInterval:120];
        [request setHTTPBody:data];
        [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        conn=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    }

}

-(void)serchBynewbusinesss:(NSString*)string latitude:(NSString*)latitude longitude:(NSString*)longitude{
    
    
    
    if([[Reachability sharedReachability] internetConnectionStatus] == NotReachable )
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Please check network connection.",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK" ,nil)otherButtonTitles:nil];
        [alert show];


    }else{
        // [self showLoader];
        responseData=[[NSMutableData alloc]init];
        NSString *body=[NSString stringWithFormat:@"string=%@&latitude=%@&longitude=%@",string,latitude,longitude];
        NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
        
        NSData *data=[body dataUsingEncoding:NSUTF8StringEncoding];
        [request setURL:[NSURL URLWithString:@"http://allinfo.co.il/all_info/webservice/master.php?action=search"]];
        [request setHTTPMethod:@"POST"];
        [request setTimeoutInterval:120];
        [request setHTTPBody:data];
        [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        conn=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    }
    
}

//http://allinfo.co.il/all_info/webservice/master.php?action=searchBusiness&sub_cat_id=2&language_id=2&latitude=22.7295213&longitude=75.8631904
-(void)GatBusinesid:(NSString*)language {
    if([[Reachability sharedReachability] internetConnectionStatus] == NotReachable )
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Please check network connection.",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK" ,nil)otherButtonTitles:nil];
        [alert show];
        
    }else{
        // [self showLoader];
        
        responseData=[[NSMutableData alloc]init];
        NSString *body=[NSString stringWithFormat:@"language_id=%@",language];
        NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
        
        NSData *data=[body dataUsingEncoding:NSUTF8StringEncoding];
        [request setURL:[NSURL URLWithString:@"http://allinfo.co.il/all_info/webservice/master.php?action=all_business"]];
        [request setHTTPMethod:@"POST"];
        [request setTimeoutInterval:120];
        [request setHTTPBody:data];
        [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        conn=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    }


}
-(void)searchBusiness:(NSString*)latitude longitude:(NSString*)longitude  {
    if([[Reachability sharedReachability] internetConnectionStatus] == NotReachable )
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Please check network connection.",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK" ,nil)otherButtonTitles:nil];
        [alert show];
        
    }else{
       // [self showLoader];
       
        responseData=[[NSMutableData alloc]init];
        NSString *body=[NSString stringWithFormat:@"latitude=%@&longitude=%@",latitude,longitude];
        NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
        
        NSData *data=[body dataUsingEncoding:NSUTF8StringEncoding];
        [request setURL:[NSURL URLWithString:@"http://allinfo.co.il/all_info/webservice/master.php?action=AllBusiness"]];
        [request setHTTPMethod:@"POST"];
        [request setTimeoutInterval:120];
        [request setHTTPBody:data];
        [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        conn=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    }
    
}
-(void)SlectedbySubId:(NSString*)sub_cat_id language_id:(NSString*)language_id latitude:(NSString*)latitude longitude:(NSString*)longitude  {
    if([[Reachability sharedReachability] internetConnectionStatus] == NotReachable )
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Please check network connection.",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK" ,nil)otherButtonTitles:nil];
        [alert show];
        
    }else{
        // [self showLoader];language_id
        responseData=[[NSMutableData alloc]init];
        NSString *body=[NSString stringWithFormat:@"sub_cat_id=%@&language_id=%@&latitude=%@&longitude=%@",sub_cat_id,language_id,latitude,longitude];
        NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
        
        NSData *data=[body dataUsingEncoding:NSUTF8StringEncoding];
        [request setURL:[NSURL URLWithString:@"http://allinfo.co.il/all_info/webservice/master.php?action=searchBusiness"]];
        [request setHTTPMethod:@"POST"];
        [request setTimeoutInterval:120];
        [request setHTTPBody:data];
        [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        conn=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    }
    
}

#pragma mark.....Login api

-(void)Login:(NSString*)language_id email:(NSString*)email password:(NSString*)password  {
    if([[Reachability sharedReachability] internetConnectionStatus] == NotReachable )
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Please check network connection.",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK" ,nil)otherButtonTitles:nil];
        [alert show];
        
    }else{
        [self hideLoader];

        [self showLoader];
        responseData=[[NSMutableData alloc]init];
        NSString *body=[NSString stringWithFormat:@"language_id=%@&email=%@&password=%@",language_id,email,password];
        NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
        
        NSData *data=[body dataUsingEncoding:NSUTF8StringEncoding];
        [request setURL:[NSURL URLWithString:@"http://allinfo.co.il/all_info/webservice/master.php?action=login"]];
        [request setHTTPMethod:@"POST"];
        [request setTimeoutInterval:120];
        [request setHTTPBody:data];
        [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        conn=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    }
    
}

#pragma mark.....Social Login api

-(void)FBLogin_action:(NSString*)action social_id:(NSString*)social_id language_id:(NSString*)language_id email:(NSString*)email username:(NSString*)username profile_image:(NSString*)profile_image social_type:(NSString*)social_type {
    if([[Reachability sharedReachability] internetConnectionStatus] == NotReachable )
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Please check network connection.",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK" ,nil)otherButtonTitles:nil];
        [alert show];
        
    }else{
        [self hideLoader];
        
        [self showLoader];
        responseData=[[NSMutableData alloc]init];
        NSString *body=[NSString stringWithFormat:@"social_id=%@&language_id=%@&email=%@&username=%@&profile_image=%@&social_type=%@",social_id,language_id,email,username,profile_image,social_type];
        NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
        
        NSData *data=[body dataUsingEncoding:NSUTF8StringEncoding];
        [request setURL:[NSURL URLWithString:@"http://allinfo.co.il/all_info/webservice/master.php?action=socialLogin"]];
        [request setHTTPMethod:@"POST"];
        [request setTimeoutInterval:120];
        [request setHTTPBody:data];
        [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        conn=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    }
    
}

-(void)GOOGLELogin_action:(NSString*)action social_id:(NSString*)social_id language_id:(NSString*)language_id email:(NSString*)email username:(NSString*)username profile_image:(NSString*)profile_image social_type:(NSString*)social_type {
    if([[Reachability sharedReachability] internetConnectionStatus] == NotReachable )
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Please check network connection.",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK" ,nil)otherButtonTitles:nil];
        [alert show];
        
    }else{
        [self hideLoader];
        
        [self showLoader];
        responseData=[[NSMutableData alloc]init];
        NSString *body=[NSString stringWithFormat:@"social_id=%@&language_id=%@&email=%@&username=%@&profile_image=%@&social_type=%@",social_id,language_id,email,username,profile_image,social_type];
        
        NSLog(@"google login body....%@",body);
        NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
        
        NSData *data=[body dataUsingEncoding:NSUTF8StringEncoding];
        [request setURL:[NSURL URLWithString:@"http://allinfo.co.il/all_info/webservice/master.php?action=socialLogin"]];
        [request setHTTPMethod:@"POST"];
        [request setTimeoutInterval:120];
        [request setHTTPBody:data];
        [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        conn=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    }
}


-(void)UserRegistraion:(NSString*)username  email:(NSString*)email password:(NSString*)password  phone:(NSString*)phone address:(NSString*)address latitude:(NSString*)latitude longitude:(NSString*)longitude business_name:(NSString*)business_name business_type_id:(NSString*)business_type_id description:(NSString*)description website_url:(NSString*)website_url sub_cat_id:(NSString*)sub_cat_id user_image:(UIImage*)ProfileImage Addimg1:(UIImage*)Addimg1 Addimg2:(UIImage*)Addimg2 Addimg3:(UIImage*)Addimg3 Addimg4:(UIImage*)Addimg4 Addimg5:(UIImage*)Addimg5 Addimg6:(UIImage*)Addimg6  Addimg7:(UIImage*)Addimg7 Addimg8:(UIImage*)Addimg8 Addimg9:(UIImage*)Addimg9 Addimg10:(UIImage*)Addimg10 business_email:(NSString*)business_email facebook_url:(NSString*)facebook_url video_url:(NSString*)video_url language_id:(NSString*)language_id start_time:(NSString*)start_time end_time:(NSString*)end_time MenuUrl:(NSString *) menuUrl TableUrl:(NSString *) tableUrl BusinessHoursStatus:(NSString *) status

{
    if([[Reachability sharedReachability] internetConnectionStatus] == NotReachable )
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Please check network connection.",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK" ,nil)otherButtonTitles:nil];
        [alert show];
        
    }else{
        [self hideLoader];

        [self showLoader];
        responseData = [[NSMutableData alloc] init] ;
     
        NSString *boundary = @"---------------------------14737809831466499882746641449";
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
        
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        
        NSMutableData *data=[[NSMutableData alloc]init];
        // data=[body dataUsingEncoding:NSUTF8StringEncoding];
       // http://182.72.80.18/ufc/webservices/ufc_webservices.php?method=Userinforedit&name=Jain&l_name=Minakshi&facebook_id=986466638091361&emails=sunil@gmail.com
        [request setURL:[NSURL URLWithString:@"http://allinfo.co.il/all_info/webservice/master.php?action=registration"]];
        
        [request setHTTPMethod:@"POST"];
        
        [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
        
        [request setTimeoutInterval:120.0];
        
        if (ProfileImage) {
    
            NSData *imageData = UIImageJPEGRepresentation(ProfileImage,0.3f);
            NSString*  filename = [NSString stringWithFormat:@"%@",@"MyImage"];  //setimage file  name here
            NSLog(@"%@", filename);
            [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"user_image\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
            [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];

            [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"user_image\"]; filename=\"profile_image.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            
            [data appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [data appendData:[NSData dataWithData:imageData]];
            [data appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        }else{
            NSString*  filename = @"";  //setimage file  name here
            [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"user_image\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
            [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        }
        
        UIImage *secondImage = [UIImage imageNamed:@"ALLINFO_App_registration_n_b screen_profile pic display.png"];
        
        if (Addimg1) {
            NSData *imageData = UIImageJPEGRepresentation(Addimg1,0.3f);
                // UIImage *secondImage = [UIImage imageNamed:@"add_image.png"];
            NSData *imgData2 =UIImageJPEGRepresentation(secondImage,0.3f);
            BOOL isCompare =  [imageData isEqual:imgData2];
            if(isCompare)
            {
                NSLog(@"Image View contains image.png");
                NSString*  filename = @"";  //setimage file  name here
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image1\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            }
            else
            {
                NSLog(@"Image View doesn't contains image.png");
                NSString*  filename = [NSString stringWithFormat:@"%@",@"MyImage"];  //setimage file  name here
                NSLog(@"%@", filename);
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image1\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image1\"]; filename=\"profile_image.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[NSData dataWithData:imageData]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            }
            
            
        }
        if (Addimg2) {
            
            NSData *imageData = UIImageJPEGRepresentation(Addimg2,0.3f);
                // UIImage *secondImage = [UIImage imageNamed:@"add_image.png"];
            
            
            NSData *imgData2 =UIImageJPEGRepresentation(secondImage,0.3f);
            
            BOOL isCompare =  [imageData isEqual:imgData2];
            if(isCompare)
            {
                NSString*  filename = @"";  //setimage file  name here
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image2\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];            }
            else
            {
                NSString*  filename = [NSString stringWithFormat:@"%@",@"MyImage"];  //setimage file  name here
                NSLog(@"%@", filename);
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image2\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image2\"]; filename=\"profile_image.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[NSData dataWithData:imageData]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            }
            
        }
        if (Addimg3) {
            
            NSData *imageData = UIImageJPEGRepresentation(Addimg3,0.3f);
                //UIImage *secondImage = [UIImage imageNamed:@"add_image.png"];
            
            
            NSData *imgData2 =UIImageJPEGRepresentation(secondImage,0.3f);
            
            BOOL isCompare =  [imageData isEqual:imgData2];
            if(isCompare)
            {
                NSString*  filename = @"";  //setimage file  name here
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image3\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            }
            else
            {
                NSString*  filename = [NSString stringWithFormat:@"%@",@"MyImage"];  //setimage file  name here
                NSLog(@"%@", filename);
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image3\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image3\"]; filename=\"profile_image.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[NSData dataWithData:imageData]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            }
            
        }
        if (Addimg4) {
            
            NSData *imageData = UIImageJPEGRepresentation(Addimg4,0.3f);
                // UIImage *secondImage = [UIImage imageNamed:@"add_image.png"];
            
            NSData *imgData2 =UIImageJPEGRepresentation(secondImage,0.3f);
            
            BOOL isCompare =  [imageData isEqual:imgData2];
            if(isCompare)
            {
                NSString*  filename = @"";  //setimage file  name here
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image4\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            }
            else
            {
                NSString*  filename = [NSString stringWithFormat:@"%@",@"MyImage"];  //setimage file  name here
                NSLog(@"%@", filename);
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image4\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image4\"]; filename=\"profile_image.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[NSData dataWithData:imageData]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            }
            
        }
        if (Addimg5) {
            
            NSData *imageData = UIImageJPEGRepresentation(Addimg5,0.3f);
                // UIImage *secondImage = [UIImage imageNamed:@"add_image.png"];
            
            
            NSData *imgData2 =UIImageJPEGRepresentation(secondImage,0.3f);
            
            BOOL isCompare =  [imageData isEqual:imgData2];
            if(isCompare)
            {
                NSString*  filename = @"";  //setimage file  name here
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image5\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            }
            else
            {
                NSString*  filename = [NSString stringWithFormat:@"%@",@"MyImage"];  //setimage file  name here
                NSLog(@"%@", filename);
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image5\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image5\"]; filename=\"profile_image.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[NSData dataWithData:imageData]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            }
            
        }
        if (Addimg6) {
            
            NSData *imageData = UIImageJPEGRepresentation(Addimg6,0.3f);
                //  UIImage *secondImage = [UIImage imageNamed:@"add_image.png"];
            
            
            NSData *imgData2 =UIImageJPEGRepresentation(secondImage,0.3f);
            
            BOOL isCompare =  [imageData isEqual:imgData2];
            if(isCompare)
            {
                NSString*  filename = @"";  //setimage file  name here
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image6\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            }
            else
            {
                NSString*  filename = [NSString stringWithFormat:@"%@",@"MyImage"];  //setimage file  name here
                NSLog(@"%@", filename);
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image6\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image6\"]; filename=\"profile_image.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[NSData dataWithData:imageData]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            }
            
        }
        
        if (Addimg7) {
            
            NSData *imageData = UIImageJPEGRepresentation(Addimg7,0.3f);
                // UIImage *secondImage = [UIImage imageNamed:@"add_image.png"];
            
            
            NSData *imgData2 =UIImageJPEGRepresentation(secondImage,0.3f);
            
            BOOL isCompare =  [imageData isEqual:imgData2];
            if(isCompare)
              {
                NSString*  filename = @"";  //setimage file  name here
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image7\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
              }
            else
              {
                NSString*  filename = [NSString stringWithFormat:@"%@",@"MyImage"];  //setimage file  name here
                NSLog(@"%@", filename);
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image7\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image7\"]; filename=\"profile_image.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[NSData dataWithData:imageData]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
              }
            
        }
        
        if (Addimg8) {
            
            NSData *imageData = UIImageJPEGRepresentation(Addimg8,0.3f);
                //  UIImage *secondImage = [UIImage imageNamed:@"add_image.png"];
            
            
            NSData *imgData2 =UIImageJPEGRepresentation(secondImage,0.3f);
            
            BOOL isCompare =  [imageData isEqual:imgData2];
            if(isCompare)
              {
                NSString*  filename = @"";  //setimage file  name here
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image8\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
              }
            else
              {
                NSString*  filename = [NSString stringWithFormat:@"%@",@"MyImage"];  //setimage file  name here
                NSLog(@"%@", filename);
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image8\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image8\"]; filename=\"profile_image.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[NSData dataWithData:imageData]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
              }
            
        }
        
        if (Addimg9) {
            
            NSData *imageData = UIImageJPEGRepresentation(Addimg9,0.3f);
                // UIImage *secondImage = [UIImage imageNamed:@"add_image.png"];
            
            
            NSData *imgData2 =UIImageJPEGRepresentation(secondImage,0.3f);
            
            BOOL isCompare =  [imageData isEqual:imgData2];
            if(isCompare)
              {
                NSString*  filename = @"";  //setimage file  name here
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image9\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
              }
            else
              {
                NSString*  filename = [NSString stringWithFormat:@"%@",@"MyImage"];  //setimage file  name here
                NSLog(@"%@", filename);
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image9\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image9\"]; filename=\"profile_image.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[NSData dataWithData:imageData]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
              }
            
        }
        
        if (Addimg10) {
            
            NSData *imageData = UIImageJPEGRepresentation(Addimg10,0.3f);
            UIImage *secondImage = [UIImage imageNamed:@"add_image.png"];
            
            
            NSData *imgData2 =UIImageJPEGRepresentation(secondImage,0.3f);
            
            BOOL isCompare =  [imageData isEqual:imgData2];
            if(isCompare)
              {
                NSString*  filename = @"";  //setimage file  name here
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image10\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
              }
            else
              {
                NSString*  filename = [NSString stringWithFormat:@"%@",@"MyImage"];  //setimage file  name here
                NSLog(@"%@", filename);
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image10\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image10\"]; filename=\"profile_image.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[NSData dataWithData:imageData]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
              }
            
        }




        //setimage file  name here
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"username\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[username dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"video_url\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[video_url dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"email\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[email dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"password\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[password dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
       
        
        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"phone\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[phone dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"address\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[address dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"latitude\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[latitude dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"language_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[language_id dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];

        
        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"longitude\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[longitude dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"business_name\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[business_name dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"business_type_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[business_type_id dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"description\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[description dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"website_url\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[website_url dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"sub_cat_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[sub_cat_id dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"facebook_url\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[facebook_url dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"business_email\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[business_email dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];

        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"start_time\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[start_time dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"end_time\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[end_time dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];

        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"menu_url\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[menuUrl dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
            /// Table Url
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"table_reservation_url\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[tableUrl dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
            /// is Open
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"is_open\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[status dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];

        NSLog(@"status = %@", status);
        
        
        
        [request setHTTPBody:data];
        conn=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    }
}

//login_id

-(void)AddbusinessRegi:(NSString*)phone login_id:(NSString*)login_id address:(NSString*)address latitude:(NSString*)latitude longitude:(NSString*)longitude business_name:(NSString*)business_name business_type_id:(NSString*)business_type_id description:(NSString*)description website_url:(NSString*)website_url sub_cat_id:(NSString*)sub_cat_id Addimg1:(UIImage*)Addimg1 Addimg2:(UIImage*)Addimg2 Addimg3:(UIImage*)Addimg3 Addimg4:(UIImage*)Addimg4 Addimg5:(UIImage*)Addimg5 Addimg6:(UIImage*)Addimg6 Addimg7:(UIImage*)Addimg7 Addimg8:(UIImage*)Addimg8 Addimg9:(UIImage*)Addimg9 Addimg10:(UIImage*)Addimg10 business_email:(NSString*)business_email facebook_url:(NSString*)facebook_url video_url:(NSString*)video_url language_id:(NSString*)language_id start_time:(NSString*)start_time end_time:(NSString*)end_time MenuUrl:(NSString *) menuUrl TableUrl:(NSString *) tableUrl BusinessHoursStatus:(NSString *) status{
    
    NSLog(@"sub_cat_id = %@", sub_cat_id);

    if([[Reachability sharedReachability] internetConnectionStatus] == NotReachable )
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Please check network connection.",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK" ,nil)otherButtonTitles:nil];
        [alert show];
        
    }else{
        [self showLoader];
        responseData = [[NSMutableData alloc] init] ;
        
        NSString *boundary = @"---------------------------14737809831466499882746641449";
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
        
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        
        NSMutableData *data=[[NSMutableData alloc]init];
        // data=[body dataUsingEncoding:NSUTF8StringEncoding];
        // http://182.72.80.18/ufc/webservices/ufc_webservices.php?method=Userinforedit&name=Jain&l_name=Minakshi&facebook_id=986466638091361&emails=sunil@gmail.com
        [request setURL:[NSURL URLWithString:@"http://allinfo.co.il/all_info/webservice/master.php?action=add_business"]];
        
        [request setHTTPMethod:@"POST"];
        
        [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
        
        [request setTimeoutInterval:120.0];
        
        
        
        UIImage *secondImage = [UIImage imageNamed:@"ALLINFO_App_registration_n_b screen_profile pic display.png"];
        if (Addimg1) {
            NSData *imageData = UIImageJPEGRepresentation(Addimg1,0.3f);
            
            NSData *imgData2 =UIImageJPEGRepresentation(secondImage,0.3f);
            BOOL isCompare =  [imageData isEqual:imgData2];
            if(isCompare)
            {
                NSLog(@"Image View contains image.png");
                NSString*  filename = @"";  //setimage file  name here
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image1\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            }
            else
            {
                NSLog(@"Image View doesn't contains image.png");
                NSString*  filename = [NSString stringWithFormat:@"%@",@"MyImage"];  //setimage file  name here
                NSLog(@"%@", filename);
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image1\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image1\"]; filename=\"profile_image.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[NSData dataWithData:imageData]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            }
            
            
        }
        if (Addimg2) {
            
            NSData *imageData = UIImageJPEGRepresentation(Addimg2,0.3f);
            
    
            NSData *imgData2 =UIImageJPEGRepresentation(secondImage,0.3f);
            
            BOOL isCompare =  [imageData isEqual:imgData2];
            if(isCompare)
            {
                NSString*  filename = @"";  //setimage file  name here
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image2\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];            }
            else
            {
                NSString*  filename = [NSString stringWithFormat:@"%@",@"MyImage"];  //setimage file  name here
                NSLog(@"%@", filename);
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image2\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image2\"]; filename=\"profile_image.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[NSData dataWithData:imageData]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            }
           
        }
        if (Addimg3) {
            
            NSData *imageData = UIImageJPEGRepresentation(Addimg3,0.3f);
            
           
            NSData *imgData2 =UIImageJPEGRepresentation(secondImage,0.3f);
            
            BOOL isCompare =  [imageData isEqual:imgData2];
            if(isCompare)
            {
                NSString*  filename = @"";  //setimage file  name here
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image3\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            }
            else
            {
                NSString*  filename = [NSString stringWithFormat:@"%@",@"MyImage"];  //setimage file  name here
                NSLog(@"%@", filename);
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image3\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image3\"]; filename=\"profile_image.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[NSData dataWithData:imageData]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            }
            
        }
        if (Addimg4) {
            
            NSData *imageData = UIImageJPEGRepresentation(Addimg4,0.3f);
            
            NSData *imgData2 =UIImageJPEGRepresentation(secondImage,0.3f);
            
            BOOL isCompare =  [imageData isEqual:imgData2];
            if(isCompare)
            {
                NSString*  filename = @"";  //setimage file  name here
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image4\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            }
            else
            {
                NSString*  filename = [NSString stringWithFormat:@"%@",@"MyImage"];  //setimage file  name here
                NSLog(@"%@", filename);
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image4\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image4\"]; filename=\"profile_image.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[NSData dataWithData:imageData]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            }
            
        }
        if (Addimg5) {
            
            NSData *imageData = UIImageJPEGRepresentation(Addimg5,0.3f);
            
            
            NSData *imgData2 =UIImageJPEGRepresentation(secondImage,0.3f);
            
            BOOL isCompare =  [imageData isEqual:imgData2];
            if(isCompare)
            {
                NSString*  filename = @"";  //setimage file  name here
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image5\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            }
            else
            {
                NSString*  filename = [NSString stringWithFormat:@"%@",@"MyImage"];  //setimage file  name here
                NSLog(@"%@", filename);
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image5\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image5\"]; filename=\"profile_image.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[NSData dataWithData:imageData]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            }
           
        }
        if (Addimg6) {
            NSData *imageData = UIImageJPEGRepresentation(Addimg6,0.3f);
            NSData *imgData2 =UIImageJPEGRepresentation(secondImage,0.3f);
            BOOL isCompare =  [imageData isEqual:imgData2];
            if(isCompare)
            {
                NSString*  filename = @"";  //setimage file  name here
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image6\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            }
            else
            {
                NSString*  filename = [NSString stringWithFormat:@"%@",@"MyImage"];  //setimage file  name here
                NSLog(@"%@", filename);
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image6\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image6\"]; filename=\"profile_image.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[NSData dataWithData:imageData]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            }
          
        }
        
        if (Addimg7) {
            NSData *imageData = UIImageJPEGRepresentation(Addimg7,0.3f);
            NSData *imgData2 =UIImageJPEGRepresentation(secondImage,0.3f);
            BOOL isCompare =  [imageData isEqual:imgData2];
            if(isCompare)
              {
                NSString*  filename = @"";  //setimage file  name here
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image7\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
              }
            else
              {
                NSString*  filename = [NSString stringWithFormat:@"%@",@"MyImage"];  //setimage file  name here
                NSLog(@"%@", filename);
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image7\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image7\"]; filename=\"profile_image.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[NSData dataWithData:imageData]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
              }
            
        }
        
        if (Addimg8) {
            NSData *imageData = UIImageJPEGRepresentation(Addimg8,0.3f);
            NSData *imgData2 =UIImageJPEGRepresentation(secondImage,0.3f);
            BOOL isCompare =  [imageData isEqual:imgData2];
            if(isCompare)
              {
                NSString*  filename = @"";  //setimage file  name here
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image8\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
              }
            else
              {
                NSString*  filename = [NSString stringWithFormat:@"%@",@"MyImage"];  //setimage file  name here
                NSLog(@"%@", filename);
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image8\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image8\"]; filename=\"profile_image.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[NSData dataWithData:imageData]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
              }
            
        }
        
        if (Addimg9) {
            NSData *imageData = UIImageJPEGRepresentation(Addimg9,0.3f);
            NSData *imgData2 =UIImageJPEGRepresentation(secondImage,0.3f);
            BOOL isCompare =  [imageData isEqual:imgData2];
            if(isCompare)
              {
                NSString*  filename = @"";  //setimage file  name here
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image9\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
              }
            else
              {
                NSString*  filename = [NSString stringWithFormat:@"%@",@"MyImage"];  //setimage file  name here
                NSLog(@"%@", filename);
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image9\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image9\"]; filename=\"profile_image.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[NSData dataWithData:imageData]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
              }
            
        }
        
        if (Addimg10) {
            NSData *imageData = UIImageJPEGRepresentation(Addimg10,0.3f);
            NSData *imgData2 =UIImageJPEGRepresentation(secondImage,0.3f);
            BOOL isCompare =  [imageData isEqual:imgData2];
            if(isCompare) {
                NSString*  filename = @"";  //setimage file  name here
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image10\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
              } else {
                NSString*  filename = [NSString stringWithFormat:@"%@",@"MyImage"];  //setimage file  name here
                NSLog(@"%@", filename);
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image10\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image10\"]; filename=\"profile_image.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[NSData dataWithData:imageData]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
              }
            
        }
        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"phone\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[phone dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"login_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[login_id dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"video_url\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[video_url dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"address\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[address dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"latitude\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[latitude dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"language_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[language_id dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"longitude\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[longitude dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"business_name\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[business_name dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"business_type_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[business_type_id dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"description\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[description dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"website_url\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[website_url dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"sub_cat_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[sub_cat_id dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"facebook_url\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[facebook_url dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"business_email\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[business_email dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"start_time\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[start_time dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
            ///Menu Url
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"menu_url\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[menuUrl dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
/// Table Url
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"table_reservation_url\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[tableUrl dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];

            /// is Open
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"is_open\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[status dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];

        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"end_time\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[end_time dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPBody:data];
        conn=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    }
}

//update businew
-(void)updatebusinessRegi:(NSString*)phone user_id:(NSString*)user_id address:(NSString*)address latitude:(NSString*)latitude longitude:(NSString*)longitude business_name:(NSString*)business_name business_type_id:(NSString*)business_type_id description:(NSString*)description website_url:(NSString*)website_url sub_cat_id:(NSString*)sub_cat_id Addimg1:(UIImage*)Addimg1 Addimg2:(UIImage*)Addimg2 Addimg3:(UIImage*)Addimg3 Addimg4:(UIImage*)Addimg4 Addimg5:(UIImage*)Addimg5 Addimg6:(UIImage*)Addimg6  Addimg7:(UIImage*)Addimg7 Addimg8:(UIImage*)Addimg8 Addimg9:(UIImage*)Addimg9 Addimg10:(UIImage*)Addimg10 business_email:(NSString*)business_email facebook_url:(NSString*)facebook_url video_url:(NSString*)video_url language_id:(NSString*)language_id start_time:(NSString*)start_time end_time:(NSString*)end_time MenuUrl:(NSString *) menuUrl TableUrl:(NSString *) tableUrl BusinessHoursStatus:(NSString *) status{
    
    NSLog(@"status = %@", status);
    
    if([[Reachability sharedReachability] internetConnectionStatus] == NotReachable )
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Please check network connection.",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK" ,nil)otherButtonTitles:nil];
        [alert show];
        
    }else{
        [self showLoader];
        responseData = [[NSMutableData alloc] init] ;
        
        NSString *boundary = @"---------------------------14737809831466499882746641449";
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
        
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        
        NSMutableData *data=[[NSMutableData alloc]init];
        // data=[body dataUsingEncoding:NSUTF8StringEncoding];
        // http://182.72.80.18/ufc/webservices/ufc_webservices.php?method=Userinforedit&name=Jain&l_name=Minakshi&facebook_id=986466638091361&emails=sunil@gmail.com
        [request setURL:[NSURL URLWithString:@"http://allinfo.co.il/all_info/webservice/master.php?action=updateProfile"]];
        
        [request setHTTPMethod:@"POST"];
        
        [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
        
        [request setTimeoutInterval:120.0];
        
        if (Addimg1) {
            NSData *imageData = UIImageJPEGRepresentation(Addimg1,0.3f);
            UIImage *secondImage = [UIImage imageNamed:@"add_image.png"];
            NSData *imgData2 =UIImageJPEGRepresentation(secondImage,0.3f);
            BOOL isCompare =  [imageData isEqual:imgData2];
            if(isCompare)
            {
                NSLog(@"Image View contains image.png");
                NSString*  filename = @"";  //setimage file  name here
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image1\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            }
            else
            {
                NSLog(@"Image View doesn't contains image.png");
                NSString*  filename = [NSString stringWithFormat:@"%@",@"MyImage"];  //setimage file  name here
                NSLog(@"%@", filename);
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image1\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image1\"]; filename=\"profile_image.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[NSData dataWithData:imageData]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            }
            
            
        }
        if (Addimg2) {
            
            NSData *imageData = UIImageJPEGRepresentation(Addimg2,0.3f);
            UIImage *secondImage = [UIImage imageNamed:@"add_image.png"];
            
            
            NSData *imgData2 =UIImageJPEGRepresentation(secondImage,0.3f);
            
            BOOL isCompare =  [imageData isEqual:imgData2];
            if(isCompare)
            {
                NSString*  filename = @"";  //setimage file  name here
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image2\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];            }
            else
            {
                NSString*  filename = [NSString stringWithFormat:@"%@",@"MyImage"];  //setimage file  name here
                NSLog(@"%@", filename);
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image2\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image2\"]; filename=\"profile_image.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[NSData dataWithData:imageData]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            }
            
        }
        if (Addimg3) {
            
            NSData *imageData = UIImageJPEGRepresentation(Addimg3,0.3f);
            UIImage *secondImage = [UIImage imageNamed:@"add_image.png"];
            
            
            NSData *imgData2 =UIImageJPEGRepresentation(secondImage,0.3f);
            
            BOOL isCompare =  [imageData isEqual:imgData2];
            if(isCompare)
            {
                NSString*  filename = @"";  //setimage file  name here
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image3\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            }
            else
            {
                NSString*  filename = [NSString stringWithFormat:@"%@",@"MyImage"];  //setimage file  name here
                NSLog(@"%@", filename);
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image3\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image3\"]; filename=\"profile_image.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[NSData dataWithData:imageData]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            }
            
        }
        if (Addimg4) {
            
            NSData *imageData = UIImageJPEGRepresentation(Addimg4,0.3f);
            UIImage *secondImage = [UIImage imageNamed:@"add_image.png"];
            
            NSData *imgData2 =UIImageJPEGRepresentation(secondImage,0.3f);
            
            BOOL isCompare =  [imageData isEqual:imgData2];
            if(isCompare)
            {
                NSString*  filename = @"";  //setimage file  name here
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image4\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            }
            else
            {
                NSString*  filename = [NSString stringWithFormat:@"%@",@"MyImage"];  //setimage file  name here
                NSLog(@"%@", filename);
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image4\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image4\"]; filename=\"profile_image.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[NSData dataWithData:imageData]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            }
            
        }
        if (Addimg5) {
            
            NSData *imageData = UIImageJPEGRepresentation(Addimg5,0.3f);
            UIImage *secondImage = [UIImage imageNamed:@"add_image.png"];
            
            
            NSData *imgData2 =UIImageJPEGRepresentation(secondImage,0.3f);
            
            BOOL isCompare =  [imageData isEqual:imgData2];
            if(isCompare)
            {
                NSString*  filename = @"";  //setimage file  name here
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image5\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            }
            else
            {
                NSString*  filename = [NSString stringWithFormat:@"%@",@"MyImage"];  //setimage file  name here
                NSLog(@"%@", filename);
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image5\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image5\"]; filename=\"profile_image.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[NSData dataWithData:imageData]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            }
            
        }
        
        if (Addimg6) {
            
            NSData *imageData = UIImageJPEGRepresentation(Addimg6,0.3f);
            UIImage *secondImage = [UIImage imageNamed:@"add_image.png"];
            
            
            NSData *imgData2 =UIImageJPEGRepresentation(secondImage,0.3f);
            
            BOOL isCompare =  [imageData isEqual:imgData2];
            if(isCompare)
            {
                NSString*  filename = @"";  //setimage file  name here
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image6\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            }
            else
            {
                NSString*  filename = [NSString stringWithFormat:@"%@",@"MyImage"];  //setimage file  name here
                NSLog(@"%@", filename);
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image6\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image6\"]; filename=\"profile_image.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[NSData dataWithData:imageData]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            }
            
        }
        
        if (Addimg7) {
            NSData *imageData = UIImageJPEGRepresentation(Addimg7,0.3f);
            UIImage *secondImage = [UIImage imageNamed:@"add_image.png"];
            NSData *imgData2 =UIImageJPEGRepresentation(secondImage,0.3f);
            BOOL isCompare =  [imageData isEqual:imgData2];
            if(isCompare)
              {
                NSString*  filename = @"";  //setimage file  name here
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image7\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
              }
            else
              {
                NSString*  filename = [NSString stringWithFormat:@"%@",@"MyImage"];  //setimage file  name here
                NSLog(@"%@", filename);
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image7\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image7\"]; filename=\"profile_image.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[NSData dataWithData:imageData]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
              }
            
        }
        
        if (Addimg8) {
            NSData *imageData = UIImageJPEGRepresentation(Addimg8,0.3f);
            UIImage *secondImage = [UIImage imageNamed:@"add_image.png"];
            NSData *imgData2 =UIImageJPEGRepresentation(secondImage,0.3f);
            BOOL isCompare =  [imageData isEqual:imgData2];
            if(isCompare)
              {
                NSString*  filename = @"";  //setimage file  name here
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image8\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
              }
            else
              {
                NSString*  filename = [NSString stringWithFormat:@"%@",@"MyImage"];  //setimage file  name here
                NSLog(@"%@", filename);
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image8\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image8\"]; filename=\"profile_image.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[NSData dataWithData:imageData]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
              }
            
        }
        
        if (Addimg9) {
            NSData *imageData = UIImageJPEGRepresentation(Addimg9,0.3f);
            UIImage *secondImage = [UIImage imageNamed:@"add_image.png"];
            NSData *imgData2 =UIImageJPEGRepresentation(secondImage,0.3f);
            BOOL isCompare =  [imageData isEqual:imgData2];
            if(isCompare)
              {
                NSString*  filename = @"";  //setimage file  name here
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image9\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
              }
            else
              {
                NSString*  filename = [NSString stringWithFormat:@"%@",@"MyImage"];  //setimage file  name here
                NSLog(@"%@", filename);
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image9\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image9\"]; filename=\"profile_image.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[NSData dataWithData:imageData]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
              }
            
        }
        
        if (Addimg10) {
            NSData *imageData = UIImageJPEGRepresentation(Addimg10,0.3f);
            UIImage *secondImage = [UIImage imageNamed:@"add_image.png"];
            NSData *imgData2 =UIImageJPEGRepresentation(secondImage,0.3f);
            BOOL isCompare =  [imageData isEqual:imgData2];
            if(isCompare) {
                NSString*  filename = @"";  //setimage file  name here
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image10\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            } else {
                NSString*  filename = [NSString stringWithFormat:@"%@",@"MyImage"];  //setimage file  name here
                NSLog(@"%@", filename);
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image10\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"product_image10\"]; filename=\"profile_image.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[NSData dataWithData:imageData]];
                [data appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            }
            
        }
        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"phone\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[phone dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
       
        
        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"video_url\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[video_url dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"address\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[address dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"latitude\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[latitude dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"language_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[language_id dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"longitude\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[longitude dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"business_name\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[business_name dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"business_type_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[business_type_id dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"description\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[description dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"website_url\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[website_url dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"sub_cat_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[sub_cat_id dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"facebook_url\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[facebook_url dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"business_email\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[business_email dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"start_time\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[start_time dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"user_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[user_id dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
            /// Menu URl
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"user_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[user_id dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        
            ///Menu Url
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"menu_url\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[menuUrl dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
            /// Table Url
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"table_reservation_url\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[tableUrl dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        
            /// is Open
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"is_open\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[status dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"end_time\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[end_time dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPBody:data];
        conn=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    }
}

//Method for update information of user profile
#pragma mark:-Connection Delegates Methods
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
	[responseData setLength:0];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
	[responseData appendData:data];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [self hideLoader];
    //UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Dingur Alert" message:@"Please check your internet connection." delegate:nil cancelButtonTitle:@"Done" otherButtonTitles:nil, nil];
   // [alert show];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
  // [MBProgressHUD dismissGlobalHUD];
     [self hideLoader];
   // NSLog(@"TIME OUT INTERVAL   %f:",connection.originalRequest.timeoutInterval);
   //  NSLog(@"TIME taking time  %f:",connection.currentRequest.timeoutInterval);
	NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    responseString=[responseString stringByReplacingOccurrencesOfString:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>" withString:@""];
    responseString=[responseString stringByReplacingOccurrencesOfString:@"<string xmlns=\"http://tempuri.org/\">" withString:@""];
   // NSLog(@"%@",responseString);
    responseString=[responseString stringByReplacingOccurrencesOfString:@"</string>" withString:@""];
    NSError * error = nil;
    id json;
      NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *Response=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (json==nil){
		if ([self._delegate respondsToSelector:self._callback]){
			[self._delegate performSelector:self._callback withObject:Response];
		}
	}else{
		if([self._delegate respondsToSelector:self._callback]) {
			[self._delegate performSelector:self._callback withObject:json];
		}else{
			NSLog(@"Callback is not responding.");
		}
	}
}

/*
action=interest_category
login_id
category_id :  comma seperated id
device_id
device_type : 0 - android / 1 - ios
*/

#pragma mark.....interest_category api
-(void)interest_category_login_id:(NSString*)login_id category_id:(NSString*)category_id device_id:(NSString*)device_id device_type:(NSString*)device_type
{
    if([[Reachability sharedReachability] internetConnectionStatus] == NotReachable )
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Please check network connection.",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK" ,nil)otherButtonTitles:nil];
        [alert show];
        
    }else{
        [self hideLoader];
        
        [self showLoader];
        responseData=[[NSMutableData alloc]init];
        NSString *body=[NSString stringWithFormat:@"login_id=%@&category_id=%@&device_id=%@&device_type=%@",login_id,category_id,device_id,device_type];
        NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
        
        NSData *data=[body dataUsingEncoding:NSUTF8StringEncoding];
        [request setURL:[NSURL URLWithString:@"http://allinfo.co.il/all_info/webservice/master.php?action=interest_category"]];
        [request setHTTPMethod:@"POST"];
        [request setTimeoutInterval:120];
        [request setHTTPBody:data];
        [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        conn=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    }
    
}

-(void)share_page_user_id:(NSString*)user_id {
    if([[Reachability sharedReachability] internetConnectionStatus] == NotReachable )
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Please check network connection.",nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK" ,nil)otherButtonTitles:nil];
        [alert show];
        
    }else{
        [self hideLoader];
        
        [self showLoader];
        responseData=[[NSMutableData alloc]init];
        NSString *body=[NSString stringWithFormat:@"user_id=%@",user_id];
        NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
        
        NSData *data=[body dataUsingEncoding:NSUTF8StringEncoding];
        [request setURL:[NSURL URLWithString:@"http://allinfo.co.il/all_info/webservice/master.php?action=share_page"]];
        [request setHTTPMethod:@"POST"];
        [request setTimeoutInterval:120];
        [request setHTTPBody:data];
        [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        conn=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    }
    
}




-(void)showLoader{
    
    UIWindow *window = [[UIApplication sharedApplication] delegate].window;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.labelText = @"Loading....";
       
}
-(void)hideLoader{
    UIWindow *window = [[UIApplication sharedApplication] delegate].window;
    [MBProgressHUD hideHUDForView:window animated:YES];
}
@end

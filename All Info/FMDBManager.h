//
//  FMDBManager.h
//  Check your Tude
//
//  Created by Mahendra Suryavanshi on 2/25/16.
//  Copyright © 2016 PS.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMDBManager : NSObject
-(void)openDataBase;
-(void)saveallcatgery :(NSDictionary *) Categrydic;
-(void)saveallSubcatgery :(NSDictionary *) SubCategrydic;

-(void)saveMusalse :(NSString *) likeststus;
-(void)saveTude :(NSDictionary *) Busnesdic;
-(void)savefavrate :(NSDictionary *) favratedic;

-(void)saveallBusinss :(NSDictionary *) Businssdic;
-(void)deletefavrate :(NSDictionary *) delefavratedic;
-(NSMutableArray *)gethistory;
-(NSMutableArray *)getBusinessarr;
-(NSMutableArray *)getfavirate;

-(NSMutableArray *)Categryarry;
-(NSMutableArray *)SubCategryarry:(NSString *) catgeryId;
-(NSString *)likeststus:(NSString *)lilke;
-(void)AllBusinessupdateList:(NSDictionary *) Busnesdic;
-(void)updateFave:(NSString*)user_id  address:(NSString*)address business_name:(NSString*)business_name  business_type:(NSString*)business_type business_type_id:(NSString*)business_type_id category_id:(NSString*)category_id category_name:(NSString*)category_name  create_date:(NSString*)create_date description:(NSString*)description distance:(NSString*)distance email:(NSString*)email  end_time:(NSString*)end_time facebook_url:(NSString*)facebook_url language_id:(NSString*)language_id latitude:(NSString*)latitude  longitude:(NSString*)longitude phone:(NSString*)phone product_image1:(NSString*)product_image1 product_image2:(NSString*)product_image2 product_image3:(NSString*)product_image3 product_image4:(NSString*)product_image4 product_image5:(NSString*)product_image5 product_image6:(NSString*)product_image6 rating:(NSString*)rating start_time:(NSString*)start_time user_image:(NSString*)user_image username:(NSString*)username website_url:(NSString*)website_url video_url:(NSString*)video_url;
-(void)updatehistory:(NSString*)user_id  address:(NSString*)address business_name:(NSString*)business_name  business_type:(NSString*)business_type business_type_id:(NSString*)business_type_id category_id:(NSString*)category_id category_name:(NSString*)category_name  create_date:(NSString*)create_date description:(NSString*)description distance:(NSString*)distance email:(NSString*)email  end_time:(NSString*)end_time facebook_url:(NSString*)facebook_url language_id:(NSString*)language_id latitude:(NSString*)latitude  longitude:(NSString*)longitude phone:(NSString*)phone product_image1:(NSString*)product_image1 product_image2:(NSString*)product_image2 product_image3:(NSString*)product_image3 product_image4:(NSString*)product_image4 product_image5:(NSString*)product_image5 product_image6:(NSString*)product_image6 rating:(NSString*)rating start_time:(NSString*)start_time user_image:(NSString*)user_image username:(NSString*)username website_url:(NSString*)website_url video_url:(NSString*)video_url;


/*-(void)updateFave:(NSString*)user_id  address:(NSString*)address business_name:(NSString*)business_name  business_type:(NSString*)business_type business_type_id:(NSString*)business_type_id category_id:(NSString*)category_id category_name:(NSString*)category_name  create_date:(NSString*)create_date description:(NSString*)description distance:(NSString*)distance email:(NSString*)email  end_time:(NSString*)end_time facebook_url:(NSString*)facebook_url language_id:(NSString*)language_id latitude:(NSString*)latitude  longitude:(NSString*)longitude phone:(NSString*)phone product_image1:(NSString*)product_image1 product_image2:(NSString*)product_image2 product_image3:(NSString*)product_image3 product_image4:(NSString*)product_image4 product_image5:(NSString*)product_image5 product_image6:(NSString*)product_image6  product_image7:(NSString*)product_image7  product_image8:(NSString*)product_image8  product_image9:(NSString*)product_image9  product_image10:(NSString*)product_image10 rating:(NSString*)rating start_time:(NSString*)start_time user_image:(NSString*)user_image username:(NSString*)username website_url:(NSString*)website_url video_url:(NSString*)video_url;
-(void)updatehistory:(NSString*)user_id  address:(NSString*)address business_name:(NSString*)business_name  business_type:(NSString*)business_type business_type_id:(NSString*)business_type_id category_id:(NSString*)category_id category_name:(NSString*)category_name  create_date:(NSString*)create_date description:(NSString*)description distance:(NSString*)distance email:(NSString*)email  end_time:(NSString*)end_time facebook_url:(NSString*)facebook_url language_id:(NSString*)language_id latitude:(NSString*)latitude  longitude:(NSString*)longitude phone:(NSString*)phone product_image1:(NSString*)product_image1 product_image2:(NSString*)product_image2 product_image3:(NSString*)product_image3 product_image4:(NSString*)product_image4 product_image5:(NSString*)product_image5 product_image6:(NSString*)product_image6   product_image7:(NSString*)product_image7  product_image8:(NSString*)product_image8  product_image9:(NSString*)product_image9  product_image10:(NSString*)product_image10 rating:(NSString*)rating start_time:(NSString*)start_time user_image:(NSString*)user_image username:(NSString*)username website_url:(NSString*)website_url video_url:(NSString*)video_url;
*/

@end

//
//  FMDBManager.m
//  Check your Tude
//
//  Created by Mahendra Suryavanshi on 2/25/16.
//  Copyright © 2016 PS.com. All rights reserved.
//

#import "FMDBManager.h"
#import "FMDatabase.h"


@interface FMDBManager()
{
    NSString *business_name;
}
@property (atomic ,strong) FMDatabase *db;

@end

@implementation FMDBManager
-(void)openDataBase {
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"CheckTudeNew" ofType:@"sqlite"];
//    
//    FMDatabase *database = [FMDatabase databaseWithPath:path];
//    
//    [database setLogsErrors:TRUE];
//    
//    [database open];
    
    [self copyDatabaseIfNeeded];
    self.db = [FMDatabase databaseWithPath:[self getDBPath]];
    if (![self.db open]) {
        return;
    }
    
}

- (void) copyDatabaseIfNeeded {
    
    //Using NSFileManager we can perform many file system operations.
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    
    NSString *dbPath = [self getDBPath];
    BOOL success = [fileManager fileExistsAtPath:dbPath];
    
    if(!success) {
        
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Allinfo.sqlite"];
        success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
        
        if (!success)
            NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
}

- (NSString *) getDBPath
{
    //Search for standard documents using NSSearchPathForDirectoriesInDomains
    //First Param = Searching the documents directory
    //Second Param = Searching the Users directory and not the System
    //Expand any tildes and identify home directories.
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
   // NSLog(@"dbpath : %@",documentsDir);
    return [documentsDir stringByAppendingPathComponent:@"Allinfo.sqlite"];
}
-(void)savefavrate :(NSDictionary *) favratedic {
    BOOL isfIds = NO;
    
    FMResultSet *s = [self.db executeQuery:@"SELECT * from favirateTabel WHERE user_id= ?",[NSString stringWithFormat:@"%@", [favratedic objectForKey:@"user_id"]]];
    while ([s next]) {
        isfIds = YES;
    }
    
    if (isfIds == NO) {
    BOOL success = [self.db executeUpdate:@"INSERT INTO favirateTabel (address, business_name, business_type,business_type_id,category_id, category_name,create_date,description,distance,email,end_time,facebook_url,language_id,latitude,longitude,phone,product_image1,product_image2,product_image3,product_image4,product_image5,product_image6,rating,start_time,user_id,user_image,username,video_url,website_url,like, is_open, subcategory_image) VALUES (:address, :business_name,:business_type,:business_type_id,:category_id, :category_name,:create_date,:description,:distance,:email,:end_time,:facebook_url,:language_id,:latitude,:longitude,:phone,:product_image1,:product_image2,:product_image3,:product_image4,:product_image5,:product_image6,:rating,:start_time,:user_id,:user_image,:username,:video_url,:website_url,:like, :is_open, :subcategory_image)" withParameterDictionary:favratedic];
    if (!success) {
        NSLog(@"error = %@", [self.db lastErrorMessage]);
    }
    }
    
    
}
-(void)saveallcatgery :(NSDictionary *) Categrydic {
    
    BOOL isId = NO;
    FMResultSet *s = [self.db executeQuery:@"SELECT * from AlldataTable WHERE category_id= ?",[NSString stringWithFormat:@"%@", [Categrydic objectForKey:@"category_id"]]];
    while ([s next]) {
        isId = YES;
    }
    
    if (isId == NO) {
    
   
        BOOL success = [self.db executeUpdate:@"INSERT INTO AlldataTable (category_id, category_image, category_name, language_id, show_date) VALUES (:category_id, :category_image, :category_name, :language_id, :show_date)" withParameterDictionary:Categrydic];
        if (!success) {
            NSLog(@"error = %@", [self.db lastErrorMessage]);
        }
    
    }
}

-(void)saveallSubcatgery :(NSDictionary *) SubCategrydic {
    BOOL isId = NO;
    FMResultSet *s = [self.db executeQuery:@"SELECT * from SubcatrgryTable WHERE sub_cat_id= ?",[NSString stringWithFormat:@"%@", [SubCategrydic objectForKey:@"sub_cat_id"]]];
    while ([s next]) {
        isId = YES;
    }
    
    if (isId == NO) {
        BOOL success = [self.db executeUpdate:@"INSERT INTO SubcatrgryTable (category_id, category_name, create_date, sub_cat_id,sub_category_image,sub_category_name, show_date) VALUES (:category_id, :category_name, :create_date, :sub_cat_id, :sub_category_image, :sub_category_name, :show_date)" withParameterDictionary:SubCategrydic];
        if (!success) {
            NSLog(@"error = %@", [self.db lastErrorMessage]);
        }
        
    }
    
}
-(NSMutableArray *)getfavirate {
    NSMutableArray *favrarr = [[NSMutableArray alloc] init];
    FMResultSet *s = [self.db executeQuery:@"SELECT * from favirateTabel"];
    NSLog(@"s = %d", s.columnCount);
    while ([s next]) {
        NSString *address = [s stringForColumn:@"address"];
        NSString *business_name = [s stringForColumn:@"business_name"];
        NSString *business_type = [s stringForColumn:@"business_type"];
        NSString *business_type_id = [s stringForColumn:@"business_type_id"];
        NSString *category_id = [s stringForColumn:@"category_id"];
        NSString *category_name = [s stringForColumn:@"category_name"];
        NSString *create_date = [s stringForColumn:@"create_date"];
        NSString *description = [s stringForColumn:@"description"];
        NSString *distance = [s stringForColumn:@"distance"];
        NSString *email = [s stringForColumn:@"email"];
        NSString *end_time = [s stringForColumn:@"end_time"];
        NSString *latitude = [s stringForColumn:@"latitude"];
        NSString *longitude = [s stringForColumn:@"longitude"];
        NSString *phone = [s stringForColumn:@"phone"];
        NSString *product_image1 = [s stringForColumn:@"product_image1"];
        NSString *product_image2 = [s stringForColumn:@"product_image2"];
        NSString *product_image3 = [s stringForColumn:@"product_image3"];
        NSString *product_image4 = [s stringForColumn:@"product_image4"];
        NSString *product_image5 = [s stringForColumn:@"product_image5"];
        NSString *product_image6 = [s stringForColumn:@"product_image6"];
        NSString *rating = [s stringForColumn:@"rating"];
        NSString *start_time = [s stringForColumn:@"start_time"];
        NSString *user_id = [s stringForColumn:@"user_id"];
        NSString *user_image = [s stringForColumn:@"user_image"];
        NSString *username = [s stringForColumn:@"username"];
        NSString *video_url = [s stringForColumn:@"video_url"];
        NSString *website_url = [s stringForColumn:@"website_url"];
        NSString *facebook_url = [s stringForColumn:@"facebook_url"];
        NSString *is_open = [s stringForColumn:@"is_open"];
        NSString *subcategory_image = [s stringForColumn:@"subcategory_image"];
        
        
        if([subcategory_image isEqual:[NSNull null]] || [subcategory_image isEqual:@""] || subcategory_image == nil) {
            subcategory_image =  @"";
        }
        
        
        if([is_open isEqual:[NSNull null]] || [is_open isEqual:@""] || is_open == nil) {
            is_open =  @"";
        }
        
        
        if ([rating isEqual:[NSNull null]]) {
            rating=@"";
        }else if ([rating isEqual:@""]) {
            rating=@"";
        }
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:address forKey:@"address"];
        [dict setObject:business_name forKey:@"business_name"];
        [dict setObject:business_type forKey:@"business_type"];
        
        [dict setObject:business_type_id forKey:@"business_type_id"];
        [dict setObject:facebook_url forKey:@"facebook_url"];
        [dict setObject:subcategory_image forKey:@"subcategory_image"];
        [dict setObject:is_open forKey:@"is_open"];
        
        if(category_id != nil){
            [dict setObject:category_id forKey:@"category_id"];
        } else {
            [dict setObject:@"" forKey:@"category_id"];
        }
        
        if(category_name != nil) {
            [dict setObject:category_name forKey:@"category_name"];
        } else {
            [dict setObject:@"" forKey:@"category_name"];
        }
        
        
        [dict setObject:create_date forKey:@"create_date"];
        if(description != nil){
            [dict setObject:description forKey:@"description"];
        } else {
            [dict setObject:@"" forKey:@"description"];
        }
        
        if(distance != nil) {
            [dict setObject:distance forKey:@"distance"];
        } else {
            [dict setObject:@"" forKey:@"distance"];
        }
        
        
        if(email != nil) {
            [dict setObject:email forKey:@"email"];
        } else {
            [dict setObject:@"" forKey:@"email"];
        }
        
        [dict setObject:latitude forKey:@"latitude"];
        [dict setObject:longitude forKey:@"longitude"];
        if(phone != nil) {
            [dict setObject:phone forKey:@"phone"];
        } else {
            [dict setObject:@"" forKey:@"phone"];
        }
        
        [dict setObject:end_time forKey:@"end_time"];
        //[dict setObject:priority forKey:@"priority"];
        [dict setObject:start_time forKey:@"start_time"];
        [dict setObject:product_image1 forKey:@"product_image1"];
        [dict setObject:product_image2 forKey:@"product_image2"];
        [dict setObject:product_image3 forKey:@"product_image3"];
        [dict setObject:product_image4 forKey:@"product_image4"];
        [dict setObject:product_image5 forKey:@"product_image5"];
        [dict setObject:product_image6 forKey:@"product_image6"];
        
        [dict setObject:user_id forKey:@"user_id"];
        [dict setObject:user_image forKey:@"user_image"];
        if(username != nil) {
            [dict setObject:username forKey:@"username"];
        } else {
            [dict setObject:@"" forKey:@"username"];
        }
        
        [dict setObject:video_url forKey:@"video_url"];
        [dict setObject:website_url forKey:@"website_url"];
        [dict setObject:rating forKey:@"rating"];
        [favrarr addObject:dict];
    }
    return favrarr;
}
-(NSMutableArray *)Categryarry {
    NSMutableArray *favrarr = [[NSMutableArray alloc] init];
    
    FMResultSet *s = [self.db executeQuery:@"SELECT * from AlldataTable"];
    while ([s next]) {
        NSString *category_id = [s stringForColumn:@"category_id"];
        NSString *category_image = [s stringForColumn:@"category_image"];
        NSString *category_name = [s stringForColumn:@"category_name"];
        NSString *language_id = [s stringForColumn:@"language_id"];
        NSString *showDate = [s stringForColumn:@"show_date"];
        
        if ([showDate isEqual:[NSNull null]]) {
            showDate=@"";
        }else if ([showDate isEqual:@""]) {
            showDate=@"";
        }
        
        if ([category_id isEqual:[NSNull null]]) {
            category_id=@"";
        }else if ([category_id isEqual:@""]) {
            category_id=@"";
        }
        
        if ([category_image isEqual:[NSNull null]]) {
            category_image=@"";
        }else if ([category_image isEqual:@""]) {
            category_image=@"";
        }
        if ([category_name isEqual:[NSNull null]]) {
            category_name=@"";
        }else if ([category_name isEqual:@""]) {
            category_name=@"";
        }
        if ([language_id isEqual:[NSNull null]]) {
            language_id=@"";
        }else if ([language_id isEqual:@""]) {
            language_id=@"";
        }
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:category_id forKey:@"category_id"];
        [dict setObject:category_image forKey:@"category_image"];
        [dict setObject:category_name forKey:@"category_name"];
        [dict setObject:language_id forKey:@"language_id"];
        [dict setObject:showDate forKey:@"show_date"];
                //[dict setObject:rating forKey:@"rating"];
        [favrarr addObject:dict];
    }
    return favrarr;
}
-(NSString *)likeststus:(NSString *)lilke{
    
    FMResultSet *s = [self.db executeQuery:@"SELECT * from favirateTabel WHERE user_id= ?",lilke];
    while ([s next]) {
       
    lilke = [s stringForColumn:@"like"];
            
        }
        
    return lilke;
}
-(NSMutableArray *)SubCategryarry:(NSString *) catgeryId{
    NSMutableArray *favrarr = [[NSMutableArray alloc] init];
    
    FMResultSet *s = [self.db executeQuery:@"SELECT * from SubcatrgryTable WHERE category_id= ?",catgeryId];
    while ([s next]) {
        NSString *category_id = [s stringForColumn:@"category_id"];
        NSString *category_name = [s stringForColumn:@"category_name"];
        NSString *create_date = [s stringForColumn:@"create_date"];
        NSString *sub_cat_id = [s stringForColumn:@"sub_cat_id"];
        NSString *sub_category_image = [s stringForColumn:@"sub_category_image"];
        NSString *sub_category_name = [s stringForColumn:@"sub_category_name"];
        NSString *showDate = [s stringForColumn:@"show_date"];
       
        if ([showDate isEqual:[NSNull null]]) {
            showDate=@"";
        }else if ([showDate isEqual:@""]) {
            showDate=@"";
        }
        
        if ([category_id isEqual:[NSNull null]]) {
            category_id=@"";
        }else if ([category_id isEqual:@""]) {
            category_id=@"";
        }
       
        if ([category_name isEqual:[NSNull null]]) {
            category_name=@"";
        }else if ([category_name isEqual:@""]) {
            category_name=@"";
        }
        if ([create_date isEqual:[NSNull null]]) {
            create_date=@"";
        }else if ([create_date isEqual:@""]) {
            create_date=@"";
        }
        if ([sub_cat_id isEqual:[NSNull null]]) {
            sub_cat_id=@"";
        }else if ([sub_cat_id isEqual:@""]) {
            sub_cat_id=@"";
        }
        if ([sub_category_image isEqual:[NSNull null]]) {
            sub_category_image=@"";
        }else if ([sub_category_image isEqual:@""]) {
            sub_category_image=@"";
        }
        if ([sub_category_name isEqual:[NSNull null]]) {
            sub_category_name=@"";
        }else if ([sub_category_name isEqual:@""]) {
            sub_category_name=@"";
        }


        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:category_id forKey:@"category_id"];
        [dict setObject:category_name forKey:@"category_name"];
        [dict setObject:create_date forKey:@"create_date"];
        [dict setObject:sub_cat_id forKey:@"sub_cat_id"];
        [dict setObject:sub_category_image forKey:@"sub_category_image"];
        [dict setObject:sub_category_name forKey:@"sub_category_name"];
        [dict setObject:showDate forKey:@"show_date"];
        //[dict setObject:rating forKey:@"rating"];
        [favrarr addObject:dict];
    }
    return favrarr;
}

-(void)deletefavrate :(NSMutableDictionary *) delefavratedic{
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"Allinfo.sqlite"];
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    [database executeUpdate:@"DELETE FROM favirateTabel WHERE user_id= ? and user_id= ?", [NSString stringWithFormat:@"%@", [delefavratedic objectForKey:@"user_id"]],[NSString stringWithFormat:@"%@", [delefavratedic objectForKey:@"user_id"]], nil];
    [database close];
}


-(void)updatehistory:(NSString*)user_id  address:(NSString*)address business_name:(NSString*)business_name  business_type:(NSString*)business_type business_type_id:(NSString*)business_type_id category_id:(NSString*)category_id category_name:(NSString*)category_name  create_date:(NSString*)create_date description:(NSString*)description distance:(NSString*)distance email:(NSString*)email  end_time:(NSString*)end_time facebook_url:(NSString*)facebook_url language_id:(NSString*)language_id latitude:(NSString*)latitude  longitude:(NSString*)longitude phone:(NSString*)phone product_image1:(NSString*)product_image1 product_image2:(NSString*)product_image2 product_image3:(NSString*)product_image3 product_image4:(NSString*)product_image4 product_image5:(NSString*)product_image5 product_image6:(NSString*)product_image6 rating:(NSString*)rating start_time:(NSString*)start_time user_image:(NSString*)user_image username:(NSString*)username website_url:(NSString*)website_url video_url:(NSString*)video_url{
    
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *dbPath = [docsPath stringByAppendingPathComponent:@"Allinfo.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    NSString *insertQuery = [NSString stringWithFormat:@"UPDATE history_Table SET address = '%@',business_name = '%@',business_type = '%@',business_type_id = '%@',category_id = '%@',category_name = '%@',create_date = '%@',description = '%@',email = '%@',end_time = '%@',facebook_url = '%@',language_id = '%@',latitude = '%@',longitude = '%@',phone = '%@',product_image1 = '%@',product_image2 = '%@',product_image3 = '%@',product_image4 = '%@',product_image5 = '%@',product_image6 = '%@',rating = '%@',start_time = '%@', username = '%@',website_url = '%@',video_url = '%@' WHERE user_id = '%@' ", address,business_name,business_type,business_type_id,category_id,category_name,create_date,description,email,end_time,facebook_url,language_id,latitude,longitude,phone,product_image1,product_image2,product_image3,product_image4,product_image5,product_image6,rating,start_time,username,website_url,video_url,user_id ];
    [database executeUpdate:insertQuery];
    [database close];

}
-(void)updateFave:(NSString*)user_id  address:(NSString*)address business_name:(NSString*)business_name  business_type:(NSString*)business_type business_type_id:(NSString*)business_type_id category_id:(NSString*)category_id category_name:(NSString*)category_name  create_date:(NSString*)create_date description:(NSString*)description distance:(NSString*)distance email:(NSString*)email  end_time:(NSString*)end_time facebook_url:(NSString*)facebook_url language_id:(NSString*)language_id latitude:(NSString*)latitude  longitude:(NSString*)longitude phone:(NSString*)phone product_image1:(NSString*)product_image1 product_image2:(NSString*)product_image2 product_image3:(NSString*)product_image3 product_image4:(NSString*)product_image4 product_image5:(NSString*)product_image5 product_image6:(NSString*)product_image6 rating:(NSString*)rating start_time:(NSString*)start_time user_image:(NSString*)user_image username:(NSString*)username website_url:(NSString*)website_url video_url:(NSString*)video_url{
    
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *dbPath = [docsPath stringByAppendingPathComponent:@"Allinfo.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    NSString *insertQuery = [NSString stringWithFormat:@"UPDATE favirateTabel SET address = '%@',business_name = '%@',business_type = '%@',business_type_id = '%@',category_id = '%@',category_name = '%@',create_date = '%@',description = '%@',email = '%@',end_time = '%@',facebook_url = '%@',language_id = '%@',latitude = '%@',longitude = '%@',phone = '%@',product_image1 = '%@',product_image2 = '%@',product_image3 = '%@',product_image4 = '%@',product_image5 = '%@',product_image6 = '%@',rating = '%@',start_time = '%@', username = '%@',website_url = '%@',video_url = '%@' WHERE user_id = '%@' ", address,business_name,business_type,business_type_id,category_id,category_name,create_date,description,email,end_time,facebook_url,language_id,latitude,longitude,phone,product_image1,product_image2,product_image3,product_image4,product_image5,product_image6,rating,start_time,username,website_url,video_url,user_id ];
    [database executeUpdate:insertQuery];
    [database close];
    
}

-(void)saveTude :(NSDictionary *) Busnesdic {
    BOOL isId = NO;
    
    FMResultSet *s = [self.db executeQuery:@"SELECT * from history_Table WHERE user_id= ?",[NSString stringWithFormat:@"%@", [Busnesdic objectForKey:@"user_id"]]];
    while ([s next]) {
        isId = YES;
    }
    
    if (isId == NO) {
        BOOL success = [self.db executeUpdate:@"INSERT INTO history_Table (address, business_name, business_type,business_type_id,category_id, category_name,create_date,description,distance,email,end_time,facebook_url,language_id,latitude,longitude,phone,product_image1,product_image2,product_image3,product_image4,product_image5,product_image6,rating,start_time,user_id,user_image,username,video_url,website_url, is_open, subcategory_image) VALUES (:address, :business_name,:business_type,:business_type_id,:category_id, :category_name,:create_date,:description,:distance,:email,:end_time,:facebook_url,:language_id,:latitude,:longitude,:phone,:product_image1,:product_image2,:product_image3,:product_image4,:product_image5,:product_image6,:rating,:start_time,:user_id,:user_image,:username,:video_url,:website_url,:is_open, :subcategory_image)" withParameterDictionary:Busnesdic];
       
        if (!success) {
            NSLog(@"error = %@", [self.db lastErrorMessage]);
        }
    }
}

-(NSArray *)gethistory {
    NSMutableArray *histarr = [[NSMutableArray alloc] init];
    
    FMResultSet *s = [self.db executeQuery:@"SELECT * from history_Table"];
    while ([s next]) {
        NSString *address = [s stringForColumn:@"address"];
        NSString *business_name = [s stringForColumn:@"business_name"];
        NSString *business_type = [s stringForColumn:@"business_type"];
        NSString *business_type_id = [s stringForColumn:@"business_type_id"];
        NSString *category_id = [s stringForColumn:@"category_id"];
        NSString *category_name = [s stringForColumn:@"category_name"];
        NSString *create_date = [s stringForColumn:@"create_date"];
        NSString *description = [s stringForColumn:@"description"];
        NSString *distance = [s stringForColumn:@"distance"];
        NSString *email = [s stringForColumn:@"email"];
        NSString *end_time = [s stringForColumn:@"end_time"];
        NSString *latitude = [s stringForColumn:@"latitude"];
        NSString *longitude = [s stringForColumn:@"longitude"];
        NSString *phone = [s stringForColumn:@"phone"];
        //NSString *priority = [s stringForColumn:@"priority"];
        NSString *product_image1 = [s stringForColumn:@"product_image1"];
        NSString *product_image2 = [s stringForColumn:@"product_image2"];
        NSString *product_image3 = [s stringForColumn:@"product_image3"];
        NSString *product_image4 = [s stringForColumn:@"product_image4"];
        NSString *product_image5 = [s stringForColumn:@"product_image5"];
        NSString *product_image6 = [s stringForColumn:@"product_image6"];
        NSString *rating = [s stringForColumn:@"rating"];
        NSString *start_time = [s stringForColumn:@"start_time"];
        NSString *user_id = [s stringForColumn:@"user_id"];
        NSString *user_image = [s stringForColumn:@"user_image"];
        NSString *username = [s stringForColumn:@"username"];
        NSString *video_url = [s stringForColumn:@"video_url"];
        NSString *website_url = [s stringForColumn:@"website_url"];
        NSString *facebook_url = [s stringForColumn:@"facebook_url"];
        NSString *language_id = [s stringForColumn:@"language_id"];
        NSString *is_open = [s stringForColumn:@"is_open"];
        NSString *subcategory_image = [s stringForColumn:@"subcategory_image"];
        
        
        
        if([is_open isEqual:[NSNull null]] || [is_open isEqual:@""] || is_open == nil) {
            is_open =  @"";
        }
        
        if([subcategory_image isEqual:[NSNull null]] || [subcategory_image isEqual:@""] || subcategory_image == nil) {
            subcategory_image =  @"";
        }
        
        if ([address isEqual:[NSNull null]]) {
            address=@"";
        }else if ([address isEqual:@""]) {
            address=@"";
        }else if(address == nil){
          address=@"";
        }
        if ([business_name isEqual:[NSNull null]]) {
            business_name=@"";
        }else if ([business_name isEqual:@""]) {
            business_name=@"";
        }else if(business_name == nil){
            business_name=@"";
        }
        if ([business_type isEqual:[NSNull null]]) {
            business_type=@"";
        }else if ([business_type isEqual:@""]) {
            business_type=@"";
        }else if(business_type == nil){
            business_type=@"";
        }
        if ([business_type_id isEqual:[NSNull null]]) {
            business_type_id=@"";
        }else if ([business_type_id isEqual:@""]) {
            business_type_id=@"";
        }else if(business_type_id == nil){
            business_type_id=@"";
        }
        if ([category_id isEqual:[NSNull null]]) {
            category_id=@"";
        }else if ([category_id isEqual:@""]) {
            category_id=@"";
        }else if(category_id == nil){
            category_id=@"";
        }
        if ([category_name isEqual:[NSNull null]]) {
            category_name=@"";
        }else if ([category_name isEqual:@""]) {
            category_name=@"";
        }else if(category_name == nil){
            category_name=@"";
        }
        if ([create_date isEqual:[NSNull null]]) {
            create_date=@"";
        }else if ([create_date isEqual:@""]) {
            create_date=@"";
        }else if(create_date == nil){
            create_date=@"";
        }
        if ([description isEqual:[NSNull null]]) {
            description=@"";
        }else if ([description isEqual:@""]) {
            description=@"";
        }else if(description == nil){
            description=@"";
        }
        if ([distance isEqual:[NSNull null]]) {
            distance=@"";
        }else if ([distance isEqual:@""]) {
            distance=@"";
        }else if(distance == nil){
            distance=@"";
        }
        if ([email isEqual:[NSNull null]]) {
            email=@"";
        }else if ([email isEqual:@""]) {
            email=@"";
        }else if(email == nil){
            email=@"";
        }
        if ([end_time isEqual:[NSNull null]]) {
            end_time=@"";
        }else if ([end_time isEqual:@""]) {
            end_time=@"";
        }else if(end_time == nil){
            end_time=@"";
        }
        if ([latitude isEqual:[NSNull null]]) {
            latitude=@"";
        }else if ([latitude isEqual:@""]) {
            latitude=@"";
        }else if(latitude == nil){
            latitude=@"";
        }
        if ([longitude isEqual:[NSNull null]]) {
            longitude=@"";
        }else if ([longitude isEqual:@""]) {
            longitude=@"";
        }else if(longitude == nil){
            longitude=@"";
        }
        if ([phone isEqual:[NSNull null]]) {
            phone=@"";
        }else if ([phone isEqual:@""]) {
            phone=@"";
        }else if(phone == nil){
            phone=@"";
        }
        
        if ([product_image1 isEqual:[NSNull null]]) {
            product_image1=@"";
        }else if ([product_image1 isEqual:@""]) {
            product_image1=@"";
        }else if(product_image1 == nil){
            product_image1=@"";
        }
        if ([product_image2 isEqual:[NSNull null]]) {
            product_image2=@"";
        }else if ([product_image2 isEqual:@""]) {
            product_image2=@"";
        }else if(product_image2 == nil){
            product_image2=@"";
        }
        if ([product_image3 isEqual:[NSNull null]]) {
            product_image3=@"";
        }else if ([product_image3 isEqual:@""]) {
            product_image3=@"";
        }else if(product_image3 == nil){
            product_image3=@"";
        }
        if ([product_image4 isEqual:[NSNull null]]) {
            product_image4=@"";
        }else if ([product_image4 isEqual:@""]) {
            product_image4=@"";
        }else if(product_image4 == nil){
            product_image4=@"";
        }
        if ([product_image5 isEqual:[NSNull null]]) {
            product_image5=@"";
        }else if ([product_image5 isEqual:@""]) {
            product_image5=@"";
        }else if(product_image5 == nil){
            product_image5=@"";
        }
        if ([product_image6 isEqual:[NSNull null]]) {
            product_image6=@"";
        }else if ([product_image6 isEqual:@""]) {
            product_image6=@"";
        }else if(product_image6 == nil){
            product_image6=@"";
        }
        if ([rating isEqual:[NSNull null]]) {
            rating=@"";
        }else if ([rating isEqual:@""]) {
            rating=@"";
        }else if(rating == nil){
            rating=@"";
        }
        if ([start_time isEqual:[NSNull null]]) {
            start_time=@"";
        }else if ([start_time isEqual:@""]) {
            start_time=@"";
        }else if(start_time == nil){
            start_time=@"";
        }
        if ([user_id isEqual:[NSNull null]]) {
            user_id=@"";
        }else if ([user_id isEqual:@""]) {
            user_id=@"";
        }else if(user_id == nil){
            user_id=@"";
        }
        if ([user_image isEqual:[NSNull null]]) {
            user_image=@"";
        }else if ([user_image isEqual:@""]) {
            user_image=@"";
        }else if(user_image == nil){
            user_image=@"";
        }
        
        if ([username isEqual:[NSNull null]]) {
            username=@"";
        }else if ([username isEqual:@""]) {
            username=@"";
        }else if(username == nil){
            username=@"";
        }
        
        if ([video_url isEqual:[NSNull null]]) {
            video_url=@"";
        }else if ([video_url isEqual:@""]) {
            video_url=@"";
        }else if(video_url == nil){
            video_url=@"";
        }
        
        if ([website_url isEqual:[NSNull null]]) {
            website_url=@"";
        }else if ([website_url isEqual:@""]) {
            website_url=@"";
        }else if(website_url == nil){
            website_url=@"";
        }
        if ([facebook_url isEqual:[NSNull null]]) {
            facebook_url=@"";
        }else if ([facebook_url isEqual:@""]) {
            facebook_url=@"";
        }else if(facebook_url == nil){
            facebook_url=@"";
        }
        
        if ([language_id isEqual:[NSNull null]]) {
            language_id=@"";
        }else if ([language_id isEqual:@""]) {
            language_id=@"";
        }else if(language_id == nil){
            language_id=@"";
        }

        

        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:address forKey:@"address"];
        [dict setObject:business_name forKey:@"business_name"];
        [dict setObject:business_type forKey:@"business_type"];
        [dict setObject:business_type_id forKey:@"business_type_id"];
        [dict setObject:facebook_url forKey:@"facebook_url"];
        [dict setObject:category_id forKey:@"category_id"];
        [dict setObject:category_name forKey:@"category_name"];
        [dict setObject:create_date forKey:@"create_date"];
        [dict setObject:description forKey:@"description"];
        [dict setObject:distance forKey:@"distance"];
        [dict setObject:email forKey:@"email"];
        [dict setObject:latitude forKey:@"latitude"];
        [dict setObject:longitude forKey:@"longitude"];
        [dict setObject:phone forKey:@"phone"];
        [dict setObject:end_time forKey:@"end_time"];
        [dict setObject:language_id forKey:@"language_id"];
        [dict setObject:start_time forKey:@"start_time"];
        [dict setObject:product_image1 forKey:@"product_image1"];
        [dict setObject:product_image2 forKey:@"product_image2"];
        [dict setObject:product_image3 forKey:@"product_image3"];
        [dict setObject:product_image4 forKey:@"product_image4"];
        [dict setObject:product_image5 forKey:@"product_image5"];
        [dict setObject:product_image6 forKey:@"product_image6"];
       
        [dict setObject:is_open forKey:@"is_open"];
        [dict setObject:subcategory_image forKey:@"subcategory_image"];
        [dict setObject:user_id forKey:@"user_id"];
        [dict setObject:user_image forKey:@"user_image"];
        [dict setObject:username forKey:@"username"];
        [dict setObject:video_url forKey:@"video_url"];
        [dict setObject:website_url forKey:@"website_url"];
        [dict setObject:rating forKey:@"rating"];
        [histarr addObject:dict];
    }
    return histarr;
}
-(void)AllBusinessupdateList:(NSDictionary *) Busnesdic{
    
    NSString *address=[Busnesdic objectForKey:@"address"];
    NSString *business_name=[Busnesdic objectForKey:@"business_name"];
    NSString *business_type=[Busnesdic objectForKey:@"business_type"];
    NSString *business_type_id=[Busnesdic objectForKey:@"business_type_id"];
    NSString *category_name=[Busnesdic objectForKey:@"category_name"];
    NSString *create_date=[Busnesdic objectForKey:@"create_date"];
    NSString *description=[Busnesdic objectForKey:@"description"];
    NSString *distance=[Busnesdic objectForKey:@"distance"];
    NSString *end_time=[Busnesdic objectForKey:@"end_time"];
    NSString *facebook_url=[Busnesdic objectForKey:@"facebook_url"];
    NSString *latitude=[Busnesdic objectForKey:@"latitude"];
    NSString *longitude=[Busnesdic objectForKey:@"longitude"];
    NSString *phone=[Busnesdic objectForKey:@"phone"];
    
    NSString *product_image1=[Busnesdic objectForKey:@"product_image1"];
    NSString *product_image2=[Busnesdic objectForKey:@"product_image2"];
    NSString *product_image3=[Busnesdic objectForKey:@"product_image3"];
    NSString *product_image4=[Busnesdic objectForKey:@"product_image4"];
    NSString *product_image5=[Busnesdic objectForKey:@"product_image5"];
    NSString *product_image6=[Busnesdic objectForKey:@"product_image6"];
    
    NSString *rating=[Busnesdic objectForKey:@"rating"];
    NSString *user_image=[Busnesdic objectForKey:@"user_image"];
    NSString *username=[Busnesdic objectForKey:@"username"];
    NSString *video_url=[Busnesdic objectForKey:@"video_url"];
    NSString *website_url=[Busnesdic objectForKey:@"website_url"];
    NSString *user_id=[Busnesdic objectForKey:@"user_id"];
    
    NSString *start_time=[Busnesdic objectForKey:@"start_time"];
    NSString *email=[Busnesdic objectForKey:@"email"];
    NSString *category_id=[Busnesdic objectForKey:@"category_id"];
    NSString *language_id=[Busnesdic objectForKey:@"language_id"];
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *dbPath = [docsPath stringByAppendingPathComponent:@"Allinfo.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
   
    NSString *insertQuery = [NSString stringWithFormat:@"UPDATE AllBusinesslistTable SET address = '%@',business_name = '%@',business_type = '%@',business_type_id = '%@',category_id = '%@',category_name = '%@',create_date = '%@',description = '%@',distance = '%@' ,email = '%@',end_time = '%@',facebook_url = '%@',language_id = '%@',latitude = '%@',longitude = '%@',phone = '%@',product_image1 = '%@',product_image2 = '%@',product_image3 = '%@',product_image4 = '%@',product_image5 = '%@',product_image6 = '%@',rating = '%@',user_image = '%@',username = '%@',video_url = '%@',website_url = '%@',start_time = '%@' WHERE user_id = '%@' ", address,business_name,business_type,business_type_id,category_id,category_name,create_date,description,distance,email,end_time,facebook_url,language_id,latitude,longitude,phone,product_image1,product_image2,product_image3,product_image4,product_image5,product_image6,rating,user_image,username,video_url,website_url,start_time,user_id ];
    [database executeUpdate:insertQuery];
    [database close];
    
}





-(void)saveallBusinss :(NSDictionary *) Busnesdic {
    BOOL isId = NO;
    
    FMResultSet *s = [self.db executeQuery:@"SELECT * from AllBusinesslistTable WHERE user_id= ?",[NSString stringWithFormat:@"%@", [Busnesdic objectForKey:@"user_id"]]];
    while ([s next]) {
        isId = YES;
    }
    
    if (isId == NO) {
        BOOL success = [self.db executeUpdate:@"INSERT INTO AllBusinesslistTable (address, business_name, business_type, business_type_id,category_id,category_name,create_date,description,distance,email,end_time,facebook_url,language_id,latitude,longitude,phone,product_image1,product_image2,product_image3,product_image4,product_image5,product_image6,rating,user_id,user_image,username,video_url,website_url,start_time) VALUES (:address, :business_name, :business_type,:business_type_id,:category_id,:category_name, :create_date, :description,:distance,:email,:end_time,:facebook_url, :language_id,:latitude, :longitude ,:phone ,:product_image1 ,:product_image2 ,:product_image3 ,:product_image4 ,:product_image5 ,:product_image6,:rating, :user_id,:user_image, :username,:video_url, :website_url, :start_time)" withParameterDictionary:Busnesdic];
        
        if (!success) {
            NSLog(@"error = %@", [self.db lastErrorMessage]);
        }
        
        
    }
}

-(NSArray *)getBusinessarr {
    NSMutableArray *Businessarr = [[NSMutableArray alloc] init];
    
    FMResultSet *s = [self.db executeQuery:@"SELECT * from AllBusinesslistTable"];
    while ([s next]) {
        NSString *address = [s stringForColumn:@"address"];
        NSString *business_name1 = [s stringForColumn:@"business_name"];
       
        if ([business_name1 canBeConvertedToEncoding:NSASCIIStringEncoding]){
            NSData *data = [business_name1 dataUsingEncoding:NSUTF8StringEncoding];
            NSString *string = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding];
          business_name=[NSString stringWithFormat:@"%@",string];
            
        }else{
            business_name=[NSString stringWithFormat:@"%@",business_name1];
        }
        NSString *business_type = [s stringForColumn:@"business_type"];
        NSString *business_type_id = [s stringForColumn:@"business_type_id"];
        NSString *category_id = [s stringForColumn:@"category_id"];
        NSString *category_name = [s stringForColumn:@"category_name"];
        NSString *create_date = [s stringForColumn:@"create_date"];
        NSString *facebook_url = [s stringForColumn:@"facebook_url"];
        NSString *language_id = [s stringForColumn:@"language_id"];
        NSString *start_time = [s stringForColumn:@"start_time"];
        NSString *description = [s stringForColumn:@"description"];
        NSString *distance = [s stringForColumn:@"distance"];
        NSString *email = [s stringForColumn:@"email"];
        NSString *latitude = [s stringForColumn:@"latitude"];
        NSString *longitude = [s stringForColumn:@"longitude"];
        NSString *phone = [s stringForColumn:@"phone"];
        NSString *product_image1 = [s stringForColumn:@"product_image1"];
        NSString *product_image2 = [s stringForColumn:@"product_image2"];
        NSString *product_image3 = [s stringForColumn:@"product_image3"];
        NSString *product_image4 = [s stringForColumn:@"product_image4"];
        NSString *product_image5 = [s stringForColumn:@"product_image5"];
        NSString *product_image6 = [s stringForColumn:@"product_image6"];
        NSString *sub_category_name = [s stringForColumn:@"sub_category_name"];
        NSString *user_id = [s stringForColumn:@"user_id"];
        NSString *user_image = [s stringForColumn:@"user_image"];
        NSString *username = [s stringForColumn:@"username"];
        NSString *video_url = [s stringForColumn:@"video_url"];
        NSString *website_url = [s stringForColumn:@"website_url"];
        NSString *rating = [s stringForColumn:@"rating"];
        NSString *end_time = [s stringForColumn:@"end_time"];
        
        if ([address isEqual:[NSNull null]]) {
            address=@"";
        }else if ([address isEqual:@""]) {
            address=@"";
        }else if(address == nil){
            address=@"";
        }
        if ([business_name isEqual:[NSNull null]]) {
            business_name=@"";
        }else if ([business_name isEqual:@""]) {
            business_name=@"";
        }else if(business_name == nil){
            business_name=@"";
        }
        if ([business_type isEqual:[NSNull null]]) {
            business_type=@"";
        }else if ([business_type isEqual:@""]) {
            business_type=@"";
        }else if(business_type == nil){
            business_type=@"";
        }
        if ([business_type_id isEqual:[NSNull null]]) {
            business_type_id=@"";
        }else if ([business_type_id isEqual:@""]) {
            business_type_id=@"";
        }else if(business_type_id == nil){
            business_type_id=@"";
        }
        if ([category_id isEqual:[NSNull null]]) {
            category_id=@"";
        }else if ([category_id isEqual:@""]) {
            category_id=@"";
        }else if(category_id == nil){
            category_id=@"";
        }
        if ([category_name isEqual:[NSNull null]]) {
            category_name=@"";
        }else if ([category_name isEqual:@""]) {
            category_name=@"";
        }else if(category_name == nil){
            category_name=@"";
        }
        if ([create_date isEqual:[NSNull null]]) {
            create_date=@"";
        }else if ([create_date isEqual:@""]) {
            create_date=@"";
        }else if(create_date == nil){
            create_date=@"";
        }
        if ([description isEqual:[NSNull null]]) {
            description=@"";
        }else if ([description isEqual:@""]) {
            description=@"";
        }else if(description == nil){
            description=@"";
        }
        if ([distance isEqual:[NSNull null]]) {
            distance=@"";
        }else if ([distance isEqual:@""]) {
            distance=@"";
        }else if(distance == nil){
            distance=@"";
        }
        if ([email isEqual:[NSNull null]]) {
            email=@"";
        }else if ([email isEqual:@""]) {
            email=@"";
        }else if(email == nil){
            email=@"";
        }
        if ([end_time isEqual:[NSNull null]]) {
            end_time=@"";
        }else if ([end_time isEqual:@""]) {
            end_time=@"";
        }else if(end_time == nil){
            end_time=@"";
        }
        if ([latitude isEqual:[NSNull null]]) {
            latitude=@"";
        }else if ([latitude isEqual:@""]) {
            latitude=@"";
        }else if(latitude == nil){
            latitude=@"";
        }
        if ([longitude isEqual:[NSNull null]]) {
            longitude=@"";
        }else if ([longitude isEqual:@""]) {
            longitude=@"";
        }else if(longitude == nil){
            longitude=@"";
        }
        if ([phone isEqual:[NSNull null]]) {
            phone=@"";
        }else if ([phone isEqual:@""]) {
            phone=@"";
        }else if(phone == nil){
            phone=@"";
        }
        
        if ([product_image1 isEqual:[NSNull null]]) {
            product_image1=@"";
        }else if ([product_image1 isEqual:@""]) {
            product_image1=@"";
        }else if(product_image1 == nil){
            product_image1=@"";
        }
        if ([product_image2 isEqual:[NSNull null]]) {
            product_image2=@"";
        }else if ([product_image2 isEqual:@""]) {
            product_image2=@"";
        }else if(product_image2 == nil){
            product_image2=@"";
        }
        if ([product_image3 isEqual:[NSNull null]]) {
            product_image3=@"";
        }else if ([product_image3 isEqual:@""]) {
            product_image3=@"";
        }else if(product_image3 == nil){
            product_image3=@"";
        }
        if ([product_image4 isEqual:[NSNull null]]) {
            product_image4=@"";
        }else if ([product_image4 isEqual:@""]) {
            product_image4=@"";
        }else if(product_image4 == nil){
            product_image4=@"";
        }
        if ([product_image5 isEqual:[NSNull null]]) {
            product_image5=@"";
        }else if ([product_image5 isEqual:@""]) {
            product_image5=@"";
        }else if(product_image5 == nil){
            product_image5=@"";
        }
        if ([product_image6 isEqual:[NSNull null]]) {
            product_image6=@"";
        }else if ([product_image6 isEqual:@""]) {
            product_image6=@"";
        }else if(product_image6 == nil){
            product_image6=@"";
        }
        if ([rating isEqual:[NSNull null]]) {
            rating=@"";
        }else if ([rating isEqual:@""]) {
            rating=@"";
        }else if(rating == nil){
            rating=@"";
        }
        if ([start_time isEqual:[NSNull null]]) {
            start_time=@"";
        }else if ([start_time isEqual:@""]) {
            start_time=@"";
        }else if(start_time == nil){
            start_time=@"";
        }
        if ([user_id isEqual:[NSNull null]]) {
            user_id=@"";
        }else if ([user_id isEqual:@""]) {
            user_id=@"";
        }else if(user_id == nil){
            user_id=@"";
        }
        if ([user_image isEqual:[NSNull null]]) {
            user_image=@"";
        }else if ([user_image isEqual:@""]) {
            user_image=@"";
        }else if(user_image == nil){
            user_image=@"";
        }
        
        if ([username isEqual:[NSNull null]]) {
            username=@"";
        }else if ([username isEqual:@""]) {
            username=@"";
        }else if(username == nil){
            username=@"";
        }
        
        if ([video_url isEqual:[NSNull null]]) {
            video_url=@"";
        }else if ([video_url isEqual:@""]) {
            video_url=@"";
        }else if(video_url == nil){
            video_url=@"";
        }
        
        if ([website_url isEqual:[NSNull null]]) {
            website_url=@"";
        }else if ([website_url isEqual:@""]) {
            website_url=@"";
        }else if(website_url == nil){
            website_url=@"";
        }
        if ([facebook_url isEqual:[NSNull null]]) {
            facebook_url=@"";
        }else if ([facebook_url isEqual:@""]) {
            facebook_url=@"";
        }else if(facebook_url == nil){
            facebook_url=@"";
        }
        
        if ([language_id isEqual:[NSNull null]]) {
            language_id=@"";
        }else if ([language_id isEqual:@""]) {
            language_id=@"";
        }else if(language_id == nil){
            language_id=@"";
        }
        
        if ([sub_category_name isEqual:[NSNull null]]) {
            sub_category_name=@"";
        }else if ([sub_category_name isEqual:@""]) {
            sub_category_name=@"";
        }
        if ([description isEqual:[NSNull null]]) {
            description=@"";
        }else if ([description isEqual:@""]) {
            description=@"";
        }
        if ([rating isEqual:[NSNull null]]) {
            rating=@"";
        }else if ([rating isEqual:@""]) {
            rating=@"";
        }
        if ([category_name isEqual:[NSNull null]]) {
            category_name=@"";
        }else if ([category_name isEqual:@""]) {
            category_name=@"";
        }
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:address forKey:@"address"];
        [dict setObject:business_name forKey:@"business_name"];
        [dict setObject:business_type forKey:@"business_type"];
        [dict setObject:business_type_id forKey:@"business_type_id"];
        
        [dict setObject:category_id forKey:@"category_id"];
        [dict setObject:category_name forKey:@"category_name"];
        [dict setObject:facebook_url forKey:@"facebook_url"];
        [dict setObject:language_id forKey:@"language_id"];
        [dict setObject:create_date forKey:@"create_date"];
        [dict setObject:start_time forKey:@"start_time"];
        [dict setObject:end_time forKey:@"end_time"];
       // [dict setObject:priority forKey:@"priority"];
        
    
        [dict setObject:create_date forKey:@"create_date"];
        [dict setObject:description forKey:@"description"];
        [dict setObject:distance forKey:@"distance"];
        [dict setObject:email forKey:@"email"];
        [dict setObject:latitude forKey:@"latitude"];
        [dict setObject:longitude forKey:@"longitude"];
        [dict setObject:phone forKey:@"phone"];
        [dict setObject:product_image1 forKey:@"product_image1"];
        [dict setObject:product_image2 forKey:@"product_image2"];
        [dict setObject:product_image3 forKey:@"product_image3"];
        [dict setObject:product_image4 forKey:@"product_image4"];
        [dict setObject:product_image5 forKey:@"product_image5"];
        [dict setObject:product_image6 forKey:@"product_image6"];
        // [dict setObject:sub_category_name forKey:@"sub_category_name"];
        [dict setObject:user_id forKey:@"user_id"];
        [dict setObject:user_image forKey:@"user_image"];
        [dict setObject:username forKey:@"username"];
        [dict setObject:video_url forKey:@"video_url"];
        [dict setObject:website_url forKey:@"website_url"];
        [dict setObject:rating forKey:@"rating"];
        [Businessarr addObject:dict];
    }
    return Businessarr;
}


@end

//
//  Allinfo.m
//  All Info
//
//  Created by iPhones on 5/2/16.
//  Copyright © 2016 PS.com. All rights reserved.
//

#import "Allinfo.h"

@implementation Allinfo
-(void)encodeWithCoder:(NSCoder *)encoder
{
    
    [encoder encodeObject:self.address forKey:@"address"];
    [encoder encodeObject:self.business_name forKey:@"business_name"];
    [encoder encodeObject:self.business_type forKey:@"business_type"];
    [encoder encodeObject:self.create_date forKey:@"create_date"];
    [encoder encodeObject:self.description forKey:@"description"];
    [encoder encodeObject:self.distance forKey:@"distance"];
    [encoder encodeObject:self.email forKey:@"email"];
    [encoder encodeObject:self.latitude forKey:@"latitude"];
    [encoder encodeObject:self.longitude forKey:@"longitude"];
    [encoder encodeObject:self.phone forKey:@"phone"];
    [encoder encodeObject:self.product_image1 forKey:@"product_image1"];
    [encoder encodeObject:self.product_image2 forKey:@"product_image2"];
    [encoder encodeObject:self.product_image3 forKey:@"product_image3"];
    [encoder encodeObject:self.product_image4 forKey:@"product_image4"];
    [encoder encodeObject:self.product_image5 forKey:@"product_image5"];
    [encoder encodeObject:self.product_image6 forKey:@"product_image6"];
    
    [encoder encodeObject:self.product_image7 forKey:@"product_image7"];
    [encoder encodeObject:self.product_image8 forKey:@"product_image8"];
    [encoder encodeObject:self.product_image9 forKey:@"product_image9"];
    [encoder encodeObject:self.product_image10 forKey:@"product_image10"];

    
    
    [encoder encodeObject:self.sub_category_name forKey:@"sub_category_name"];
    [encoder encodeObject:self.user_id forKey:@"user_id"];
    [encoder encodeObject:self.user_image forKey:@"user_image"];
    [encoder encodeObject:self.username forKey:@"username"];
    [encoder encodeObject:self.video_url forKey:@"video_url"];
    [encoder encodeObject:self.website_url forKey:@"website_url"];
    [encoder encodeObject:self.rating forKey:@"rating"];
    
    
    ////getalldata
    [encoder encodeObject:self.category_id forKey:@"category_id"];
    [encoder encodeObject:self.category_image forKey:@"category_image"];
    [encoder encodeObject:self.category_name forKey:@"category_name"];
    [encoder encodeObject:self.language_id forKey:@"language_id"];
    
    [encoder encodeObject:self.showDate forKey:@"show_date"];
    
    [encoder encodeObject:self.sub_cat_id forKey:@"sub_cat_id"];
    [encoder encodeObject:self.sub_category_image forKey:@"sub_category_image"];



    ////
    
}
//This is important to for loading the alarm object from user defaults
-(id)initWithCoder:(NSCoder *)decoder
{
    self.address = [decoder decodeObjectForKey:@"address"];
    self.business_name = [decoder decodeObjectForKey:@"business_name"];
    self.business_type = [decoder decodeObjectForKey:@"business_type"];
    self.email = [decoder decodeObjectForKey:@"email"];
    self.latitude = [decoder decodeObjectForKey:@"latitude"];
    self.longitude = [decoder decodeObjectForKey:@"longitude"];
    self.phone = [decoder decodeObjectForKey:@"phone"];
    self.product_image1 = [decoder decodeObjectForKey:@"product_image1"];
    self.product_image2 = [decoder decodeObjectForKey:@"product_image2"];
    self.product_image3 = [decoder decodeObjectForKey:@"product_image3"];
    self.product_image4 = [decoder decodeObjectForKey:@"product_image4"];
    self.product_image5 = [decoder decodeObjectForKey:@"product_image5"];
    self.product_image6 = [decoder decodeObjectForKey:@"product_image6"];
  
    self.product_image7 = [decoder decodeObjectForKey:@"product_image7"];
    self.product_image8 = [decoder decodeObjectForKey:@"product_image8"];
    self.product_image9 = [decoder decodeObjectForKey:@"product_image9"];
    self.product_image10 = [decoder decodeObjectForKey:@"product_image10"];

    self.user_id = [decoder decodeObjectForKey:@"user_id"];
    self.user_image = [decoder decodeObjectForKey:@"user_image"];
    self.username = [decoder decodeObjectForKey:@"username"];
    self.video_url = [decoder decodeObjectForKey:@"video_url"];
    self.website_url = [decoder decodeObjectForKey:@"website_url"];
    self.rating = [decoder decodeObjectForKey:@"rating"];
    //////
    
     self.category_id = [decoder decodeObjectForKey:@"category_id"];
     self.category_image = [decoder decodeObjectForKey:@"category_image"];
     self.category_name = [decoder decodeObjectForKey:@"category_name"];
     self.language_id = [decoder decodeObjectForKey:@"language_id"];
     self.showDate = [decoder decodeObjectForKey:@"show_date"];
    
    self.sub_cat_id = [decoder decodeObjectForKey:@"sub_cat_id"];
    self.sub_category_image = [decoder decodeObjectForKey:@"sub_category_image"];
    self.sub_category_name = [decoder decodeObjectForKey:@"sub_category_name"];
   
    self.business_type_id = [decoder decodeObjectForKey:@"business_type_id"];
    self.end_time = [decoder decodeObjectForKey:@"end_time"];
    self.facebook_url = [decoder decodeObjectForKey:@"facebook_url"];
    
   

    
    
    
    return self;
}
@end

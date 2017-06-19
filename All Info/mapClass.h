//
//  CoffeeShop.h
//  SocialNetwork
//
//  Created by Malahini Solutions on 6/9/16.
//  Copyright (c) 2013 Malahini Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface mapClass : NSObject<MKAnnotation>

@property NSString *flavours;
@property NSString *iconType;
@property NSString *selectedID;
@property NSString *subTitle1;

-(id)initWithTitle:(NSString *)title andCoordinate:(CLLocationCoordinate2D)coordinate andFlavours:(NSString *)flavours AnnotationType:(NSString*)iconType;
-(id)initWithTitle:(NSString *)title andCoordinate:(CLLocationCoordinate2D)coordinate andFlavours:(NSString *)flavours selectedID:(NSString*)selectedID subTitle1:(NSString*)subTitle1;

@end

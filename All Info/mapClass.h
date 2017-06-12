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

-(id)initWithTitle:(NSString *)title andCoordinate:(CLLocationCoordinate2D)coordinate andFlavours:(NSString *)flavours;

//-(id)initWithTitle:(NSString *)title andCoordinate:(CLLocationCoordinate2D)coordinate andFlavours:(NSString *)flavours AnnotationType:(NSString*)iconType selectedID:(NSString*)selectedID;

-(id)initWithTitle:(NSString *)title andCoordinate:(CLLocationCoordinate2D)coordinate andFlavours:(NSString *)flavours AnnotationType:(NSString*)iconType;
-(id)initWithTitle:(NSString *)title andCoordinate:(CLLocationCoordinate2D)coordinate andFlavours:(NSString *)flavours SubTitle:(NSString*)subtitle selectedID:(NSString*)selectedID;

@end

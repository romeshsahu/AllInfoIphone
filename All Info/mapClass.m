//
//  CoffeeShop.m
//  SocialNetwork
//
//  Created by Malahini Solutions on 6/9/16.
//  Copyright (c) 2013 Malahini Solutions. All rights reserved.
//

#import "mapClass.h"

@implementation mapClass
@synthesize title,coordinate,flavours,iconType,selectedID;

-(id)initWithTitle:(NSString *)title andCoordinate:(CLLocationCoordinate2D)coordinate andFlavours:(NSString *)flavours
{
    self=[super init];
    self->title=title;
    self->coordinate=coordinate;
    self->flavours=flavours;
    return self;
}
-(id)initWithTitle:(NSString *)title andCoordinate:(CLLocationCoordinate2D)coordinate andFlavours:(NSString *)flavours AnnotationType:(NSString*)iconType
{
    self=[super init];
    self->title=title;
    self->coordinate=coordinate;
    self->flavours=flavours;
    self->iconType=iconType;

    return self;

}

-(id)initWithTitle:(NSString *)title andCoordinate:(CLLocationCoordinate2D)coordinate andFlavours:(NSString *)flavours selectedID:(NSString*)selectedID subTitle1:(NSString*)subTitle1{
    self=[super init];
    self->title=title;
    self->coordinate=coordinate;
    self->flavours=flavours;
    self->selectedID=selectedID;
    self->_subTitle1=subTitle1;
    
    return self;
    
}


@end

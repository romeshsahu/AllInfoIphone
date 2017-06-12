//
//  CustomTabBar.m
//  NCMMobileApp
//
//  Created by parkhya on 6/6/15.
//  Copyright (c) 2015 Parkhya Solutions. All rights reserved.
//

#import "CustomTabBar.h"

@implementation CustomTabBar
- (void)awakeFromNib {
    [self  setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor whiteColor] }
                                             forState:UIControlStateNormal];
    [self  setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor whiteColor] }
                                             forState:UIControlStateSelected];
    [self setImage:self.image];
    
    [self setSelectedImage:self.selectedImage];

    // calls setter below to adjust image from storyboard / nib file
}

- (void)setImage:(UIImage *)image {
    [super setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    //self.selectedImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    if ([UITabBar instancesRespondToSelector:@selector(setSelectedImageTintColor:)])
//    {
//        [tabBarController.tabBar setSelectedImageTintColor:[UIColor redColor]];
//    }
}

-(void)setSelectedImage:(UIImage *)selectedImage
{
    
    [super setSelectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}


@end

//
//  LocalizeLanguage.m
//  langChange
//
//  Created by parkhya on 1/15/15.
//  Copyright (c) 2015 parkhya. All rights reserved.
//

#import "LocalizeLanguage.h"

@implementation LocalizeLanguage
static NSBundle *bundle = nil;

+(void)initialize {
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [defs objectForKey:@"AppleLanguages"];
    NSString *current = [languages objectAtIndex:0] ;
    [self setLocalizeLanguage:current];
}

/*
 [LocalizeLanguage setLocalizeLanguage:@"en"];
 [LocalizeLanguage setLocalizeLanguage:@"fr"];
 */

+(void)setLocalizeLanguage:(NSString *)lang {
    NSLog(@"preferredLang: %@", lang);
    NSString *path = [[ NSBundle mainBundle ] pathForResource:lang ofType:@"lproj" ];
    bundle = [NSBundle bundleWithPath:path] ;
}

+(NSString *)get:(NSString *)key alter:(NSString *)alternate {
    return [bundle localizedStringForKey:key value:alternate table:nil];
}



- (NSString *)StringToConvert:(NSString *)Str
{
    NSData *UnicodedStr = [Str dataUsingEncoding:NSUTF8StringEncoding];
    NSString *StringValue = [[NSString alloc] initWithData:UnicodedStr encoding:NSNonLossyASCIIStringEncoding];
    
    if (StringValue == NULL) {
        StringValue=Str;
    }
    
    return StringValue;
}


@end

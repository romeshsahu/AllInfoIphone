//
//  main.m
//  All Info
//
//  Created by Mahendra Suryavanshi on 3/3/16.
//  Copyright © 2016 PS.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "LocalizeLanguage.h"


//int main(int argc, char * argv[]) {
//    @autoreleasepool {
//        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
//    }
//}
int main(int argc, char * argv[])
{
    @autoreleasepool {
        [LocalizeLanguage initialize];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}

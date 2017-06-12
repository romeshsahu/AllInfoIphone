//
//  SDWebImageManager_Protected.h
//  Dating
//
//  Created by Earl Kameron G. Arcilla on 3/18/15.
//  Copyright (c) 2015 AppVenture. All rights reserved.
//

#import "SDWebImageManager.h"

@interface SDWebImageManager ()
@property (strong, nonatomic, readwrite) SDImageCache *imageCache;
@property (strong, nonatomic, readwrite) SDWebImageDownloader *imageDownloader;
@property (strong, nonatomic) NSMutableArray *failedURLs;
@property (strong, nonatomic) NSMutableArray *runningOperations;
@end

@interface SDWebImageCombinedOperation : NSObject <SDWebImageOperation>

@property (assign, nonatomic, getter = isCancelled) BOOL cancelled;
@property (copy, nonatomic) SDWebImageNoParamsBlock cancelBlock;
@property (strong, nonatomic) NSOperation *cacheOperation;

@end
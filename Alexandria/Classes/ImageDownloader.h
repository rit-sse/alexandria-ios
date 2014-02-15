//
//  IconDownloader.h
//  Alexandria
//
//  Created by Kristen Mills on 2/15/14.
//  Copyright (c) 2014 Society of Software Engineers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Book.h"

@interface ImageDownloader : NSObject

@property (nonatomic, strong) Book *book;
@property (nonatomic, copy) void (^completionHandler)(void);
@property (nonatomic, strong) NSMutableData *activeDownload;
@property (nonatomic, strong) NSURLConnection *imageConnection;

- (void)startDownload;
- (void)cancelDownload;

@end

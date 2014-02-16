//
//  Book.h
//  Alexandria
//
//  Created by Kristen Mills on 2/15/14.
//  Copyright (c) 2014 Society of Software Engineers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *subtitle;
@property (strong, nonatomic) NSString *authors;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSString *isbn;
@property (strong, nonatomic) NSString *lcc;
@property (strong, nonatomic) NSString *publishDate;
@property (strong, nonatomic) NSString *thumbnailUrl;
@property (strong, nonatomic) NSString *smallUrl;
@property (strong, nonatomic) UIImage *thumbnail;
@end

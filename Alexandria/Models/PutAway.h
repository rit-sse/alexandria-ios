//
//  PutAway.h
//  Alexandria
//
//  Created by Kristen Mills on 2/11/14.
//  Copyright (c) 2014 Society of Software Engineers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PutAway : NSObject
@property (strong, nonatomic) NSString *leftImageUrl;
@property (strong, nonatomic) NSString *leftTitle;
@property (strong, nonatomic) NSString *leftLCC;
@property (strong, nonatomic) NSString *rightImageUrl;
@property (strong, nonatomic) NSString *rightTitle;
@property (strong, nonatomic) NSString *rightLCC;
@property (strong, nonatomic) NSString *shelf;
@end

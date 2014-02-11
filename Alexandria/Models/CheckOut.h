//
//  CheckOut.h
//  Alexandria
//
//  Created by Kristen Mills on 2/10/14.
//  Copyright (c) 2014 Society of Software Engineers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckOut : NSObject
@property (strong, nonatomic) NSString* bookBarcode;
@property (strong, nonatomic) NSString* patronBarcode;
@property (strong, nonatomic) NSString* distributorBarcode;

@end

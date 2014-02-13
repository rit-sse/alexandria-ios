//
//  PutAwayViewController.h
//  Alexandria
//
//  Created by Kristen Mills on 2/11/14.
//  Copyright (c) 2014 Society of Software Engineers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PutAwayViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *shelf;

@property (weak, nonatomic) IBOutlet UIImageView *leftImage;
@property (weak, nonatomic) IBOutlet UILabel *leftTitle;
@property (weak, nonatomic) IBOutlet UILabel *leftLcc;

@property (weak, nonatomic) IBOutlet UIImageView *rightImage;
@property (weak, nonatomic) IBOutlet UILabel *rightTitle;
@property (weak, nonatomic) IBOutlet UILabel *rightLcc;
@property (strong, nonatomic) NSDictionary *left;
@property (strong, nonatomic) NSDictionary *right;
@property (strong, nonatomic) NSString *shelfNumber;
@end

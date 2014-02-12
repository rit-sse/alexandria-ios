//
//  CheckInViewController.h
//  Alexandria
//
//  Created by Kristen Mills on 2/9/14.
//  Copyright (c) 2014 Society of Software Engineers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckInViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UITextField *isbnField;
@property (weak, nonatomic) IBOutlet UITextField *distributorField;
@property (weak, nonatomic) IBOutlet UITextField *patronField;
- (IBAction)submitCheckIn:(id)sender;

@end

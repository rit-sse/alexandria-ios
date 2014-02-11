//
//  CheckOutViewController.h
//  Alexandria
//
//  Created by Kristen Mills on 2/9/14.
//  Copyright (c) 2014 Society of Software Engineers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Colours.h"

@interface CheckOutViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *patronField;
@property (weak, nonatomic) IBOutlet UITextField *isbnField;
@property (weak, nonatomic) IBOutlet UITextField *distributorField;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
- (IBAction)submitCheckOut:(id)sender;
@end

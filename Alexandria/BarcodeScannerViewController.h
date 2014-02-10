//
//  BarcodeScannerViewController.h
//  Alexandria
//
//  Created by Kristen Mills on 2/10/14.
//  Copyright (c) 2014 Society of Software Engineers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BarcodeScannerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *scanButton;

- (IBAction)onScan:(id)sender;
@end

//
//  BarcodeScannerViewController.h
//  Alexandria
//
//  Created by Kristen Mills on 2/10/14.
//  Copyright (c) 2014 Society of Software Engineers. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BarcodeScannerViewController;

@protocol BarcodeScannerViewControllerDelegate <NSObject>
- (void)addBarcodeViewController:(BarcodeScannerViewController *)controller didFinishEnteringBarcode:(NSString *)barcode forButton:(NSString *)button;
@end

@interface BarcodeScannerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *scanButton;
@property (nonatomic, weak) id <BarcodeScannerViewControllerDelegate> delegate;
@property (nonatomic, strong) NSString* identifier;
- (IBAction)onScan:(id)sender;
@end

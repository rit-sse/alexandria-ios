//
//  CheckOutViewController.m
//  Alexandria
//
//  Created by Kristen Mills on 2/9/14.
//  Copyright (c) 2014 Society of Software Engineers. All rights reserved.
//

#import "CheckOutViewController.h"
#import "BarcodeScannerViewController.h"

@interface CheckOutViewController () <BarcodeScannerViewControllerDelegate>

@end

@implementation CheckOutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	[[segue destinationViewController] setDelegate:self];
}

- (void)addBarcodeViewController:(BarcodeScannerViewController *)controller didFinishEnteringBarcode:(NSString *)barcode
{
	[_scanBookButton setTitle:barcode forState:UIControlStateNormal];
}

@end

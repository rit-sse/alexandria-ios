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
        BarcodeScannerViewController *controller = (BarcodeScannerViewController *)segue.destinationViewController;
        controller.identifier = segue.identifier;
	[[segue destinationViewController] setDelegate:self];
}

- (void)addBarcodeViewController:(BarcodeScannerViewController *)controller didFinishEnteringBarcode:(NSString *)barcode forButton:(NSString *)identifier
{
	if([identifier isEqualToString:@"book"]){
		[_scanBookButton setTitle:barcode forState:UIControlStateNormal];
	}else if([identifier isEqualToString:@"distributor"]){
		[_scanDistributorButton setTitle:barcode forState:UIControlStateNormal];
	}else if([identifier isEqualToString:@"patron"]){
		[_scanPatronButton setTitle:barcode forState:UIControlStateNormal];
	}
}

@end

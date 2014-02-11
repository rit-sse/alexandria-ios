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
	_checkOut = [[CheckOut alloc] init];
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
	if(barcode == nil) {
		[_statusLabel setTextColor:[UIColor redColor]];
		[_statusLabel setText:@"Invalid Barcode"];
	} else {
		[_statusLabel setTextColor:[UIColor greenColor]];
		[_statusLabel setText:@"Successfully Scanned!"];
		if([identifier isEqualToString:@"book"]) {
			_checkOut.bookBarcode = barcode;
			[_scanBookButton setTitle:_checkOut.bookBarcode forState:UIControlStateNormal];
			[_scanBookButton setBackgroundColor:[UIColor greenColor]];
		} else if([identifier isEqualToString:@"distributor"]) {
			_checkOut.distributorBarcode = barcode;
			[_scanDistributorButton setTitle:@"Distributor Scanned!" forState:UIControlStateNormal];
			[_scanDistributorButton setBackgroundColor:[UIColor greenColor]];
		} else if([identifier isEqualToString:@"patron"]) {
			_checkOut.patronBarcode = barcode;
			[_scanPatronButton setTitle:@"Patron Scanned!" forState:UIControlStateNormal];
			[_scanPatronButton setBackgroundColor:[UIColor greenColor]];
		}
	}
}

- (IBAction)submitCheckOut:(id)sender {
	[_statusLabel setTextColor:[UIColor blackColor]];
	[_statusLabel setText:@"Attempting Check Out"];
	NSURLResponse *response = nil;
	NSError *error = nil;
	NSData *data = [_checkOut checkOutBookWithResponse:&response error:&error];
	NSString *dataString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}
@end

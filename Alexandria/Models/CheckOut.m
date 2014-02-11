//
//  CheckOut.m
//  Alexandria
//
//  Created by Kristen Mills on 2/10/14.
//  Copyright (c) 2014 Society of Software Engineers. All rights reserved.
//

#import "CheckOut.h"

@implementation CheckOut
-(NSData*) checkOutBookWithResponse:(NSURLResponse**)response error:(NSError**)error
{
	NSURL *URL = [NSURL URLWithString:@"http://alexandria.ad.sofse.org:8080/checkouts.json"];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
	// Set request type
	request.HTTPMethod = @"POST";

	// Set params to be sent to the server
	NSString *params = [NSString stringWithFormat:@"isbn=%@&patron_barcode%@distributor_barcode%@", _bookBarcode, _patronBarcode, _distributorBarcode];
	// Encoding type
	NSData *data = [params dataUsingEncoding:NSUTF8StringEncoding];
	// Add values and contenttype to the http header
	[request addValue:@"8bit" forHTTPHeaderField:@"Content-Transfer-Encoding"];
	[request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	[request addValue:[NSString stringWithFormat:@"%lu", (unsigned long)[data length]] forHTTPHeaderField:@"Content-Length"];
	[request setHTTPBody:data];

	NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:response error:error];
	return responseData;
}
@end

//
//  IconDownloader.m
//  Alexandria
//
//  Created by Kristen Mills on 2/15/14.
//  Copyright (c) 2014 Society of Software Engineers. All rights reserved.
//

#import "ImageDownloader.h"


@implementation ImageDownloader

#pragma mark

- (void)startDownload
{
    self.activeDownload = [NSMutableData data];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.book.thumbnailUrl]];
    
    // alloc+init and start an NSURLConnection; release on completion/failure
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    self.imageConnection = conn;
}

- (void)cancelDownload
{
    [self.imageConnection cancel];
    self.imageConnection = nil;
    self.activeDownload = nil;
}

#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.activeDownload appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	// Clear the activeDownload property to allow later attempts
    self.activeDownload = nil;
    
    // Release the connection now that it's finished
    self.imageConnection = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Set appIcon and clear temporary data/image
    UIImage *image = [[UIImage alloc] initWithData:self.activeDownload];
	self.book.thumbnail = image;
    
    self.activeDownload = nil;
    
    // Release the connection now that it's finished
    self.imageConnection = nil;
	
    // call our delegate and tell it that our icon is ready for display
    if (self.completionHandler)
        self.completionHandler();
}

@end


//
//  BarcodeScannerViewController.m
//  Alexandria
//
//  Created by Kristen Mills on 2/10/14.
//  Copyright (c) 2014 Society of Software Engineers. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "BarcodeScannerViewController.h"

@interface BarcodeScannerViewController () <AVCaptureMetadataOutputObjectsDelegate>
{
	AVCaptureSession *session;
	AVCaptureDevice *device;
	AVCaptureDeviceInput *input;
	AVCaptureMetadataOutput *output;
	AVCaptureVideoPreviewLayer *prevLayer;

	UIView *highlightView;
}
@end

@implementation BarcodeScannerViewController

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
	highlightView = [[UIView alloc] init];
    highlightView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
	highlightView.layer.borderColor = [UIColor greenColor].CGColor;
    highlightView.layer.borderWidth = 3;
    [self.view addSubview:highlightView];
	
    session = [[AVCaptureSession alloc] init];
    device = [self frontCamera];
    NSError *error = nil;
	
    input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if (input) {
        [session addInput:input];
    } else {
        NSLog(@"Error: %@", error);
    }
	
    output = [[AVCaptureMetadataOutput alloc] init];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [session addOutput:output];
	
    output.metadataObjectTypes = [output availableMetadataObjectTypes];
	
    prevLayer = [AVCaptureVideoPreviewLayer layerWithSession:session];
	CGRect r = self.view.bounds;
	prevLayer.frame = CGRectMake(r.origin.x, r.origin.y, r.size.height, r.size.width);
	
    prevLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:prevLayer];
	
    [session startRunning];
	
    [self.view bringSubviewToFront:highlightView];
	[self.view bringSubviewToFront:_scanButton];
}

-(void) viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:YES];
	
	//Get Preview Layer connection
	AVCaptureConnection *previewLayerConnection=prevLayer.connection;
	
	if ([previewLayerConnection isVideoOrientationSupported])
		[previewLayerConnection setVideoOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
}

- (AVCaptureDevice *)frontCamera {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if ([device position] == AVCaptureDevicePositionFront) {
            return device;
        }
    }
    return nil;
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    CGRect highlightViewRect = CGRectZero;
    AVMetadataMachineReadableCodeObject *barCodeObject;
    NSString *detectionString = nil;
    NSArray *barCodeTypes = @[AVMetadataObjectTypeUPCECode, AVMetadataObjectTypeCode39Code, AVMetadataObjectTypeCode39Mod43Code,
							  AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode93Code, AVMetadataObjectTypeCode128Code,
							  AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeQRCode, AVMetadataObjectTypeAztecCode];
	
    for (AVMetadataObject *metadata in metadataObjects) {
        for (NSString *type in barCodeTypes) {
            if ([metadata.type isEqualToString:type])
            {
                barCodeObject = (AVMetadataMachineReadableCodeObject *)[prevLayer transformedMetadataObjectForMetadataObject:(AVMetadataMachineReadableCodeObject *)metadata];
                highlightViewRect = barCodeObject.bounds;
                detectionString = [(AVMetadataMachineReadableCodeObject *)metadata stringValue];
                break;
            }
        }
    }
	
    highlightView.frame = highlightViewRect;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onScan:(id)sender {
	[self.navigationController popViewControllerAnimated:YES];
}
@end

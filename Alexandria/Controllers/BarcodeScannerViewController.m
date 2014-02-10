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
	AVCaptureSession *_session;
	AVCaptureDevice *_device;
	AVCaptureDeviceInput *_input;
	AVCaptureMetadataOutput *_output;
	AVCaptureVideoPreviewLayer *_prevLayer;
	NSString *_detectionString;

	UIView *_highlightView;
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
	_highlightView = [[UIView alloc] init];
    _highlightView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
	_highlightView.layer.borderColor = [UIColor greenColor].CGColor;
    _highlightView.layer.borderWidth = 3;
    [self.view addSubview:_highlightView];
	
    _session = [[AVCaptureSession alloc] init];
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
	
    _input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:&error];
    if (_input) {
        [_session addInput:_input];
    } else {
        NSLog(@"Error: %@", error);
    }
	
    _output = [[AVCaptureMetadataOutput alloc] init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [_session addOutput:_output];
	
    _output.metadataObjectTypes = [_output availableMetadataObjectTypes];
	
    _prevLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
	CGRect r = self.view.bounds;
	_prevLayer.frame = CGRectMake(r.origin.x, r.origin.y, r.size.height, r.size.width);
	
    _prevLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:_prevLayer];
	
    [_session startRunning];
	
    [self.view bringSubviewToFront:_highlightView];
	[self.view bringSubviewToFront:_scanButton];
}

-(void) viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:YES];
	
	//Get Preview Layer connection
	AVCaptureConnection *previewLayerConnection=_prevLayer.connection;
	
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
    NSArray *barCodeTypes = @[AVMetadataObjectTypeUPCECode, AVMetadataObjectTypeCode39Code, AVMetadataObjectTypeCode39Mod43Code,
							  AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode93Code, AVMetadataObjectTypeCode128Code,
							  AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeQRCode, AVMetadataObjectTypeAztecCode];
	
    for (AVMetadataObject *metadata in metadataObjects) {
        for (NSString *type in barCodeTypes) {
            if ([metadata.type isEqualToString:type])
            {
                barCodeObject = (AVMetadataMachineReadableCodeObject *)[_prevLayer transformedMetadataObjectForMetadataObject:(AVMetadataMachineReadableCodeObject *)metadata];
                highlightViewRect = barCodeObject.bounds;
                _detectionString = [(AVMetadataMachineReadableCodeObject *)metadata stringValue];
                break;
            }
        }
    }
	
    _highlightView.frame = highlightViewRect;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onScan:(id)sender {
	[self.delegate addBarcodeViewController:self didFinishEnteringBarcode:_detectionString forButton:_identifier];
	[self.navigationController popViewControllerAnimated:YES];
}
@end

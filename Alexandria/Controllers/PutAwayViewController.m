//
//  PutAwayViewController.m
//  Alexandria
//
//  Created by Kristen Mills on 2/11/14.
//  Copyright (c) 2014 Society of Software Engineers. All rights reserved.
//

#import "PutAwayViewController.h"

@interface PutAwayViewController ()

@end

@implementation PutAwayViewController

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
	NSData *leftImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[_left valueForKey:@"image"]]];
	_leftImage.image = [UIImage imageWithData:leftImageData];
	NSData *rightImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[_right valueForKey:@"image"]]];
	_rightImage.image = [UIImage imageWithData:rightImageData];
	if([[_left valueForKey:@"title"] isEqualToString:@""]) {
		_leftTitle.text = @"This book is";
		_leftLcc.text = @"the first on the shelf";
	} else {
		_leftTitle.text = [_left valueForKey:@"title"];
		_leftLcc.text = [_left valueForKey:@"lcc"];
	}
	if([[_right valueForKey:@"title"] isEqualToString:@""]) {
		_rightTitle.text = @"This book is";
		_rightLcc.text = @"the last on the shelf";
	} else {
		_rightTitle.text = [_right valueForKey:@"title"];
		_rightLcc.text = [_right valueForKey:@"lcc"];
	}
	_shelf.text = [NSString stringWithFormat:@"Shelf: %@",_shelfNumber];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

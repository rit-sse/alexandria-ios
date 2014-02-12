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
	NSData *leftImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:_putAway.leftImageUrl]];
	_leftImage.image = [UIImage imageWithData:leftImageData];
	NSData *rightImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:_putAway.rightImageUrl]];
	_rightImage.image = [UIImage imageWithData:rightImageData];
	if([_putAway.leftTitle isEqualToString:@""]) {
		_leftTitle.text = @"This book is";
		_leftLcc.text = @"the first on the shelf";
	} else {
		_leftTitle.text = _putAway.leftTitle;
		_leftLcc.text = _putAway.leftLCC;
	}
	if([_putAway.rightTitle isEqualToString:@""]) {
		_rightTitle.text = @"This book is";
		_rightLcc.text = @"the last on the shelf";
	} else {
		_rightTitle.text = _putAway.rightTitle;
		_rightLcc.text = _putAway.rightLCC;
	}
	_shelf.text = [NSString stringWithFormat:@"Shelf: %@",_putAway.shelf];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

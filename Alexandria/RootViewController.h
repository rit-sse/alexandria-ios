//
//  RootViewController.h
//  Alexandria
//
//  Created by Kristen Mills on 2/9/14.
//  Copyright (c) 2014 Society of Software Engineers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController <UIPageViewControllerDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;

@end
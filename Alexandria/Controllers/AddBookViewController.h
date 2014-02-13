//
//  AddBookViewController.h
//  Alexandria
//
//  Created by Kristen Mills on 2/9/14.
//  Copyright (c) 2014 Society of Software Engineers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddBookViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *isbnField;
@property (weak, nonatomic) IBOutlet UITextField *librarianField;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
- (IBAction)submitAddBook:(id)sender;


@end

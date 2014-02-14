//
//  ViewBooksViewController.h
//  Alexandria
//
//  Created by Kristen Mills on 2/9/14.
//  Copyright (c) 2014 Society of Software Engineers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewBooksViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *bookList;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *books;
@end

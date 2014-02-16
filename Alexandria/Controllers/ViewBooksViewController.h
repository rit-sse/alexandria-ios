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
@property (weak, nonatomic) IBOutlet UITextView *description;
@property (weak, nonatomic) IBOutlet UILabel *bookTitle;
@property (weak, nonatomic) IBOutlet UILabel *subtitle;
@property (weak, nonatomic) IBOutlet UILabel *authors;
@property (weak, nonatomic) IBOutlet UILabel *isbn;
@property (weak, nonatomic) IBOutlet UILabel *lcc;
@property (weak, nonatomic) IBOutlet UIImageView *cover;
@property (weak, nonatomic) IBOutlet UILabel *publishDate;
@property (strong, nonatomic) NSMutableArray *books;
@end

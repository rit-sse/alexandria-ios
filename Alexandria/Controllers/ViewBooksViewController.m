//
//  ViewBooksViewController.m
//  Alexandria
//
//  Created by Kristen Mills on 2/9/14.
//  Copyright (c) 2014 Society of Software Engineers. All rights reserved.
//

#import "ViewBooksViewController.h"

@interface ViewBooksViewController ()

@end

@implementation ViewBooksViewController

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
	NSURLResponse *response = nil;
	NSError *error = nil;
	
	NSURL *URL = [NSURL URLWithString:@"http://alexandria.ad.sofse.org:8080/books.json"];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
	// Set request type
	request.HTTPMethod = @"GET";
	
	// Add values and contenttype to the http header
	[request addValue:@"8bit" forHTTPHeaderField:@"Content-Transfer-Encoding"];
	[request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	
	NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	
	NSString *dataString = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
	if (error == nil){
		NSError *e;
		_books =[NSJSONSerialization JSONObjectWithData: [dataString dataUsingEncoding:NSUTF8StringEncoding]
															options: NSJSONReadingMutableContainers
															  error: &e];
	}
	[_bookTitle setText:@""];
	[_subtitle setText:@""];
	[_authors setText:@""];
	[_isbn setText:@""];
	[_lcc setText:@""];
	[_description setText:@""];
	_tableView.delegate = self;
    _tableView.dataSource = self;
	[_tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
	
	[cell.textLabel setText:[_books[indexPath.row] valueForKey:@"title"]];
	[cell.detailTextLabel setText:[_books[indexPath.row] valueForKey:@"subtitle"]];
	NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[_books[indexPath.row] valueForKey:@"google_book"] valueForKey:@"img_thumbnail"]]];
	cell.imageView.image = [UIImage imageWithData:imageData];
	
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _books.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *book = _books[indexPath.row];
	NSString *authors = @"";
	for(id author in [book valueForKey:@"authors"]){
		authors = [authors stringByAppendingString:[NSString stringWithFormat:@"%@, ",[author valueForKey:@"full_name"]]];
	}
	authors = [authors stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@" ,"]];
	[_bookTitle setText:[book valueForKey:@"title"]];
	[_subtitle setText:[book valueForKey:@"subtitle"]];
	[_authors setText:authors];
	[_isbn setText:[book valueForKey:@"isbn"]];
	[_lcc setText:[book valueForKey:@"lcc"]];
	[_description setText:[[book valueForKey:@"google_book"] valueForKey:@"description"]];
	NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[_books[indexPath.row] valueForKey:@"google_book"] valueForKey:@"img_small"]]];
	_cover.image = [UIImage imageWithData:imageData];
    
}

@end

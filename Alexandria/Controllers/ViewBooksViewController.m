//
//  ViewBooksViewController.m
//  Alexandria
//
//  Created by Kristen Mills on 2/9/14.
//  Copyright (c) 2014 Society of Software Engineers. All rights reserved.
//

#import "ViewBooksViewController.h"
#import "Book.h"
#import "ImageDownloader.h"

@interface ViewBooksViewController ()
@property (nonatomic, strong) NSMutableDictionary *imageDownloadsInProgress;
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
		NSArray *books =[NSJSONSerialization JSONObjectWithData: [dataString dataUsingEncoding:NSUTF8StringEncoding]
															options: NSJSONReadingMutableContainers
															  error: &e];
		[self populateBookArrayFromBooks:books];
	}
	[_bookTitle setText:@""];
	[_subtitle setText:@""];
	[_authors setText:@""];
	[_isbn setText:@""];
	[_lcc setText:@""];
	[_description setText:@""];
	[_publishDate setText:@""];
	_tableView.delegate = self;
    _tableView.dataSource = self;
	_searchBar.delegate = self;
	[_tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)populateBookArrayFromBooks:(NSArray*) books{
	_books = [[NSMutableArray alloc]init];
	for(id book in books){
		Book *bookObject = [[Book alloc]init];
		NSString *authors = @"";
		for(id author in [book valueForKey:@"authors"]){
			authors = [authors stringByAppendingString:[NSString stringWithFormat:@"%@, ",[author valueForKey:@"full_name"]]];
		}
		authors = [authors stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@" ,"]];
		bookObject.authors = authors;
		bookObject.title = [book valueForKey:@"title"];
		bookObject.subtitle = [book valueForKey:@"subtitle"];
		bookObject.isbn = [book valueForKey:@"isbn"];
		bookObject.lcc = [book valueForKey:@"lcc"];
		bookObject.description = [[book valueForKey:@"google_book"] valueForKey:@"description"];
		bookObject.smallUrl = [[book valueForKey:@"google_book"] valueForKey:@"img_small"];
		bookObject.thumbnailUrl = [[book valueForKey:@"google_book"] valueForKey:@"img_thumbnail"];
		bookObject.publishDate = [book valueForKey:@"publish_date"];
		if (bookObject.publishDate == (id)[NSNull null]){
			bookObject.publishDate = @"";
		}
		[_books addObject:bookObject];
	}
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
	Book* book = _books[indexPath.row];
	[cell.textLabel setText:book.title];
	[cell.detailTextLabel setText:book.subtitle];
	if(!book.thumbnail) {
		if (self.tableView.dragging == NO && self.tableView.decelerating == NO) {
			[self startImageDownload:book forIndexPath:indexPath];
		}
		// if a download is deferred or in progress, return a placeholder image
		cell.imageView.image = [UIImage imageNamed:@"Placeholder.png"];
	} else {
		cell.imageView.image = book.thumbnail;
	}
	
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _books.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Book *book = _books[indexPath.row];
	[_bookTitle setText:book.title];
	[_subtitle setText:book.subtitle];
	[_authors setText:book.authors];
	[_isbn setText:book.isbn];
	[_lcc setText:book.lcc];
	[_publishDate setText:book.publishDate];
	[_description setText:book.description];
	NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:book.smallUrl]];
	_cover.image = [UIImage imageWithData:imageData];
    
}

- (void)startImageDownload:(Book *)book forIndexPath:(NSIndexPath *)indexPath
{
    ImageDownloader *imageDownloader = [self.imageDownloadsInProgress objectForKey:indexPath];
    if (imageDownloader == nil) {
        imageDownloader = [[ImageDownloader alloc] init];
        imageDownloader.book = book;
        [imageDownloader setCompletionHandler:^{
            
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            
            // Display the newly loaded image
            cell.imageView.image = book.thumbnail;
            
            // Remove the IconDownloader from the in progress list.
            // This will result in it being deallocated.
            [self.imageDownloadsInProgress removeObjectForKey:indexPath];
            
        }];
        [self.imageDownloadsInProgress setObject:imageDownloader forKey:indexPath];
        [imageDownloader startDownload];
    }
}

// -------------------------------------------------------------------------------
- (void)loadImagesForOnscreenRows
{

	NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
	for (NSIndexPath *indexPath in visiblePaths) {
		Book *book = [_books objectAtIndex:indexPath.row];
		
		if (!book.thumbnail) {
			[self startImageDownload:book forIndexPath:indexPath];
		}
	}
}

#pragma mark - UIScrollViewDelegate

// -------------------------------------------------------------------------------
//	scrollViewDidEndDragging:willDecelerate:
//  Load images for all onscreen rows when scrolling is finished.
// -------------------------------------------------------------------------------
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        [self loadImagesForOnscreenRows];
    }
}

// -------------------------------------------------------------------------------
//	scrollViewDidEndDecelerating:
// -------------------------------------------------------------------------------
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loadImagesForOnscreenRows];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self handleSearch:searchBar];
}

- (void)handleSearch:(UISearchBar *)searchBar {
	NSURLResponse *response = nil;
	NSError *error = nil;
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://alexandria.ad.sofse.org:8080/books.json?search=%@", searchBar.text]];
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
		NSArray *books =[NSJSONSerialization JSONObjectWithData: [dataString dataUsingEncoding:NSUTF8StringEncoding]
														options: NSJSONReadingMutableContainers
														  error: &e];
		[self populateBookArrayFromBooks:books];
	}
    [searchBar resignFirstResponder]; // if you want the keyboard to go away
	[_tableView reloadData];
}


@end

//
//  SearchViewController.m
//  PocketCrunch
//
//  Created by Anish Basu on 1/26/14.
//  Copyright (c) 2014 Anish Basu. All rights reserved.
//

#import "SearchViewController.h"
#import "CrunchBaseClient.h"
#import "UIImageView+AFNetworking.h"

#define CELL_IDENTIFIER @"SearchResultCell"

@interface SearchViewController () <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) NSArray *searchResults;
@end

@implementation SearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.searchBar.showsCancelButton = YES;
	self.searchBar.placeholder = @"Search on Crunchbase";
	self.searchResults = [NSArray array];
	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER];
	[self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
	return [self.searchResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER
															forIndexPath:indexPath];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
									  reuseIdentifier:CELL_IDENTIFIER];
	}
	CrunchEntity *entity = (CrunchEntity *)[self.searchResults objectAtIndex:indexPath.row];
	
	cell.textLabel.text = entity.name;
	cell.detailTextLabel.text = entity.typeString;
	if (entity.imageUrl) {
		NSURLRequest *imageRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:entity.imageUrl]];
		__weak UITableViewCell *weakCell = cell;
		[cell.imageView setImageWithURLRequest:imageRequest
							  placeholderImage:nil
									   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
										   weakCell.imageView.image = image;
									   } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
										   NSLog(@"Failed to load image for URL: %@", entity.imageUrl);
									   }];
	}
	
	return cell;
}

#pragma mark - UITableViewDelegate



/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
 */


#pragma mark - UISearchBarDelegate

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
	[self.searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
	[searchBar resignFirstResponder];
	[[CrunchBaseClient client] searchWithQuery:searchBar.text
								  withResponse:^(NSDictionary *result, NSError *error) {
									  if (error) {
										  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Search Failed"
																						  message:[error localizedDescription]
																						 delegate:nil
																				cancelButtonTitle:@"OK"
																				otherButtonTitles:nil];
										  [alert show];
									  } else {
										  self.searchResults = [result objectForKey:@"results"];
										  [self.tableView reloadData];
									  }
								  }];
}


@end

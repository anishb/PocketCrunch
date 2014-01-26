//
//  ViewController.m
//  PocketCrunch
//
//  Created by Anish Basu on 1/25/14.
//  Copyright (c) 2014 Anish Basu. All rights reserved.
//

#import "ViewController.h"
#import "CrunchBaseClient.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	[self testNetworking];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)testNetworking
{
	CrunchBaseClient *client = [CrunchBaseClient client];
	[client infoFor:@"twitter"
			 ofType:kCompany
	   withResponse:^(NSDictionary *result, NSError *error) {
		   
	   }];
	
	[client searchWithQuery:@"Zynga"
			   withResponse:^(NSDictionary *result, NSError *error) {
				   
			   }];
	
}

@end

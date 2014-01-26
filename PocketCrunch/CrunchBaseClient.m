//
//  CrunchBaseClient.m
//  PocketCrunch
//
//  Created by Anish Basu on 1/25/14.
//  Copyright (c) 2014 Anish Basu. All rights reserved.
//

#import "CrunchBaseClient.h"
#import <AFNetworking/AFNetworking.h>

#define BASE_URL @"http://api.crunchbase.com"
#define VERSION_URL @"/v/1"
/****
 Yes, the API_KEY intentionally left here. No point of obscuring it since
 the crunchbase API doesn't support HTTPS and it can be sniffed out
 easily
 ****/
#define API_KEY @"28daj5hwhvpf9b2w3jsd4stw"


@interface CrunchBaseClient()
@property (nonatomic, strong) NSString *apiKey;
@end

@implementation CrunchBaseClient

+ (instancetype)client
{
	static CrunchBaseClient *_client = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
		sessionConfig.HTTPAdditionalHeaders = @{@"Accept": @"text/javascript; charset=utf-8"};
		sessionConfig.HTTPCookieAcceptPolicy = NSHTTPCookieAcceptPolicyNever;
		sessionConfig.HTTPMaximumConnectionsPerHost = 1;
		_client = [[CrunchBaseClient alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]
									   sessionConfiguration:sessionConfig
													 apiKey:API_KEY];
	});
	return _client;
}

- (id)initWithBaseURL:(NSURL *)url
 sessionConfiguration:(NSURLSessionConfiguration *)configuration
			   apiKey:(NSString *)apiKey
{
	self = [super initWithBaseURL:url sessionConfiguration:configuration];
	if (self) {
		self.apiKey = apiKey;
	}
	return self;
}

- (void)infoFor:(NSString *)name
		 ofType:(EntityType)type
   withResponse:(CrunchBaseResponse)response
{
	NSString *url = VERSION_URL;
	switch (type) {
		case kCompany:
			url = [url stringByAppendingPathComponent:@"company"];
			break;
		case kPerson:
			url = [url stringByAppendingPathComponent:@"person"];
			break;
		case kFinancialOrganization:
			url = [url stringByAppendingPathComponent:@"financial-organization"];
			break;
		case kProduct:
			url = [url stringByAppendingPathComponent:@"product"];
			break;
		case kServiceProvider:
			url = [url stringByAppendingPathComponent:@"service-provider"];
			break;
		default:
			break;
	}
	
	url = [url stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.js", name]];
	NSLog(@"URL = %@", url);
	[self GET:url
   parameters:@{@"api_key": self.apiKey}
	  success:^(NSURLSessionDataTask *task, id responseObject) {
		  response(responseObject, nil);
	  } failure:^(NSURLSessionDataTask *task, NSError *error) {
		  response(nil, error);
	  }];
}

- (void)searchWithQuery:(NSString *)query
				   page:(NSUInteger)pageNumber
		   withResponse:(CrunchBaseResponse)response
{
	NSString *url = VERSION_URL;
	url = [url stringByAppendingPathComponent:@"search.js"];
	NSLog(@"URL = %@", url);
	[self GET:url
   parameters:@{@"api_key": self.apiKey, @"query": query}
	  success:^(NSURLSessionDataTask *task, id responseObject) {
		  response(responseObject, nil);
	  } failure:^(NSURLSessionDataTask *task, NSError *error) {
		  response(nil, error);
	  }];
	
}

- (void)searchWithQuery:(NSString *)query
		   withResponse:(CrunchBaseResponse)response
{
	[self searchWithQuery:query
					 page:1
			 withResponse:response];
}



@end

//
//  CrunchBaseClient.h
//  PocketCrunch
//
//  Created by Anish Basu on 1/25/14.
//  Copyright (c) 2014 Anish Basu. All rights reserved.
//

#import "AFHTTPSessionManager.h"

typedef void(^CrunchBaseResponse)(NSDictionary *result, NSError *error);

typedef enum {
	kCompany,
	kPerson,
	kFinancialOrganization,
	kProduct,
	kServiceProvider
} EntityType;

@interface CrunchBaseClient : AFHTTPSessionManager

+ (instancetype)client;
- (void)infoFor:(NSString *)name
		 ofType:(EntityType)type
   withResponse:(CrunchBaseResponse)response;
- (void)searchWithQuery:(NSString *)query
				   page:(NSUInteger)page
		   withResponse:(CrunchBaseResponse)response;
- (void)searchWithQuery:(NSString *)query
		   withResponse:(CrunchBaseResponse)response;

@end

//
//  CrunchEntity.m
//  PocketCrunch
//
//  Created by Anish Basu on 1/26/14.
//  Copyright (c) 2014 Anish Basu. All rights reserved.
//

#import "CrunchEntity.h"

@implementation CrunchEntity

- (id)initWithDictionary:(NSDictionary *)info
{
	self = [super init];
	if (self) {
		_info = info;
	}
	return self;
}

- (NSString *)name
{
	return [_info objectForKey:@"name"];
}

- (EntityType)type
{
	NSString *namespace = [_info objectForKey:@"namespace"];
	if ([namespace isEqualToString:@"company"]) {
		return kCompany;
	} else if ([namespace isEqualToString:@"person"]) {
		return kPerson;
	} else if ([namespace isEqualToString:@"financial-organization"]) {
		return kFinancialOrganization;
	} else if ([namespace isEqualToString:@"product"]) {
		return kProduct;
	} else if ([namespace isEqualToString:@"service-provider"]) {
		return kServiceProvider;
	}
	
	return kUnknown;
}

- (NSString *)typeString
{
	EntityType type = [self type];
	NSString *retVal = nil;
	switch (type) {
		case kCompany:
			retVal = @"Company";
			break;
		case kPerson:
			retVal = @"Person";
			break;
		case kFinancialOrganization:
			retVal = @"Financial Organization";
			break;
		case kProduct:
			retVal = @"Product";
			break;
		case kServiceProvider:
			retVal = @"Service Provider";
			break;
		default:
			break;
	}
	
	return retVal;
}

- (NSString *)imageUrl
{
	NSDictionary *imageDict = [_info objectForKey:@"image"];
	if (imageDict != nil && ![imageDict isKindOfClass:[NSNull class]]) {
		NSArray *availableSizes = [imageDict objectForKey:@"available_sizes"];
		if (availableSizes != nil && ![availableSizes isKindOfClass:[NSNull class]] && [availableSizes count] > 0) {
			NSArray *smallestSize = [availableSizes firstObject];
			if (smallestSize != nil && ![smallestSize isKindOfClass:[NSNull class]] && [smallestSize count] > 0) {
				return [NSString stringWithFormat:@"http://www.crunchbase.com/%@", [smallestSize lastObject]];
			}
		}
	}
	
	return nil;
}

@end

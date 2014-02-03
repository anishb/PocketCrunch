//
//  CrunchEntity.h
//  PocketCrunch
//
//  Created by Anish Basu on 1/26/14.
//  Copyright (c) 2014 Anish Basu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
	kCompany,
	kPerson,
	kFinancialOrganization,
	kProduct,
	kServiceProvider,
	kUnknown
} EntityType;

@interface CrunchEntity : NSObject

@property (nonatomic, strong, readonly) NSDictionary *info;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) EntityType type;
@property (nonatomic, readonly) NSString *typeString;
@property (nonatomic, readonly) NSString *website;
@property (nonatomic, readonly) NSString *twitter;
@property (nonatomic, readonly) NSString *imageUrl;
@property (nonatomic, readonly) NSUInteger founded;
@property (nonatomic, readonly) NSString *overview;

- (id)initWithDictionary:(NSDictionary *)info;

@end

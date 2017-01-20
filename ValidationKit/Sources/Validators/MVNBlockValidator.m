//
// MVNBlockValidator
//
// Copyright 2015 Nicolas Marfurt. All rights reserved.
//

#import "MVNBlockValidator.h"

@implementation MVNBlockValidator

#pragma mark Initialization

+ (id)validatorWithBlock:(BOOL (^)(NSString *aString))block
{
	return [[self alloc] initWithBlock:block];
}

- (id)initWithBlock:(BOOL (^)(NSString *aString))block
{
	if (self = [super init]) {
		_block = [block copy];
	}

	return self;
}

#pragma mark Validation

- (BOOL)validate:(NSString *)aString
{
	NSAssert(self.block, @"A block must be set to the MVNBlockValidator object!");
	
	return self.block(aString);
}

@end

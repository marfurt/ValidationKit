//
// MVNValidatorEquality
//
// Copyright 2015 Nicolas Marfurt. All rights reserved.
//

#import "MVNValidatorEquality.h"

@implementation MVNValidatorEquality

#pragma mark Factory

+ (id)validatorWithString:(NSString *)value
{
	return [[self alloc] initWithString:value];
}

#pragma mark Initializing

- (id)initWithString:(NSString *)value
{
	if (self = [super init]) {
		_value = value;
	}

	return self;
}

#pragma mark Validating

- (BOOL)validate:(NSString *)aString
{
	NSAssert(self.value, @"A value must be set to the MVNValidatorEquality object!");
	
	return [aString isEqualToString:self.value];
}

@end

//
// MVNValidatorLength
//
// Copyright 2015 Nicolas Marfurt. All rights reserved.
//

#import "MVNValidatorLength.h"

@implementation MVNValidatorLength

#pragma mark Factory

+ (id)validatorWithMinLength:(NSUInteger)minLength
{
	return [[self alloc] initWithMinLength:minLength];
}

+ (id)validatorWithMaxLength:(NSUInteger)maxLength
{
	return [[self alloc] initWithMaxLength:maxLength];
}

+ (id)validatorWithMinLength:(NSUInteger)minLength maxLength:(NSUInteger)maxLength
{
	return [[self alloc] initWithMinLength:minLength maxLength:maxLength];
}

#pragma mark Initializing

- (id)init
{
	return [self initWithMinLength:0 maxLength:NSIntegerMax];
}

- (id)initWithMinLength:(NSUInteger)minLength
{
	return [self initWithMinLength:minLength maxLength:NSIntegerMax];
}

- (id)initWithMaxLength:(NSUInteger)maxLength
{
	return [self initWithMinLength:0 maxLength:maxLength];
}

- (id)initWithMinLength:(NSUInteger)minLength maxLength:(NSUInteger)maxLength
{
	if (self = [super init]) {
		_minLength = minLength;
		_maxLength = maxLength;
	}

	return self;
}

#pragma mark Validating

- (BOOL)validate:(NSString *)aString
{
	NSInteger length = aString.length;
	
	return (length >= self.minLength && length <= self.maxLength);
}

@end

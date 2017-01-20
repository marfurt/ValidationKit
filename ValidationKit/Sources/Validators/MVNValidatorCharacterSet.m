//
// MVNValidatorCharacterSet
//
// Copyright 2015 Nicolas Marfurt. All rights reserved.
//

#import "MVNValidatorCharacterSet.h"

@implementation MVNValidatorCharacterSet

#pragma mark Factory

+ (id)validatorWithCharacterSet:(NSCharacterSet *)characterSet
{
	return [[self alloc] initWithCharacterSet:characterSet];
}

+ (id)validatorWithCharactersInString:(NSString *)aString
{
	return [[self alloc] initWithCharactersInString:aString];
}

#pragma mark Initializing

- (id)initWithCharacterSet:(NSCharacterSet *)characterSet
{
	if (self = [super init]) {
		_characterSet = characterSet;
	}

	return self;
}

- (id)initWithCharactersInString:(NSString *)aString
{
	if (self = [super init]) {
		_characterSet = [NSCharacterSet characterSetWithCharactersInString:aString];
	}

	return self;
}

#pragma mark Validating

- (BOOL)validate:(NSString *)aString
{
	NSAssert(self.characterSet, @"A character set must be set to the MVNValidatorCharacterSet object!");
	
	if (aString.length == 0) {
		return YES;
	}
	
	return ([aString rangeOfCharacterFromSet:[self.characterSet invertedSet]].location == NSNotFound);
}

@end

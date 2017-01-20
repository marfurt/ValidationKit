//
// MVNValidatorRegex
//
// Copyright 2015 Nicolas Marfurt. All rights reserved.
//

#import "MVNValidatorRegex.h"

@implementation MVNValidatorRegex

#pragma mark Factory

+ (id)validatorWithRegex:(NSString *)regex
{
	return [[self alloc] initWithRegex:regex];
}

#pragma mark Initializing

- (id)initWithRegex:(NSString *)regex
{
	if (self = [super init]) {
		_regex = regex;
	}

	return self;
}

#pragma mark Validating

- (BOOL)validate:(NSString *)aString
{
	NSAssert(self.regex, @"A regular expression must be set to the MVNValidatorRegex object!");
	
	if (!aString) {
		return NO;
	}
	
	NSError *error = nil;
	
	NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:self.regex options:NSRegularExpressionCaseInsensitive error:&error];
	
	if (!error) {
		NSUInteger numberOfMatches = [expression numberOfMatchesInString:aString options:0 range:NSMakeRange(0, [aString length])];

		return (numberOfMatches == 1);
	}

	return NO;
}

@end

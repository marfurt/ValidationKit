//
// MVNValidatorNumber
//
// Copyright 2015 Nicolas Marfurt. All rights reserved.
//

#import "MVNValidatorNumber.h"

static NSNumberFormatter *__formatter = nil;

@implementation MVNValidatorNumber

#pragma mark Factory

+ (id)validatorWithLocale:(NSLocale *)locale
{
	return [[self alloc] initWithLocale:locale];
}

#pragma mark Initializing

- (id)initWithLocale:(NSLocale *)locale
{
	if (self = [super init]) {
		_locale = locale;
	}

	return self;
}

#pragma mark Accessing Properties

// Reset the formatter if the locale changes
- (void)setLocale:(NSLocale *)locale
{
	if (locale != _locale) {
		_locale = locale;
		__formatter = nil;
	}
}

// Avoid recreating a formatter object for every validation
- (NSNumberFormatter *)formatter
{
	if (!__formatter) {
		__formatter = [[NSNumberFormatter alloc] init];
		[__formatter setLocale:(self.locale ?: [NSLocale currentLocale])];
	}
	
	return __formatter;
}

#pragma mark Validating

- (BOOL)validate:(NSString *)aString
{
	if (aString.length == 0) {
		return YES;
	}
	
	NSNumber *number = [[self formatter] numberFromString:aString];
	
	return (number != nil);
}

@end

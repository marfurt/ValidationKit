//
// MVNValidatorNumeric
//
// Copyright 2015 Nicolas Marfurt. All rights reserved.
//

#import "MVNValidatorNumeric.h"

@implementation MVNValidatorNumeric

- (BOOL)validate:(NSString *)aString
{
	if (aString.length == 0) {
		return YES;
	}

	NSCharacterSet *characterSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
	
	return ([aString rangeOfCharacterFromSet:characterSet].location == NSNotFound);
}

@end

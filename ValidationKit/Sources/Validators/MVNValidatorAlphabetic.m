//
// MVNValidatorAlphabetic
//
// Copyright 2015 Nicolas Marfurt. All rights reserved.
//

#import "MVNValidatorAlphabetic.h"

@implementation MVNValidatorAlphabetic

- (BOOL)validate:(NSString *)aString
{
	if (aString.length == 0) {
		return YES;
	}
	
	NSMutableCharacterSet *characterSet = [NSMutableCharacterSet letterCharacterSet];
	
	if (self.allowsWhitespaces) {
		 [characterSet formUnionWithCharacterSet:[NSCharacterSet whitespaceCharacterSet]];
	}
	
	if (self.allowsPonctuation) {
		[characterSet formUnionWithCharacterSet:[NSCharacterSet punctuationCharacterSet]];
	}
	
	return ([aString rangeOfCharacterFromSet:[characterSet invertedSet]].location == NSNotFound);
}

@end

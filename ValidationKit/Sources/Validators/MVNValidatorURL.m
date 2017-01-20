//
// MVNValidatorURL
//
// Copyright 2015 Nicolas Marfurt. All rights reserved.
//

#import "MVNValidatorURL.h"
#import "NSString+MVNAdditions.h"

@implementation MVNValidatorURL

- (BOOL)validate:(NSString *)aString
{
	if (aString.length == 0) {
		return YES;
	}
	
	return [aString mvn_isValidURL];
}

@end

//
// MVNValidatorEmail
//
// Copyright 2015 Nicolas Marfurt. All rights reserved.
//

#import "MVNValidatorEmail.h"
#import "NSString+MVNAdditions.h"

@implementation MVNValidatorEmail

- (BOOL)validate:(NSString *)aString
{
	if (aString.length == 0) {
		return YES;
	}
	
	return [aString mvn_isValidEmail];
}

@end

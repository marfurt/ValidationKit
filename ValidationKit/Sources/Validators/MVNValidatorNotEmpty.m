//
// MVNValidatorNotEmpty
//
// Copyright 2015 Nicolas Marfurt. All rights reserved.
//

#import "MVNValidatorNotEmpty.h"

@implementation MVNValidatorNotEmpty

- (BOOL)validate:(NSString *)aString
{
	return (aString.length > 0);
}

@end

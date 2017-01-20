//
// MVNValidatorEmpty
//
// Copyright 2015 Nicolas Marfurt. All rights reserved.
//

#import "MVNValidatorEmpty.h"

@implementation MVNValidatorEmpty

- (BOOL)validate:(NSString *)aString
{
    return (aString.length == 0);
}

@end

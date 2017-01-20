//
// UIView+MVNValidation
//
// Copyright 2015 Nicolas Marfurt. All rights reserved.
//

#import "UIView+MVNValidation.h"
#import "MVNTextField.h"

@implementation UIView (MVNValidation)

- (BOOL)mvn_validateTextFields
{
	BOOL isValid = YES;
	
	if ([self isKindOfClass:[MVNTextField class]]) {
		isValid = [(MVNTextField *)self validate];
	}
	
	for(UIView *subview in self.subviews) {
		if (![subview mvn_validateTextFields]) {
			isValid = NO;
		}
	}
	
	return isValid;
}

@end

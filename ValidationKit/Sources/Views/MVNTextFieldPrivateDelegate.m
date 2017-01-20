//
// MVNTextFieldPrivateDelegate
//
// Copyright 2015 Nicolas Marfurt. All rights reserved.
//

#import "MVNTextFieldPrivateDelegate.h"

@implementation MVNTextFieldPrivateDelegate

#pragma mark Initialization

- (id)initWithTextField:(MVNTextField *)aTextField
{
	if (self = [super init]) {
		self.textField = aTextField;
	}
	return self;
}

#pragma mark Managing non overridden delegate methods

- (BOOL)respondsToSelector:(SEL)selector
{
	return [self.delegate respondsToSelector:selector] || [super respondsToSelector:selector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
	if ([self.delegate respondsToSelector:anInvocation.selector]) {
		[anInvocation invokeWithTarget:self.delegate];
	}
	else {
		[super forwardInvocation:anInvocation];
	}
}

#pragma mark Validating TextField Content

- (BOOL)textField:(MVNTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	BOOL shouldChangeCharacters = YES;
	
	if (textField.validateDuringEdition) {
		NSString *updatedText = [textField.text stringByReplacingCharactersInRange:range withString:string];
		
		BOOL isValid = [textField validate:updatedText];
		
		if (!textField.allowsInvalidTextDuringEdition) {
			shouldChangeCharacters = isValid;
		}
	}
	
	// ??? Enable delete
	/*if (range.length > 0 && [string length] == 0) {
		return YES;
	}*/
	
	if (!shouldChangeCharacters) {
		return NO;
	}
	
	if (self.delegate && [self.delegate respondsToSelector:_cmd]) {
		shouldChangeCharacters = [self.delegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
	}
	
	return shouldChangeCharacters;
}

- (void)textFieldDidEndEditing:(MVNTextField *)textField
{
	[textField validate];
	
	if (self.delegate && [self.delegate respondsToSelector:_cmd]) {
		[self.delegate textFieldDidEndEditing:textField];
	}
}

@end

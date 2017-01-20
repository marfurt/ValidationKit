//
// NSString + MVNAdditions
//
// Copyright 2015 Nicolas Marfurt. All rights reserved.
//

#import "NSString+MVNAdditions.h"

@implementation NSString (MVNAdditions)

#pragma mark Cleaning Strings

- (NSString *)mvn_stringByTrimmingWhitespaceAndNewlineCharacters
{
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)mvn_stringWithoutAccents
{
	return [[NSString alloc] initWithData:[self dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES] encoding:NSASCIIStringEncoding];
}

#pragma mark Characters

- (BOOL)mvn_containsString:(NSString *)aString
{
	if (!aString) {
		return NO;
	}
	
	return ([self rangeOfString:aString].location != NSNotFound);
}

- (NSUInteger)mvn_lineCount
{
	NSUInteger count = 0;
	NSUInteger location = 0;
	
	while (location < [self length]) {
		// Get next line start and set current location to it
		[self getLineStart:nil end:&location contentsEnd:nil forRange:NSMakeRange(location,1)];
		count += 1;
	}
	
	return count;
}

- (BOOL)mvn_isWhitespaceAndNewlines
{
	NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
	for (NSInteger i = 0; i < self.length; ++i) {
		unichar c = [self characterAtIndex:i];
		if(![whitespace characterIsMember:c]) {
			return NO;
		}
	}

	return YES;
}

- (BOOL)mvn_isWhitespace
{
	return [self mvn_isWhitespaceAndNewlines];
}

- (BOOL)mvn_isEmptyOrWhitespace
{
	return !self.length || ![self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length;
}

#pragma mark Validation

- (BOOL)mvn_isValidEmail 
{
	NSString *emailRegEx =  
	@"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"  
	@"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" 
	@"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"  
	@"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"  
	@"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"  
	@"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"  
	@"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";  
	
	NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];

	return [regExPredicate evaluateWithObject:[self lowercaseString]];  
}

- (BOOL)mvn_isValidURL
{
	NSURL *candidateURL = [NSURL URLWithString:self];
	
	return (candidateURL && candidateURL.scheme && candidateURL.host);
}

@end

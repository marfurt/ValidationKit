//
// NSString + MVNAdditions
//
// Copyright 2015 Nicolas Marfurt. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Returns an empty NSString if the given string is `nil`, otherwise the string itself. */
NS_INLINE id MVNStringOrEmpty(NSString *string)
{
	return (string ?: @"");
}

/** Returns the given NSString or the specified default value if the string is empty. */
NS_INLINE NSString * MVNStringOrValue(NSString *string, NSString *value)
{
	return ([string length] > 0 ? string : value);
}


/**
 * This cateogry adds utilities methods to the `NSString` class.
 */
@interface NSString (MVNAdditions)


///---------------------------------------------------------------------------------------
/// @name Cleaning Strings
///---------------------------------------------------------------------------------------

/**
 * Returns a new string made by removing from both ends of the receiver whitespaces and newline characters.
 *
 * @return A new string made by removing from both ends of the receiver whitespaces and newline characters.
 */
- (NSString *)mvn_stringByTrimmingWhitespaceAndNewlineCharacters;

/**
 * Returns a new string object without accent.
 *
 * @return A new string object without accent.
 */
- (NSString *)mvn_stringWithoutAccents;


///---------------------------------------------------------------------------------------
/// @name Working with Characters
///---------------------------------------------------------------------------------------

/**
 * Returns a Boolean that indicates whether the receiver contains the specified string.
 *
 * @param string The substring to test.
 * @return YES if the receiver contains the specified string, otherwise NO.
 */
- (BOOL)mvn_containsString:(NSString *)string;

/**
 * Returns the number of lines.
 *
 * @return The number of lines.
 */
- (NSUInteger)mvn_lineCount;


/**
 * Returns a Boolean that indicates whether the receiver only contains whitespaces or new lines.
 *
 * @return YES if the receiver only contains whitespaces or new lines, otherwise NO.
 */
- (BOOL)mvn_isWhitespaceAndNewlines;

/**
 * Returns a Boolean that indicates whether the receiver only contains whitespaces.
 *
 * @return YES if the receiver only contains whitespaces, otherwise NO.
 */
- (BOOL)mvn_isWhitespace;

/**
 * Returns a Boolean that indicates whether the receiver is empty or only contains whitespaces.
 *
 * @return YES if the receiver is empty or only contains whitespaces, otherwise NO.
 */
- (BOOL)mvn_isEmptyOrWhitespace;


///---------------------------------------------------------------------------------------
/// @name Validating Strings
///---------------------------------------------------------------------------------------

/**
 * Returns a Boolean that indicates whether the receiver is valid email address.
 *
 * @return YES if the receiver is a valid email address, otherwise NO.
 */
- (BOOL)mvn_isValidEmail;

/**
 * Returns a Boolean that indicates whether the receiver is valid URL.
 *
 * @return YES if the receiver is a valid URL, otherwise NO.
 */
- (BOOL)mvn_isValidURL;

@end

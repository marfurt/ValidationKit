//
// MVNValidatorCharacterSet
//
// Copyright 2015 Nicolas Marfurt. All rights reserved.
//

#import "MVNValidator.h"

/**
 * The `MVNValidatorCharacterSet` class validates a string against a given character set.
 */
@interface MVNValidatorCharacterSet : MVNValidator

///---------------------------------------------------------------------------------------
/// @name Creating a MVNValidatorCharacterSet
///---------------------------------------------------------------------------------------

/**
 * Creates and returns a validator object with a set of valid characters.
 *
 * @param characterSet A character set which the validated string is matched against.
 * @return A new validator.
 */
+ (id)validatorWithCharacterSet:(NSCharacterSet *)characterSet;

/**
 * Creates and returns a validator object containing the valid characters in a given string.
 *
 * @param aString A string containing valid characters for the validator.
 * @return A new validator.
 */
+ (id)validatorWithCharactersInString:(NSString *)aString;


///---------------------------------------------------------------------------------------
/// @name Initializing a MVNValidatorCharacterSet Instance
///---------------------------------------------------------------------------------------

/**
 * Initializes and returns a validator object with a set of valid characters.
 *
 * @param characterSet A character set which the validated string is matched against.
 * @return A newly allocated `MVNValidatorCharacterSet` object.
 */
- (id)initWithCharacterSet:(NSCharacterSet *)characterSet;

/**
 * Initializes and returns a validator object containing the valid characters in a given string.
 *
 * @param aString A string containing valid characters for the validator.
 * @return A newly allocated `MVNValidatorCharacterSet` object.
 */
- (id)initWithCharactersInString:(NSString *)aString;


///---------------------------------------------------------------------------------------
/// @name Accessing Validator Properties
///---------------------------------------------------------------------------------------

/** A character set which the validated string is matched against. */
@property (strong, nonatomic) NSCharacterSet *characterSet;

@end

//
// MVNValidatorRegex
//
// Copyright 2015 Nicolas Marfurt. All rights reserved.
//

#import "MVNValidator.h"

/**
 * The `MVNValidatorRegex` class validates a string against a regular expression.
 */
@interface MVNValidatorRegex : MVNValidator

///---------------------------------------------------------------------------------------
/// @name Creating a MVNValidatorRegex
///---------------------------------------------------------------------------------------

/**
 * Creates and returns a validator object with a custom regex string.
 *
 * @param regex A regular expression which the validated string is matched against.
 * @return A new validator.
 */
+ (id)validatorWithRegex:(NSString *)regex;


///---------------------------------------------------------------------------------------
/// @name Initializing a MVNValidatorRegex Instance
///---------------------------------------------------------------------------------------

/**
 * Initializes and returns a validator object with a custom regex string.
 *
 * @param regex A regular expression which the validated string is matched against.
 * @return A newly allocated `MVNValidatorRegex` object.
 */
- (id)initWithRegex:(NSString *)regex;


///---------------------------------------------------------------------------------------
/// @name Accessing Validator Properties
///---------------------------------------------------------------------------------------

/** A regular expression which the validated string is matched against. */
@property (copy, nonatomic) NSString *regex;

@end

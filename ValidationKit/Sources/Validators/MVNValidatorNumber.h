//
// MVNValidatorNumber
//
// Copyright 2015 Nicolas Marfurt. All rights reserved.
//

#import "MVNValidator.h"

/**
 * The `MVNValidatorNumber` validates a string for numbers.
 */
@interface MVNValidatorNumber : MVNValidator

///---------------------------------------------------------------------------------------
/// @name Creating a MVNValidatorNumber
///---------------------------------------------------------------------------------------

/**
 * Creates and returns a validator object with a given locale.
 *
 * @param locale The locale to use for validating a number.
 * @return A new validator.
 */
+ (id)validatorWithLocale:(NSLocale *)locale;


///---------------------------------------------------------------------------------------
/// @name Initializing a MVNValidatorNumber Instance
///---------------------------------------------------------------------------------------

/**
 * Initializes and returns a validator object with a given locale.
 *
 * @param locale The locale to use for validating a number.
 * @return A newly allocated `MVNValidatorNumber` object.
 */
- (id)initWithLocale:(NSLocale *)locale;


///---------------------------------------------------------------------------------------
/// @name Accessing Validator Properties
///---------------------------------------------------------------------------------------

/** The number locale. */
@property (strong, nonatomic) NSLocale *locale;

@end

//
// MVNValidatorEquality
//
// Copyright 2015 Nicolas Marfurt. All rights reserved.
//

#import "MVNValidator.h"

/**
 * The `MVNValidatorEquality` class validates a string equality.
 */
@interface MVNValidatorEquality : MVNValidator

///---------------------------------------------------------------------------------------
/// @name Creating a MVNValidatorEquality
///---------------------------------------------------------------------------------------

/**
 * Creates and returns a validator object with a custom string.
 *
 * @param value A string value which the validated string is matched against.
 * @return A new validator.
 */
+ (id)validatorWithString:(NSString *)value;


///---------------------------------------------------------------------------------------
/// @name Initializing a MVNValidatorEquality Instance
///---------------------------------------------------------------------------------------

/**
 * Initializes and returns a validator object with a custom string.
 *
 * @param value A string value which the validated string is matched against.
 * @return A newly allocated `MVNValidatorEquality` object.
 */
- (id)initWithString:(NSString *)value;


///---------------------------------------------------------------------------------------
/// @name Accessing Validator Properties
///---------------------------------------------------------------------------------------

/** A value which the validated string is matched against. */
@property (copy, nonatomic) NSString *value;

@end

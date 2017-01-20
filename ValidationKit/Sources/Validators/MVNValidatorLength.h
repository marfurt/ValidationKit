//
// MVNValidatorLength
//
// Copyright 2015 Nicolas Marfurt. All rights reserved.
//

#import "MVNValidator.h"

/**
 * The `MVNValidatorLength` class validates the length of a string.
 */
@interface MVNValidatorLength : MVNValidator

///---------------------------------------------------------------------------------------
/// @name Creating a MVNValidatorRegex
///---------------------------------------------------------------------------------------

/**
 * Creates and returns a length validator object.
 *
 * @param minLength The minimum length of the validated string.
 * @return A new validator.
 */
+ (id)validatorWithMinLength:(NSUInteger)minLength;

/**
 * Creates and returns a length validator object.
 *
 * @param maxLength The maximum length of the validated string.
 * @return A new validator.
 */
+ (id)validatorWithMaxLength:(NSUInteger)maxLength;

/**
 * Creates and returns a length validator object.
 *
 * @param minLength The minimum length of the validated string.
 * @param maxLength The maximum length of the validated string.
 * @return A new validator.
 */
+ (id)validatorWithMinLength:(NSUInteger)minLength maxLength:(NSUInteger)maxLength;


///---------------------------------------------------------------------------------------
/// @name Initializing a MVNValidatorRegex Instance
///---------------------------------------------------------------------------------------

/**
 * Initializes and returns a length validator object.
 *
 * @param minLength The minimum length of the validated string.
 * @return A newly allocated `MVNValidatorLength` object.
 */
- (id)initWithMinLength:(NSUInteger)minLength;

/**
 * Initializes and returns a length validator object.
 *
 * @param maxLength The maximum length of the validated string.
 * @return A newly allocated `MVNValidatorLength` object.
 */
- (id)initWithMaxLength:(NSUInteger)maxLength;

/**
 * Initializes and returns a length validator object.
 *
 * @param minLength The minimum length of the validated string.
 * @param maxLength The maximum length of the validated string.
 * @return A newly allocated `MVNValidatorLength` object.
 */
- (id)initWithMinLength:(NSUInteger)minLength maxLength:(NSUInteger)maxLength;


///---------------------------------------------------------------------------------------
/// @name Accessing Validator Properties
///---------------------------------------------------------------------------------------

/** The minimum length which the validated string is matched against. Default is set to 0. */
@property (assign, nonatomic) NSUInteger minLength;

/** The maximum length which the validated string is matched against. Default is set to `NSIntegerMax`. */
@property (assign, nonatomic) NSUInteger maxLength;

@end

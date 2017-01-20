//
// MVNBlockValidator
//
// Copyright 2015 Nicolas Marfurt. All rights reserved.
//

#import "MVNValidator.h"

/**
 * The `MVNBlockValidator` class is a concrete subclass of MVNValidator that uses a block for validating an input.
 */
@interface MVNBlockValidator : MVNValidator

///---------------------------------------------------------------------------------------
/// @name Creating a MVNBlockValidator
///---------------------------------------------------------------------------------------

/**
 * Creates and returns a block validator object and adds the specified block to it.
 *
 * @param block The block called for validating the string.
 * @return A new validator.
 */
+ (id)validatorWithBlock:(BOOL (^)(NSString *aString))block;


///---------------------------------------------------------------------------------------
/// @name Initializing a MVNBlockValidator Instance
///---------------------------------------------------------------------------------------

/**
 * Initializes and returns a block validator object and adds the specified block to it.
 *
 * @param block The block called for validating the string.
 * @return A newly allocated `MVNBlockValidator` object.
 */
- (id)initWithBlock:(BOOL (^)(NSString *aString))block;


///---------------------------------------------------------------------------------------
/// @name Accessing Validator Properties
///---------------------------------------------------------------------------------------

/** The block called for validating the string. */
@property (copy, nonatomic) BOOL (^block)(NSString *aString);

@end

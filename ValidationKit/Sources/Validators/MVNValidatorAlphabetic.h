//
// MVNValidatorAlphabetic
//
// Copyright 2015 Nicolas Marfurt. All rights reserved.
//

#import "MVNValidator.h"

/**
 * The `MVNValidatorAlphabetic` class validates a string for occurrences of letters.
 */
@interface MVNValidatorAlphabetic : MVNValidator

///---------------------------------------------------------------------------------------
/// @name Accessing Validator Properties
///---------------------------------------------------------------------------------------

/** A Boolean that determines whether the string can contain white spaces. The default value is `NO`. */
@property (assign, nonatomic) BOOL allowsWhitespaces;

/** A Boolean that determines whether the string can contain ponctuation. The default value is `NO`. */
@property (assign, nonatomic) BOOL allowsPonctuation;

@end

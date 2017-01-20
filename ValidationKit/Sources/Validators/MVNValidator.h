//
// MVNValidator
//
// Copyright 2015 Nicolas Marfurt. All rights reserved.
//

#import <Foundation/Foundation.h>

/** The rule to use for validation when multiple validators are used. */
typedef NS_ENUM(NSInteger, MVNValidationRule) {
	MVNValidationRuleCompositeOr = 0,
	MVNValidationRuleCompositeAnd
};

/**
 * An object must conform to the `MVNValidatorProtocol` protocol in order to benefit from text validation.
 */
@protocol MVNValidatorProtocol <NSObject>

/**
 * Validates the receiver text against the existing validators.
 *
 * @return `YES` if the receiver text if valid, otherwise `NO`.
 */
- (BOOL)validate;

@end


#pragma mark -


/**
 * The `MVNValidator` class is an abstract class that stores a condition for checking text validation.
 *
 * A validator examines its input with respect to some requirements and produces a boolean result:
 * whether the input successfully validates against the requirements.
 *
 * Specific validators must subclass the `MVNValidator` class and implement the `- (BOOL)validate:(NSString *)string` method.
 */
@interface MVNValidator : NSObject

///---------------------------------------------------------------------------------------
/// @name Validating Text
///---------------------------------------------------------------------------------------

- (BOOL)validate:(NSString *)string;


///---------------------------------------------------------------------------------------
/// @name Accessing Validator Properties
///---------------------------------------------------------------------------------------

/** A message that describes the error when the input is invalid. */
@property (copy, nonatomic) NSString *message;

@end

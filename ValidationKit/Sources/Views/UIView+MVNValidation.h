//
// UIView+MVNValidation
//
// Copyright 2015 Nicolas Marfurt. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 * The `MVNValidation` category adds methods to the `UIView` class for easily validating text content.
 */
@interface UIView (MVNValidation)


///---------------------------------------------------------------------------------------
/// @name Validating Text Fields
///---------------------------------------------------------------------------------------

/**
 * Validates all `MVNTextField` objects found in the view (including its subviews).
 *
 * @return `YES` if all text fields are valid, otherwise `NO`.
 */
- (BOOL)mvn_validateTextFields;

@end

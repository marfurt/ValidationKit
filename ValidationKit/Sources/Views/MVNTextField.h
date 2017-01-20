//
// MVNTextField
//
// Copyright 2015 Nicolas Marfurt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MVNValidator.h"


/** The state of a text field; a text field can have more than one state at a time. */
typedef NS_OPTIONS(NSInteger, MVNTextFieldState) {
	MVNTextFieldStateNormal      = 0,
	MVNTextFieldStateHighlighted = 1 << 0,
	MVNTextFieldStateInvalid     = 1 << 1,
	MVNTextFieldStateEmpty       = 1 << 2,
};


@class MVNTextField;

/**
 * The `MVNTextFieldDelegate` protocol extends `UITextFieldDelegate` by adding messages sent to a text field delegate.
 *
 * You can use these methods for example to show overlay or right/left tooltip views for displaying validation errors.
 */
@protocol MVNTextFieldDelegate <UITextFieldDelegate>

@optional

/**
 * Tells the delegate that the specified text field passed validation.
 *
 * @param textField The text field containing the text.
 */
- (void)textFieldDidPassValidation:(MVNTextField *)textField;

/**
 * Tells the delegate that the specified text field failed validation.
 *
 * @param textField The text field containing the text.
 * @param validators The validators that return an error while checking the text field text.
 */
- (void)textField:(MVNTextField *)textField didFailValidationForValidators:(NSArray *)validators;

@end


#pragma mark - MVNTextField


/**
 * The `MVNTextField` class adds useful functionality to the UITextField class,
 * such as the possibility to validate text input or to set appearance properties depending on text field state.
 *
 * This class provides methods for setting the appearance of a text field. By using these accessors,
 * you can specify a different appearance for each text field state, described in MVNTextFieldState.
 *
 * A `MVNTextField` object can be linked to one or multiple `MVNValidator` objects used to check input text validity
 * during edition or manually by invoking the `- (BOOL)validate` method.
 */
@interface MVNTextField : UITextField <UIAppearanceContainer, MVNValidatorProtocol>


///---------------------------------------------------------------------------------------
/// @name Accessing the Delegate
///---------------------------------------------------------------------------------------

/** The receiver’s delegate. */
@property (weak, nonatomic) IBOutlet id<MVNTextFieldDelegate> delegate;


///---------------------------------------------------------------------------------------
/// @name Accessing TextField State Attributes
///---------------------------------------------------------------------------------------

/** A Boolean value that indicates the state of the receiver. (read-only) */
@property(nonatomic, readonly) MVNTextFieldState textFieldState;

/**
 * A Boolean value that determines whether the receiver is valid.
 * @discussion Accessing this property does not validate the field; you must manually call `validate` before.
 *             Besides, the delegate is not called and validation callbacks must be managed manually.
 */
@property(nonatomic, getter = isValid) BOOL valid;

/** A Boolean value that determines whether the receiver is empty. (read-only) */
@property(nonatomic, readonly, getter = isEmpty) BOOL empty;


///---------------------------------------------------------------------------------------
/// @name Setting and Getting the TextField Appearance
///---------------------------------------------------------------------------------------

/**
 * Returns the background image used for a state.
 *
 * @param state The state that uses the bacground image.
 *
 * @return The background image for the specified state.
 */
- (UIImage *)backgroundImageForState:(MVNTextFieldState)state;

/**
 * Sets the background image to use for the specified state.
 *
 * @param anImage The background image to use for the specified state.
 * @param state The state that uses the specified background image. The values are described in MVNTextFieldState.
 *
 * @discussion In general, if a property is not specified for a state, the default is to use the MVNTextFieldStateNormal value. If the value for `MVNTextFieldStateNormal` is not set, a default value is used.
 */
- (void)setBackgroundImage:(UIImage *)anImage forState:(MVNTextFieldState)state UI_APPEARANCE_SELECTOR;

/**
 * Returns the text color used for a state.
 *
 * @param state The state that uses the text color. Possible values are described in MVNTextFieldState.
 *
 * @return The text color for the specified state. 
 */
- (UIColor *)textColorForState:(MVNTextFieldState)state;

/**
 * Sets the text color to use for the specified state.
 *
 * @param color The color to use for the specified state.
 * @param state The state that uses the specified text color. The values are described in MVNTextFieldState.
 *
 * @discussion In general, if a property is not specified for a state, the default is to use the MVNTextFieldStateNormal value. If the value for `MVNTextFieldStateNormal` is not set, a default value is used.
 */
- (void)setTextColor:(UIColor *)color forState:(MVNTextFieldState)state UI_APPEARANCE_SELECTOR;

/**
 * Returns the border color used for a state.
 *
 * @param state The state that uses the border color. Possible values are described in MVNTextFieldState.
 *
 * @return The border color for the specified state.
 */
- (UIColor *)borderColorForState:(MVNTextFieldState)state;

/**
 * Sets the border color to use for the specified state.
 *
 * @param color The color to use for the specified state.
 * @param state The state that uses the specified border color. The values are described in MVNTextFieldState.
 *
 * @discussion In general, if a property is not specified for a state, the default is to use the MVNTextFieldStateNormal value. If the value for `MVNTextFieldStateNormal` is not set, a default value is used.
 */
- (void)setBorderColor:(UIColor *)color forState:(MVNTextFieldState)state UI_APPEARANCE_SELECTOR;

/**
 * Returns the glow color used for a state.
 *
 * @param state The state that uses the glow color. Possible values are described in MVNTextFieldState.
 *
 * @return The glow color for the specified state.
 */
- (UIColor *)glowColorForState:(MVNTextFieldState)state;

/**
 * Sets the glow color to use for the specified state.
 *
 * @param color The color to use for the specified state.
 * @param state The state that uses the specified glow color. The values are described in MVNTextFieldState.
 *
 * @discussion If a property is not specified for a state, no glow is displayed.
 */
- (void)setGlowColor:(UIColor *)color forState:(MVNTextFieldState)state UI_APPEARANCE_SELECTOR;


///---------------------------------------------------------------------------------------
/// @name Getting the Current State
///---------------------------------------------------------------------------------------

/**
 * The current text color that is displayed on the text field. (read-only)
 * @discussion The value for this property is set automatically whenever the button state changes. The value may be `nil`.
 */
@property (strong, nonatomic, readonly) UIColor *currentTextColor;

/**
 * The current border color that is displayed on the text field. (read-only)
 * @discussion The value for this property is set automatically whenever the button state changes. The value may be `nil`.
 */
@property (strong, nonatomic, readonly) UIColor *currentBorderColor;

/**
 * The current glow color that is displayed on the text field. (read-only)
 * @discussion The value for this property is set automatically whenever the button state changes. The value may be `nil`.
 */
@property (strong, nonatomic, readonly) UIColor *currentGlowColor;


///---------------------------------------------------------------------------------------
/// @name Managing Validators
///---------------------------------------------------------------------------------------

/** The list of `MVNValidator` objects used to validate the receiver text content. The order of the values in the array isn’t defined. */
@property (strong, nonatomic, readonly) NSArray *validators;

/**
 * Adds a validator to the receiver.
 *
 * @param validator A validator used to check the receiver content.
 *
 * @note This will overwrite existing validators if they are of the same class.
 */
- (void)addValidator:(MVNValidator *)validator;

/**
 * Adds multiple validators to the receiver.
 *
 * @param validators A list of `MVNValidator` objects used to check the receiver content.
 */
- (void)addValidators:(NSArray *)validators;

/**
 * Removes a single validator.
 *
 * @param validator A validator used to check the receiver content.
 */
- (void)removeValidator:(MVNValidator *)validator;

/**
 * Removes a single validator by class name.
 *
 * @param className A validator class name used to check the receiver content.
 */
- (void)removeValidatorWithClassName:(NSString *)className;

/**
 * Removes all validators used to check the receiver content..
 */
- (void)removeAllValidators;

/** A validation rule that defines the behaviour for validators. Default value is set to `MVNValidatorRuleCompositeAnd`. */
@property (assign, nonatomic) MVNValidationRule validationRule;

/** A Boolean that indicates whether the receiver text must be validated during edition. The default value is `NO`. */
@property (assign, nonatomic) BOOL validateDuringEdition;

/** A Boolean that indicates whether invalid characters are allowed during edition. This needs `validateDuringEdition` to be set to `YES`. The default value is `YES`. */
@property (assign, nonatomic) BOOL allowsInvalidTextDuringEdition;

/** A Boolean that indicates whether the text field needs to be filled. The default value is `NO`. */
@property (assign, nonatomic, getter = isRequired) BOOL required;

/**
 * Validates the receiver text against the existing validators.
 *
 * @return `YES` if the receiver text if valid, otherwise `NO`.
 *
 * @see `validators` property for the list of validators.
 * @see `validate:`
 */
- (BOOL)validate;

/**
 * Validates the given text against the existing validators.
 *
 * @param text The text to validate.
 *
 * @return `YES` if the receiver text if valid, otherwise `NO`.
 *
 * @discussion Use this method for validating the text field when its content has not been changed yet (for example in - (BOOL)textField:shouldChangeCharactersInRange:replacementString:)
 *
 * @see `validators` property for the list of validators.
 * @see `validate`
 */
- (BOOL)validate:(NSString *)text;

@end

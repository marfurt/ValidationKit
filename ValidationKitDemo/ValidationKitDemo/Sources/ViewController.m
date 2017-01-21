//
// ValidationKitDemo
//
// Copyright 2015 Nicolas Marfurt. All rights reserved.
//

#import "ViewController.h"
#import <ValidationKit/ValidationKit.h>

static NSString *const PasswordValidationRegex = @"(?=^.{10,}$)(?=.*\\d)(?=.*\\W+)(?![.\\n])(?=.*[A-Z])(?=.*[a-z]).*$"; // >= 10 chars, >= 1 digit, >= 1 not letter nor digit, >= 1 capital letter, >= 1 lowercase letter

#pragma mark - Private Interface

@interface ViewController () <MVNTextFieldDelegate>

@property (weak, nonatomic) IBOutlet MVNTextField *emailField;
@property (weak, nonatomic) IBOutlet MVNTextField *passwordField;
@property (weak, nonatomic) IBOutlet MVNTextField *passwordConfirmationField;
@property (weak, nonatomic) IBOutlet UIButton *validateButton;

#pragma mark - Implementation

@end

@implementation ViewController

#pragma mark View Lifecycle

- (void)viewDidLoad
{
	[super viewDidLoad];

	[self configureTextfields];
}

#pragma mark Validation

- (void)configureTextfields
{
	[self.emailField setTextColor:[UIColor redColor] forState:MVNTextFieldStateInvalid];
	[self.passwordField setBorderColor:[UIColor redColor] forState:MVNTextFieldStateInvalid];
	[self.passwordField setBorderColor:[UIColor redColor] forState:MVNTextFieldStateInvalid];

	[self.emailField addValidator:[MVNValidatorEmail new]];
	self.emailField.required = YES;

	MVNValidatorRegex *passwordValidator = [MVNValidatorRegex validatorWithRegex:PasswordValidationRegex];
	passwordValidator.message = NSLocalizedString(@"Invalid password", nil);
	[self.passwordField addValidator:passwordValidator];
	self.passwordField.required = YES;

	self.passwordConfirmationField.required = YES;
	[self.passwordConfirmationField addValidator:[MVNBlockValidator validatorWithBlock:^BOOL(NSString *aString) {
		return [aString isEqualToString:self.passwordField.text];
	}]];
}

- (IBAction)validate:(id)sender
{
	[self.view mvn_validateTextFields];
}

#pragma mark TextField delegate

- (void)textFieldDidPassValidation:(MVNTextField *)textField
{
	NSLog(@"textfield is valid:\n%@", textField);
}

- (void)textField:(MVNTextField *)textField didFailValidationForValidators:(NSArray *)validators
{
	NSLog(@"textfield is invalid:\n%@", textField);
}

@end

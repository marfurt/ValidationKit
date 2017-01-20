//
// MVNTextFieldPrivateDelegate
//
// Copyright 2015 Nicolas Marfurt. All rights reserved.
//

#import "MVNTextField.h"

/**
 * The `MVNTextFieldPrivateDelegate` class is used internally by the framework to allow to a text field to respond to `UITextFieldDelegate` methods while keeping its delegate.
 *
 * A UITextField cannot be its own delegate, and it is probably better to avoid having an object being its own delegate anyway.
 * If we want to trap text field delegate events to perform additional tasks, we therefore need an additional object as delegate,
 * and having the real text field delegate as this object's delegate.
 */
@interface MVNTextFieldPrivateDelegate : NSObject <UITextFieldDelegate>

@property (weak, nonatomic) MVNTextField *textField;
@property (weak, nonatomic) id<MVNTextFieldDelegate> delegate;

- (id)initWithTextField:(MVNTextField *)aTextField;

@end

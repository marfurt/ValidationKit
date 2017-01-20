//
// MVNTextField
//
// Copyright 2015 Nicolas Marfurt. All rights reserved.
//

#import "MVNTextField.h"
#import <QuartzCore/QuartzCore.h>
#import "MVNTextFieldPrivateDelegate.h"
#import "MVNValidatorNotEmpty.h"

static NSString *const MVNTextFieldContentTypeBackgroundImage = @"MVNTextFieldContentTypeBackgroundImage";
static NSString *const MVNTextFieldContentTypeTextColor       = @"MVNTextFieldContentTypeTextColor";
static NSString *const MVNTextFieldContentTypeBorderColor     = @"MVNTextFieldContentTypeBorderColor";
static NSString *const MVNTextFieldContentTypeGlowColor       = @"MVNTextFieldContentTypeGlowColor";

const CGFloat kDefaultCornerRadius = 6.0f;
const CGFloat kDefaultDxInset      = 8.0f;
const CGFloat kDefaultDyInset      = 2.0f;

const NSTimeInterval MVNTextFieldAnimationDuration = 0.25;

#pragma mark - Private interface

@interface MVNTextField ()

@property (nonatomic, readwrite, getter = isEmpty) BOOL empty;
@property (strong, nonatomic) NSMutableDictionary *statusContent;
@property (strong, nonatomic) NSMutableDictionary *validatorsDictionary;
@property (strong, nonatomic) MVNTextFieldPrivateDelegate *privateDelegate;

@end

#pragma mark - Implementation

@implementation MVNTextField
{
	BOOL _isInitializing;   // Used for UIAppearance to work
	struct {
		unsigned didPassValidation : 1;
		unsigned didFailValidation : 1;
	} _delegateHas;
}

@dynamic delegate;

#pragma mark Initialization

+ (void)initialize
{
	if (self != [MVNTextField class]) {
		return;
	}
	
	// You should write custom UIAppearance rules instead of manually setting the property, to allow to override those rules from the outside;
	// manually setting a property will disable it for apperance usage
	
//    id appearance = [self appearance];
//    [appearance setTextColor:[UIColor blackColor] forState:MVNTextFieldStateNormal];
}

- (id)init
{
	_isInitializing = YES;
	
	if (self = [super init]) {
		[self _commonInit];
	}
	
	_isInitializing = NO;
	
	return self;
}

- (id)initWithFrame:(CGRect)frame
{
	_isInitializing = YES;
	
	if (self = [super initWithFrame:frame]) {
		[self _commonInit];
	}
	
	_isInitializing = NO;
	
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	_isInitializing = YES;
	
	if (self = [super initWithCoder:aDecoder]) {
		[self _commonInit];
	}
	
	_isInitializing = NO;
	
	return self;
}

- (void)_commonInit
{
	_statusContent = [[NSMutableDictionary alloc] init];
	_validatorsDictionary = [[NSMutableDictionary alloc] init];
	
	_valid = YES;
	_empty = YES;
	
	_validationRule = MVNValidationRuleCompositeAnd;
	_allowsInvalidTextDuringEdition = YES;
	_validateDuringEdition = NO;
	_required = NO;
	
	[self initPrivateDelegate];
	
	[self configureViewForHighlight];
	
	// Listen for updates
//    [[NSNotificationCenter defaultCenter] addObserver:_privateValidationDelegate selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:self];
//    [[NSNotificationCenter defaultCenter] addObserver:_privateValidationDelegate selector:@selector(textFieldDidEndEditing:) name:UITextFieldTextDidEndEditingNotification object:self];
	
	[self addTarget:self action:@selector(textFieldTextDidChange) forControlEvents:UIControlEventEditingChanged];
}

#pragma mark Private Delegate

- (void)initPrivateDelegate
{
	_privateDelegate = [[MVNTextFieldPrivateDelegate alloc] initWithTextField:self];
	_privateDelegate.delegate = self.delegate;
	
	[super setDelegate:_privateDelegate];
}

- (void)setDelegate:(id<MVNTextFieldDelegate>)delegate
{
	if (self.privateDelegate.delegate != delegate) {
		self.privateDelegate.delegate = delegate;
		
		[super setDelegate:nil];
		[super setDelegate:self.privateDelegate];
		
		_delegateHas.didPassValidation = [delegate respondsToSelector:@selector(textFieldDidPassValidation:)];
		_delegateHas.didFailValidation = [delegate respondsToSelector:@selector(textField:didFailValidationForValidators:)];
	}
}

- (id<MVNTextFieldDelegate>)delegate
{
	return self.privateDelegate.delegate;
}

#pragma mark Getting Default Values

- (UIColor *)defaultBorderColor
{
	return [UIColor lightGrayColor];
}

#pragma mark Getting Current Values

- (UIColor *)currentTextColor
{
	return self.textColor;
}

- (UIColor *)currentBorderColor
{
	return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (UIColor *)currentGlowColor
{
	return [UIColor colorWithCGColor:self.layer.shadowColor];
}

#pragma mark Setting and Getting the TextField Appearance

- (UIImage *)backgroundImageForState:(MVNTextFieldState)state
{
	return [self normalContentForState:state type:MVNTextFieldContentTypeBackgroundImage];
}

- (void)setBackgroundImage:(UIImage *)anImage forState:(MVNTextFieldState)state
{
	[self setContent:anImage forState:state type:MVNTextFieldContentTypeBackgroundImage];
}

- (UIColor *)textColorForState:(MVNTextFieldState)state
{
	return [self normalContentForState:state type:MVNTextFieldContentTypeTextColor];
}

- (void)setTextColor:(UIColor *)color forState:(MVNTextFieldState)state
{
	[self setContent:color forState:state type:MVNTextFieldContentTypeTextColor];
}

- (UIColor *)borderColorForState:(MVNTextFieldState)state
{
	return [self normalContentForState:state type:MVNTextFieldContentTypeBorderColor];
}

- (void)setBorderColor:(UIColor *)color forState:(MVNTextFieldState)state
{
	[self setContent:color forState:state type:MVNTextFieldContentTypeBorderColor];
}

- (UIColor *)glowColorForState:(MVNTextFieldState)state
{
	// If there is no glow color for the given state, return nil instead of the color in the normal state
	return [self contentForState:state type:MVNTextFieldContentTypeGlowColor];
}

- (void)setGlowColor:(UIColor *)color forState:(MVNTextFieldState)state
{
	[self setContent:color forState:state type:MVNTextFieldContentTypeGlowColor];
}

- (id)contentForState:(MVNTextFieldState)state type:(NSString *)type
{
	return [[self.statusContent objectForKey:type] objectForKey:@(state)];
}

- (id)normalContentForState:(MVNTextFieldState)state type:(NSString *)type
{
	return [self contentForState:state type:type] ?: [self contentForState:MVNTextFieldStateNormal type:type];
}

- (void)setContent:(id)value forState:(MVNTextFieldState)state type:(NSString *)type
{
	NSMutableDictionary *typeContent = [self.statusContent objectForKey:type];
	
	if (!typeContent) {
		typeContent = [[NSMutableDictionary alloc] init];
		[self.statusContent setObject:typeContent forKey:type];
	}
	
	NSNumber *key = @(state);
	if (value) {
		[typeContent setObject:value forKey:key];
	}
	else {
		[typeContent removeObjectForKey:key];
	}
	
	[self updateContentAnimated:NO];
}

- (void)updateContentAnimated:(BOOL)animated
{
	MVNTextFieldState state = MVNTextFieldStateNormal;
	
	if ((self.textFieldState & MVNTextFieldStateInvalid) == MVNTextFieldStateInvalid) {
		state = MVNTextFieldStateInvalid;
	}
	else if ((self.textFieldState & MVNTextFieldStateHighlighted) == MVNTextFieldStateHighlighted) {
		state = MVNTextFieldStateHighlighted;
	}
	else if ((self.textFieldState & MVNTextFieldStateEmpty) == MVNTextFieldStateEmpty) {
		state = MVNTextFieldStateEmpty;
	}
	
	UIImage *backgroundImage = [self backgroundImageForState:state];
	UIColor *textColor = [self textColorForState:state];
	CGColorRef borderColor = [self borderColorForState:state].CGColor ?: [self defaultBorderColor].CGColor;
	CGColorRef glowColor = [self glowColorForState:state].CGColor ?: NULL;
	CGFloat glowOpacity = (glowColor == NULL ? 0.0f : 1.0f);
	
	if (animated) {
		// Prevent layer from snapping back to original value
		CGColorRef fromBorderColor = self.layer.borderColor;
		CGColorRef fromShadowColor = self.layer.shadowColor;
		CGFloat fromShadowOpacity = self.layer.shadowOpacity;
		
		self.textColor = textColor;
		
		if (!backgroundImage) {
			self.background = nil;
			self.layer.borderWidth = 1.0f;
			self.layer.borderColor = borderColor;
			self.layer.shadowColor = glowColor;
			self.layer.shadowOpacity = glowOpacity;
		}
		else {
			self.background = backgroundImage;
			self.layer.borderWidth = 0.0f;
		}
		
		CAAnimation *borderAnimation = [self animationWithKeyPath:@"borderColor" fromValue:(__bridge id)fromBorderColor toValue:(__bridge id)borderColor];
		CAAnimation *shadowColorAnimation = [self animationWithKeyPath:@"shadowColor" fromValue:(__bridge id)fromShadowColor toValue:(__bridge id)glowColor];
		CAAnimation *shadowOpacityAnimation = [self animationWithKeyPath:@"shadowOpacity" fromValue:@(fromShadowOpacity) toValue:@(glowOpacity)];

		[self animateGroupAnimations:@[ borderAnimation, shadowColorAnimation, shadowOpacityAnimation ]];
	}
	else {
		self.textColor = textColor;
		
		if (!backgroundImage) {
			self.background = nil;
			self.layer.borderWidth = 1.0f;
			self.layer.borderColor = borderColor;
			self.layer.shadowColor = glowColor;
			self.layer.shadowOpacity = glowOpacity;
		}
		else {
			self.background = backgroundImage;
			self.layer.borderWidth = 0.0f;
		}
	}
}

#pragma mark TextField State

- (void)setValid:(BOOL)valid
{
	if (valid != _valid) {
		_valid = valid;
		[self updateContentAnimated:NO];
	}
}

- (void)setEmpty:(BOOL)empty
{
	if (empty != _empty) {
		_empty = empty;
		[self updateContentAnimated:NO];
	}
}

- (MVNTextFieldState)textFieldState
{
	MVNTextFieldState state = MVNTextFieldStateNormal;
	
	if (self.isHighlighted)	state |= MVNTextFieldStateHighlighted;
	if (!self.isValid)      state |= MVNTextFieldStateInvalid;
	if (self.isEmpty)       state |= MVNTextFieldStateEmpty;
	
	return state;
}

- (void)setHighlighted:(BOOL)highlighted
{
	[self setHighlighted:highlighted animated:NO];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
	BOOL stateDidChange = (highlighted != self.highlighted);
	
	[super setHighlighted:highlighted];
	
	if (stateDidChange) {
		[self updateContentAnimated:animated];
	}
}

#pragma mark Managing the Responder Chain

- (BOOL)becomeFirstResponder
{
	BOOL becameFirstResponder = [super becomeFirstResponder];
	
	if (becameFirstResponder) {
		[self setHighlighted:YES animated:YES];
	}
	
	return becameFirstResponder;
}

- (BOOL)resignFirstResponder
{
	BOOL resigning = [super resignFirstResponder];
	
	if (resigning) {
		[self setHighlighted:NO animated:YES];
	}
	
	return resigning;
}

#pragma mark Drawing

- (void)setBorderStyle:(UITextBorderStyle)borderStyle
{
	[super setBorderStyle:borderStyle];
	
	if (borderStyle == UITextBorderStyleRoundedRect) {
		self.layer.cornerRadius = 8.0f;
	}
	else if (borderStyle == UITextBorderStyleLine || borderStyle == UITextBorderStyleBezel) {
		self.layer.cornerRadius = 0.0f;
	}
	else  {
		self.layer.cornerRadius = kDefaultCornerRadius;
	}
}

- (void)configureViewForHighlight
{
	self.borderStyle = UITextBorderStyleNone;
	self.clipsToBounds = YES;
	
	if (!self.backgroundColor) {
		self.backgroundColor = [UIColor whiteColor];
	}
	
	self.layer.masksToBounds = NO;
	self.layer.cornerRadius = kDefaultCornerRadius;
	self.layer.borderWidth = 1.0f;
	
	self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:4.f].CGPath;
	self.layer.shadowOpacity = 0.0f;
	self.layer.shadowOffset = CGSizeZero;
	self.layer.shadowRadius = 5.0f;
	self.layer.shouldRasterize = YES;
	self.layer.rasterizationScale = [UIScreen mainScreen].scale;
	
	[self updateContentAnimated:NO];
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
	return CGRectInset(bounds, kDefaultDxInset, kDefaultDyInset);
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
	CGRect rect = [super editingRectForBounds:bounds];
	CGRect editingRect = CGRectInset(bounds, kDefaultDxInset, kDefaultDyInset);
	
	// Keep the original Dx inset so that the clear button is not coverd by the text
	CGFloat dx = kDefaultDxInset - CGRectGetMinX(rect);
	if (dx > 0) {
		editingRect.origin.x = dx;
		editingRect.size.width = CGRectGetWidth(rect) - dx;
	}
	else {
		editingRect.origin.x = CGRectGetMinX(rect);
		editingRect.size.width = CGRectGetWidth(rect);
	}
	
	return editingRect;
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
	return CGRectInset(bounds, kDefaultDxInset, kDefaultDyInset);
}

#pragma mark Animation

- (CAAnimation *)animationWithKeyPath:(NSString *)keyPath fromValue:(id)fromValue toValue:(id)toValue
{
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
	animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
	animation.removedOnCompletion = NO;
	animation.fillMode = kCAFillModeForwards;
	animation.duration = MVNTextFieldAnimationDuration;
	animation.fromValue = fromValue;
	//animation.toValue = toValue;  // Already set before animation
	
	return animation;
}

- (void)animateGroupAnimations:(NSArray *)animations
{
	CAAnimationGroup *group = [CAAnimationGroup animation];
	group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
	group.removedOnCompletion = NO;
	group.fillMode = kCAFillModeForwards;
	group.duration = MVNTextFieldAnimationDuration;
	group.animations = animations;
	
	[self.layer addAnimation:group forKey:nil];
}

#pragma mark Responding to Text Changes

- (void)textFieldTextDidChange
{
	self.empty = ([self.text length] == 0);
	
	// See MVNTextFieldValidationDelegate for validation
}

#pragma mark Accessing Validators

- (NSArray *)validators
{
	return [self.validatorsDictionary allValues];
}

- (void)addValidator:(MVNValidator *)validator
{
	if (!validator) {
		return;
	}
	
	NSString *key = NSStringFromClass([validator class]);
	
	self.validatorsDictionary[key] = validator;
}

- (void)addValidators:(NSArray *)validators {
	for(MVNValidator *oneValidator in validators) {
		[self addValidator:oneValidator];
	}
}

- (void)removeValidator:(MVNValidator *)validator
{
	NSString *name = NSStringFromClass([validator class]);
	[self removeValidatorWithClassName:name];
}

- (void)removeValidatorWithClassName:(NSString *)name
{
	[self.validatorsDictionary removeObjectForKey:name];
}

- (void)removeAllValidators
{
	[self.validatorsDictionary removeAllObjects];
}

#pragma mark Validating Content

- (BOOL)validate
{
	return [self validate:self.text];
}

- (BOOL)validate:(NSString *)text
{
	__block BOOL isValid = YES;
	
	if (!self.isRequired && text.length == 0) {
		return YES;
	}
	
	if (self.isRequired && ![self.validatorsDictionary objectForKey:NSStringFromClass([MVNValidatorNotEmpty class])]) {
		[self addValidator:[MVNValidatorNotEmpty new]];
	}
	
	NSMutableArray *failedValidators = [[NSMutableArray alloc] initWithCapacity:[self.validators count]];

	[self.validators enumerateObjectsUsingBlock:^(MVNValidator *validator, NSUInteger index, __unused BOOL *stop) {
		BOOL stepValid = [validator validate:text];
		
		if (index == 0) {
			isValid = stepValid;
		}
		else if (self.validationRule == MVNValidationRuleCompositeAnd) {
			isValid = isValid && stepValid;
		}
		else {  // == MVNValidationRuleCompositeOr
			isValid = isValid || stepValid;
		}
		
		if (!stepValid) {
			[failedValidators addObject:validator];
		}
	}];
	
	self.valid = isValid;
	
	if (isValid) {
		if (_delegateHas.didPassValidation) {
			[self.delegate textFieldDidPassValidation:self];
		}
	}
	else {
		if (_delegateHas.didFailValidation) {
			[self.delegate textField:self didFailValidationForValidators:failedValidators];
		}
	}
	
	return isValid;
}

@end

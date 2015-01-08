//
//  KMAuthView.m
//  Test
//
//  Created by Wingstech Solutions Pvt. Ltd. on 15/07/14.
//  Copyright (c) 2014 Wingstech Solutions Pvt. Ltd. All rights reserved.
//

#import "KMAuthView.h"
#import "AppImport.h"
#import "KMFloatingTextField+KMKit.h"

@interface KMAuthView () <UITextFieldDelegate>

@property (nonatomic, strong) KMFloatingTextField *txtUsername;
@property (nonatomic, strong) KMFloatingTextField *txtPassword;
@property (nonatomic, strong) KMCheckBox *rememberChkBox;


@property (assign, nonatomic) CGRect keyboardFrame;

@property BOOL valid;

@end

@implementation KMAuthView

- (BOOL)isValidDetails {
    return _valid;
}

- (void)configure {
    
    _valid = NO;
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    self.backgroundColor = [UIColor colorFromHexCode:APP_SECONDARY_COLOR];
    
    [[self scrollContainer] addSubview:[self txtUsername]];
    [[self scrollContainer] addSubview:[self txtPassword]];
    [[self scrollContainer] addSubview:[self loginButton]];
    
    UILabel *lblOr = [[UILabel alloc] initWithFrame:CGRectMake(0, MaxY([self loginButton]) + 2, self.frame.size.width, 30)];
    [lblOr setText:@"Don't have an account yet ?"];
    [lblOr setTextColor:[UIColor grayColor]];
    
    [lblOr setTextAlignment:NSTextAlignmentCenter];
    //[[self scrollContainer] addSubview:lblOr];
    
    [[self scrollContainer] addSubview:[self signUpButton]];
    [[self scrollContainer] addSubview:[self forgotPassword]];
}

- (NSArray *)fields {
    return @[[self txtUsername], [self txtPassword]];
}

- (KMFloatingTextField *)txtUsername {
    if (!_txtUsername) {
        _txtUsername = [[KMFloatingTextField alloc] initWithFrame:CGRectMake(60, 5, self.frame.size.width-60, 40)];
        _txtUsername.placeholder = @"Email";
        _txtUsername.placeholderTextColor = [UIColor blackColor];
        _txtUsername.floatingLabelActiveTextColor = [UIColor blackColor];
        _txtUsername.floatingLabelTextColor = [UIColor blackColor];
        _txtUsername.textAlignment = NSTextAlignmentLeft;
        _txtUsername.autocorrectionType = UITextAutocorrectionTypeNo;
        _txtUsername.delegate = self;
        _txtUsername.shouldShowFloatingLabel = NO;
        //_txtUsername.layer.borderWidth = 1.0f;
        
        _txtUsername.tag = 1001;
        _txtUsername.textColor = [UIColor blackColor];
        _txtUsername.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
        
        UIView *emailView = [[UIView alloc] initWithFrame:CGRectMake(-30, 10, 60, 20)];
        UIImageView *emailImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 35, 20)];
        [emailImage setImage:[UIImage imageNamed:@"email-icon.png"]];
        [emailView addSubview:emailImage];
        [_txtUsername addSubview:emailView];
    }
    
    return _txtUsername;
}

- (KMFloatingTextField *)txtPassword {
    if (!_txtPassword) {
        _txtPassword = [[KMFloatingTextField alloc] initWithFrame:CGRectMake(60, MaxY([self txtUsername]) + 10, self.frame.size.width-60, 40)];
        _txtPassword.placeholder = @"Password";
        _txtPassword.secureTextEntry = YES;
        
        _txtPassword.placeholderTextColor = [UIColor blackColor];
        _txtPassword.floatingLabelActiveTextColor = [UIColor blackColor];
        _txtPassword.floatingLabelTextColor = [UIColor blackColor];
        _txtPassword.textAlignment = NSTextAlignmentLeft;
        _txtPassword.autocorrectionType = UITextAutocorrectionTypeNo;
        _txtPassword.delegate = self;
        _txtPassword.tag = 1002;
        _txtPassword.textColor = [UIColor blackColor];
        _txtPassword.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
        _txtPassword.shouldShowFloatingLabel = NO;
        //[_txtPassword addLineView];
        
        
        UIView *passwordView = [[UIView alloc] initWithFrame:CGRectMake(-30, 10, 60, 20)];
        UIImageView *passwordImage = [[UIImageView alloc] initWithFrame:CGRectMake(7.5, 0, 20, 20)];
        [passwordImage setImage:[UIImage imageNamed:@"password-icon.png"]];
        [passwordView addSubview:passwordImage];
        [_txtPassword addSubview:passwordView];
        
    }
    
    return _txtPassword;
}

- (KMCheckBox *)rememberChkBox {
    if (!_rememberChkBox) {
        _rememberChkBox = [[KMCheckBox alloc] initWithTitle:@"Remember Me" andHeight:30];
        [_rememberChkBox setCheckAlignment:KMCheckboxAlignmentLeft];
        [_rememberChkBox.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [_rememberChkBox.titleLabel setTextColor:[UIColor blackColor]];
        [_rememberChkBox setStrokeColor:[UIColor blackColor]];
        _rememberChkBox.frame = CGRectMake(40, MaxY([self txtPassword]) + 25 + 20, self.frame.size.width-80, 20);
        [_rememberChkBox addObserver:self forKeyPath:@"checkState" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _rememberChkBox;
}

- (NSDictionary *)userDetails {
    return @{@"email_address": [self txtUsername].text, @"password":[self txtPassword].text};
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"checkState"]) {
        keepMeSignedIn = ([self rememberChkBox].checkState == KMCheckboxStateChecked)?YES:NO;
    }
}

- (BOOL)isRemembered {
    return [self rememberChkBox].checkState == KMCheckboxStateChecked;
}

- (UIImage *)buttonNormalImage {
    FAKIcon *rightMark = [FAKIonIcons ios7CheckmarkOutlineIconWithSize:30.0f];
    [rightMark addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:APP_SECONDARY_COLOR]];
    UIImage *normalRightMark = [rightMark imageWithSize:CGSizeMake(30.0f, 30.0f)];
    
    return normalRightMark;
}

- (UIImage *)buttonHighlightedImage {
    FAKIcon *rightMark = [FAKIonIcons ios7CheckmarkOutlineIconWithSize:30.0f];
    [rightMark addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]];
    UIImage *highlightedRightMark = [rightMark imageWithSize:CGSizeMake(30.0f, 30.0f)];
    return highlightedRightMark;
}

- (KMButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [[KMButton alloc] initWithFrame:CGRectMake(20, MaxY([self txtPassword]) + 50 , self.frame.size.width-40, 70)];
        _loginButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
        _loginButton.buttonTitle = @"SIGN IN";
        [_loginButton setTitleColor:[UIColor colorFromHexCode:APP_SECONDARY_COLOR] forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(loginUser:) forControlEvents:UIControlEventTouchUpInside];
        _loginButton.actionBlock = ^(KMButton *button){
            
        };
    }
    return _loginButton;
}

- (KMButton *)signUpButton {
    if (!_signUpButton) {
        _signUpButton = [[KMButton alloc] initWithFrame:CGRectMake(20, MaxY([self loginButton]) + 60, self.frame.size.width-40, 30)];
        _signUpButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        _signUpButton.buttonTitle = @"SIGN UP";
        [_signUpButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_signUpButton setTitleColor:[UIColor colorWithWhite:0.328 alpha:1.000] forState:UIControlStateHighlighted];
        [_signUpButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorFromHexCode:APP_SECONDARY_COLOR] cornerRadius:0.0f] forState:UIControlStateNormal];
        [_signUpButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorFromHexCode:APP_SECONDARY_COLOR] cornerRadius:0.0f] forState:UIControlStateHighlighted];
        
    }
    return _signUpButton;
}

- (KMButton *)forgotPassword {
    if (!_forgotPassword) {
        _forgotPassword = [[KMButton alloc] initWithFrame:CGRectMake(35, MaxY(_signUpButton)+ 15, self.frame.size.width-70, 20)];
        [_forgotPassword.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
        _forgotPassword.buttonTitle = @"Forgot Your Password ?";
        [_forgotPassword invertBackgroundImage];
        [_forgotPassword setBackgroundImage:[UIImage imageWithColor:[UIColor colorFromHexCode:APP_SECONDARY_COLOR] cornerRadius:0.0f] forState:UIControlStateNormal];
        [_forgotPassword setBackgroundImage:[UIImage imageWithColor:[UIColor colorFromHexCode:APP_SECONDARY_COLOR] cornerRadius:0.0f] forState:UIControlStateHighlighted];
        [_forgotPassword setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_forgotPassword setTitleColor:[UIColor colorWithWhite:0.328 alpha:1.000] forState:UIControlStateHighlighted];
    }
    return _forgotPassword;
}

- (void)setForgotBlock:(ForgotActionBlock)forgotBlock
{
    _forgotBlock = forgotBlock;
    [self forgotPassword].actionBlock = _forgotBlock;
}

- (void)setLoginBlock:(LoginActionBlock)loginBlock {
    _loginBlock = loginBlock;
    [self loginButton].actionBlock = _loginBlock;
}

- (void)setSignupBlock:(RegisterActionBlock)signupBlock {
    _signupBlock = signupBlock;
    [self signUpButton].actionBlock = _signupBlock;
}

- (void)loginUser:(id)sender {
    [self loginButton].enabled = NO;
    
    NSString *username = [self txtUsername].text;
    NSString *password = [self txtPassword].text;
    
    if (keepMeSignedIn) {
        NSDictionary *credentials = @{@"Username": username, @"Password": password};
        UDO_Set(credentials, kRememberKey);
    }
    else {
        UDO_Set(nil, kRememberKey);
    }
    
    BOOL invalid = [self checkCredentials:username password:password usernameAsEmail:NO];
    
    _valid = (invalid == FALSE);
    
    if (_loginBlock && !invalid) {
        _loginBlock([self loginButton]);
    }
    else {
        [self loginButton].enabled = YES;
    }
}

- (BOOL)shakeView:(UIView *)view {
    return [[Util sharedInstance] addShakeAnimationForView:view withDuration:kAFViewShakerDefaultDuration];
}

- (BOOL)checkCredentials:(NSString *)username password:(NSString *)password usernameAsEmail:(BOOL)isEmail {
    
    BOOL Invalid = NO;
    
    Invalid = [username isNilOrEmpty]?[self shakeView:[self txtUsername]]:isEmail?![username isValidEmailWithStricterFilter:NO]?[self shakeView:[self txtUsername]]:NO:NO;
    Invalid = Invalid?([password isNilOrEmpty]?([self shakeView:[self txtPassword]]?YES:YES):YES):([password isNilOrEmpty]?([self shakeView:[self txtPassword]]?YES:YES):NO);
    
    return Invalid;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [[self txtUsername] resignFirstResponder];
    [[self txtPassword] resignFirstResponder];
    
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    CGRect frameToScroll = [[self scrollContainer] convertRect:textField.frame fromView:textField.superview];
    [[self scrollContainer] scrollRectToVisible:frameToScroll animated:YES];
}

- (void)clearFields {
    [self txtUsername].text = @"";
    [self txtPassword].text = @"";
    _rememberChkBox.checkState = KMCheckboxStateUnchecked;
}

- (void)loginFromSavedDetails {
    NSDictionary *credentials = UDO(kRememberKey);
    _txtUsername.text = [NSString stringWithFormat:@"\t%@",[credentials objectForKey:@"Username"]];
    _txtPassword.text = [NSString stringWithFormat:@"\t%@",[credentials objectForKey:@"Password"]];
    
    [self loginUser:[self loginButton]];
}

- (void)loginWithUsername:(NSString *)username andPassword:(NSString *)password {
    _txtUsername.text = [NSString stringWithFormat:@"\t%@",username];
    _txtPassword.text = [NSString stringWithFormat:@"\t%@",password];
    
    [self loginUser:[self loginButton]];
}

#pragma mark - Keyboard methods

- (void)scrollRectToVisible:(CGRect)rect animated:(BOOL)animated {
    
    if (rect.size.height > self.keyboardFrame.origin.y) {
        rect.size.height = self.keyboardFrame.origin.y;
    }
    
    [[self scrollContainer] km_ScrollRectToVisibleCenteredOn:rect animated:YES];
}

- (void)keyboardAppearedWithNotification:(NSNotification *)notification andFields:(NSArray *)fields {
    CGRect keyboardEndFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.keyboardFrame = [[self scrollContainer].superview convertRect:keyboardEndFrame fromView:nil];
    UIViewAnimationCurve curve = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
    UIViewAnimationOptions options = (curve << 16) | UIViewAnimationOptionBeginFromCurrentState;
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect newFrame = [self scrollContainer].frame;
    newFrame.size.height = self.keyboardFrame.origin.y;
    
    [UIView animateWithDuration:duration delay:0.0 options:options animations:^{
        [self scrollContainer].frame = newFrame;
    } completion:^(BOOL finished) {
        NSUInteger indexOfActiveTextFiled = [fields indexOfObjectPassingTest:^BOOL(UITextField *textField, NSUInteger idx, BOOL* stop) {
            return textField.isFirstResponder;
        }];
        if (indexOfActiveTextFiled != NSNotFound) {
            UITextField *textField = fields[indexOfActiveTextFiled];
            CGRect frameToScroll = [[self scrollContainer] convertRect:textField.frame fromView:textField.superview];
            [self scrollRectToVisible:frameToScroll animated:YES];
        }
    }];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
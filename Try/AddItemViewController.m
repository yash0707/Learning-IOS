//
//  AddItemViewController.m
//  Try
//
//  Created by Admin on 11/02/19.
//  Copyright © 2019 Personal. All rights reserved.
//

#import "AddItemViewController.h"

@interface AddItemViewController ()

@property (nonatomic,strong) UITextField *itemTextField;
@property (nonatomic,strong) UIButton *saveButton;
@property (nonatomic,strong) UIButton *cancelButton;
@property (nonatomic,strong) UITapGestureRecognizer *tapRecognizer;

@end

@implementation AddItemViewController

- (instancetype)init{
    self = [super init];
    if(self){
        [self parametersInit];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [notificationCenter addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    _tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapAnywhere:)];
    
    
    [self.view addSubview:_cancelButton];
    [self.view addSubview:_saveButton];
    [self.view addSubview:_itemTextField];
}

-(void) parametersInit{
    _itemTextField = [[UITextField alloc] init];
    _itemTextField.backgroundColor = [UIColor brownColor];
    
    _saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _saveButton.backgroundColor = [UIColor yellowColor];
    [_saveButton setTitle:@"Save" forState:UIControlStateNormal];
    [_saveButton addTarget:self action:@selector(saveButtonMethod) forControlEvents:UIControlEventTouchUpInside];

    _cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _cancelButton.backgroundColor = [UIColor cyanColor];
    [_cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [_cancelButton addTarget:self action:@selector(cancelButtonMethod) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _itemTextField.frame = CGRectMake(80, 150.0, 160.0, 40.0);
    _saveButton.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    _cancelButton.frame = CGRectMake(80.0, 260.0, 160.0, 40.0);
}

#pragma mark - private methods

- (void) saveButtonMethod{
    NSLog(@"Inside saveButtonMethod");
    NSString *textFieldData = _itemTextField.text;
    NSDictionary *dataDictionary = @{@"item":textFieldData};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notify1" object:self userInfo:dataDictionary];
}

- (void) cancelButtonMethod{
    NSLog(@"Inside CancelButtonMethod");
    [[self navigationController] popViewControllerAnimated:YES];
    
}

-(void) keyboardWillShow:(NSNotification *) note {
    [self.view addGestureRecognizer:_tapRecognizer];
}

-(void) keyboardWillHide:(NSNotification *) note
{
    [self.view removeGestureRecognizer:_tapRecognizer];
}

-(void)didTapAnywhere: (UITapGestureRecognizer*) recognizer {
    [_itemTextField resignFirstResponder];
}

@end

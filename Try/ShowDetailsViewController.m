//
//  ShowDetailsViewController.m
//  Try
//
//  Created by Admin on 10/02/19.
//  Copyright © 2019 Personal. All rights reserved.
//

#import "ShowDetailsViewController.h"

@interface ShowDetailsViewController ()

@property (nonatomic,strong) UITextField *itemTextField;
@property (nonatomic,strong) UIButton *saveButton;
@property (nonatomic,strong) UIButton *cancelButton;
@property (nonatomic,strong) UITapGestureRecognizer *tapRecognizer;

@end

@implementation ShowDetailsViewController

- (instancetype) init {
    if(self = [super init]) {
        NSLog(@"inside init of show detail.");
        [self parametersInit];
    }
    return self;
}

-(void) parametersInit{
    _itemTextField = [[UITextField alloc] init];
    _itemTextField.backgroundColor = [UIColor brownColor];
    
    _saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _saveButton.backgroundColor = [UIColor yellowColor];
    [_saveButton setTitle:@"Save" forState:UIControlStateNormal];
    [_saveButton addTarget:self action:@selector(saveButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    //    [_saveButton targetForAction:@selector(saveButtonMethod) withSender:self];
    
    _cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _cancelButton.backgroundColor = [UIColor cyanColor];
    [_cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    // NSString *tempString = @"Checking the passing of parameters in selectors";
    [_cancelButton addTarget:self action:@selector(cancelButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - View Controller LifeCycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"Inside ShowDetail");
    NSLog(@"Received value is %@",_itemDetail);
    NSLog(@"Received Index IS: %@",_indexPathOfElement);
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [notificationCenter addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    _tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapAnywhere:)];
    
    self.view.backgroundColor = [UIColor redColor];
    _itemTextField.text = _itemDetail;
    [self.view addSubview:_cancelButton];
    [self.view addSubview:_saveButton];
    [self.view addSubview:_itemTextField];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _itemTextField.frame = CGRectMake(80, 150.0, 160.0, 40.0);
    _saveButton.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    _cancelButton.frame = CGRectMake(80.0, 260.0, 160.0, 40.0);
}

#pragma mark - private methods
- (void) saveButtonMethod{
    NSLog(@"Inside SDsaveButtonMethod");
    NSString *itemToSentBack = _itemTextField.text;
    if ([self.delegate respondsToSelector:@selector(getUpdatedDataFrom:whereDataIs:atIndex:)]) {
        [self.delegate getUpdatedDataFrom:self whereDataIs:itemToSentBack atIndex:_indexPathOfElement];

    }
    [[self navigationController] popViewControllerAnimated:YES];
    
}
- (void) cancelButtonMethod{
    //    NSLog(@"string is: %@",str);
    NSLog(@"Inside SDCancelButtonMethod");
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

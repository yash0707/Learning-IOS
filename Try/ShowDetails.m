//
//  ShowDetails.m
//  Try
//
//  Created by Admin on 10/02/19.
//  Copyright © 2019 Personal. All rights reserved.
//

#import "ShowDetails.h"

@interface ShowDetails ()

@property (nonatomic,strong) UITextField *itemTextField;
@property (nonatomic,strong) UIButton *saveButton;
@property (nonatomic,strong) UIButton *cancelButton;

@end

@implementation ShowDetails

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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"Inside ShowDetail");
    NSLog(@"Received value is %@",_itemDetail);
    NSLog(@"Received Index IS: %ld",_indexItem);
    
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

- (void) saveButtonMethod{
    NSLog(@"Inside SDsaveButtonMethod");
    NSString *itemToSentBack = _itemTextField.text;
    [self.delegate getUpdatedDataFrom:self whereDataIs:itemToSentBack atIndex:_indexItem];
    [[self navigationController] popViewControllerAnimated:YES];
    
}
- (void) cancelButtonMethod{
    //    NSLog(@"string is: %@",str);
    NSLog(@"Inside SDCancelButtonMethod");
    [[self navigationController] popViewControllerAnimated:YES];
    
}

@end

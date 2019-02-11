//
//  AddItemViewController.m
//  Try
//
//  Created by Admin on 11/02/19.
//  Copyright © 2019 Personal. All rights reserved.
//

#import "AddItemViewController.h"

@interface AddItemViewController ()
//@property (weak, nonatomic) IBOutlet UITextField *itemEditbox;

@end

@implementation AddItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
- (IBAction)addButton:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notify1" object:self];
    
}
- (IBAction)cancelButton:(id)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notify2" object:self];

}

@end

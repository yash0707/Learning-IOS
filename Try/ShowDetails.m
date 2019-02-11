//
//  ShowDetails.m
//  Try
//
//  Created by Admin on 10/02/19.
//  Copyright © 2019 Personal. All rights reserved.
//

#import "ShowDetails.h"

@interface ShowDetails ()
@property (weak, nonatomic) IBOutlet UITextField *textLabel;

@end

@implementation ShowDetails

- (instancetype) init {
    if(self = [super init]) {
        NSLog(@"inside init of show detail.");
    }
    return self;
}

- (IBAction)saveButton:(id)sender {
    NSString *itemToSentBack = self.textLabel.text;
    [self.delegate getUpdatedDataFrom:self whereDataIs:itemToSentBack];
}
- (IBAction)cancelButton:(id)sender {
    NSString *itemToSentBack = _itemDetail;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"Inside ShowDetail");
    NSLog(@"Received value is %@",_itemDetail);
}

- (void)viewDidAppear:(BOOL)animated{
    NSLog(@"InViewDidAppear Value Is: %@",_itemDetail);
}



@end

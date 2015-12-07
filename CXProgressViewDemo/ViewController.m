//
//  ViewController.m
//  CXProgressViewDemo
//
//  Created by fizz on 15/12/4.
//  Copyright © 2015年 chaox. All rights reserved.
//

#import "ViewController.h"
#import "CXProgress.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
}

- (IBAction)pointAction:(id)sender {
    
    [CXProgress showWithType:CXProgressTypeFullPoint];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [CXProgress dismiss];
    });
}

- (IBAction)turnAction:(id)sender {
    
    [CXProgress showWithType:CXProgressTypeFullTurn];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [CXProgress dismiss];
    });
}

- (IBAction)catchAction:(id)sender {
    
    [CXProgress showWithType:CXProgressTypeFullCatch];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [CXProgress dismiss];
    });
}


- (IBAction)basicPoint:(id)sender {
    
    [CXProgress showWithType:CXProgressTypeBasicPoint];
    
}

- (IBAction)basicTurn:(id)sender {
    
    [CXProgress showWithType:CXProgressTypeBasicTurn];

}

- (IBAction)basicCatch:(id)sender {
    
    [CXProgress showWithType:CXProgressTypeBasicCatch];
}

- (IBAction)disMiss:(id)sender {
    
    [CXProgress dismiss];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

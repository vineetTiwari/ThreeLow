//
//  ViewController.h
//  Threelow
//
//  Created by Vineet Tiwari on 2015-05-12.
//  Copyright (c) 2015 vinny.co. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIButton *dice1;

@property (weak, nonatomic) IBOutlet UIButton *dice2;

@property (weak, nonatomic) IBOutlet UIButton *dice3;

@property (weak, nonatomic) IBOutlet UIButton *dice4;

@property (weak, nonatomic) IBOutlet UIButton *dice5;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (nonatomic) NSMutableSet *diceHeld;

- (IBAction)rollDice:(id)sender;

- (IBAction)resetDice:(id)sender;

- (IBAction)holdDice:(id)sender;



@end


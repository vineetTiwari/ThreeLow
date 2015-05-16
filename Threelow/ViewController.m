//
//  ViewController.m
//  Threelow
//
//  Created by Vineet Tiwari on 2015-05-12.
//  Copyright (c) 2015 vinny.co. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic) NSSet *dice;
@property (nonatomic) NSDictionary *buttonAndDiceAssociation;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.diceHeld = [NSMutableSet setWithCapacity:5];

//   NSArray *buttons = [NSArray arrayWithObjects:self.dice1,self.dice2,self.dice3,self.dice4,self.dice5,nil];
//  [buttons enumerateObjectsUsingBlock:^(UIButton *aButton, NSUInteger idx, BOOL *stop) {
//    [aButton titleLabel].text = @"sdsd";
//  }];

}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (id)rollDice {

  int randomNumber = arc4random_uniform(6);

  NSArray *possibleOutcomes = @[@"⚀", @"⚁", @"⚂", @"⚃", @"⚄", @"⚅"];
  NSString *dieValue = [possibleOutcomes objectAtIndex:randomNumber];

  NSDictionary *die = @{@"symbol":dieValue,@"value":@(randomNumber+1)};

  return die;
}

- (IBAction)rollDice:(id)sender {

  self.buttonAndDiceAssociation = nil;
  NSMutableDictionary *tempAssociation = [NSMutableDictionary dictionaryWithCapacity:5];

  NSArray *buttons = [NSArray arrayWithObjects:self.dice1,self.dice2,self.dice3,self.dice4,self.dice5,nil];

  NSMutableArray *unSelectedButtons = [[NSMutableArray alloc] init];

  [buttons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    if ([self.diceHeld containsObject:obj] == NO)
    {
      [unSelectedButtons addObject:obj];
    }
  }];


  [unSelectedButtons enumerateObjectsUsingBlock:^(UIButton *aButton, NSUInteger idx, BOOL *stop) {
    id die = [self rollDice];

    aButton.titleLabel.text = [die objectForKey:@"symbol"];
    [tempAssociation setObject:die forKey:[NSString stringWithFormat:@"%ld",aButton.tag]];

    //aButton.tag = [[die objectForKey:@"value"] integerValue];
  }];

  self.buttonAndDiceAssociation = tempAssociation;

  NSLog(@"Mapping:%@",tempAssociation);
  //self.buttonToDieMap = @{:die1};

}

- (void)score {

  __block int score = 0;
  [self.diceHeld enumerateObjectsUsingBlock:^(UIButton *aButton, BOOL *stop) {
    NSString  *key = [NSString stringWithFormat:@"%ld",aButton.tag];
    id die = [self.buttonAndDiceAssociation objectForKey:key];
    int value = [[die objectForKey:@"value"] intValue];
    if (value == 3) {
      value = 0;
    }
    score = score + value;
  }];
  self.scoreLabel.text = [NSString stringWithFormat:@"%d", score];
}

- (IBAction)holdDice:(id)sender {

  UIButton *selectedDie = sender;
  NSLog(@"selected Die.tag %ld",[sender tag]);
  if ([self.diceHeld containsObject:selectedDie])
  {
    [self.diceHeld removeObject:selectedDie];
    selectedDie.backgroundColor = [UIColor clearColor];
  }
  else
  {
    [self.diceHeld addObject:selectedDie];
    selectedDie.backgroundColor = [UIColor yellowColor];
  }

  [self score];
  NSLog(@"Number of selected dice: %lu",self.diceHeld.count);
}

- (IBAction)resetDice:(id)sender {

  //change all buttons to unheld state
  [self.diceHeld enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
    [obj setBackgroundColor:[UIColor clearColor]];
    [self.diceHeld removeObject:obj];
  }];

  [self score];
  NSLog(@"Number of selected dice: %lu",self.diceHeld.count);

}

@end







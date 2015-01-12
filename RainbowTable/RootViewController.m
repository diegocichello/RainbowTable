//
//  ViewController.m
//  RainbowTable
//
//  Created by Diego Cichello on 1/12/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController () <UITableViewDataSource,UITableViewDelegate>


@property NSMutableArray *colorsArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property BOOL isItCrazy;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *crazyButton;
@property NSTimer *crazyTimer;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isItCrazy = false;
    self.colorsArray = [NSMutableArray arrayWithObjects:[UIColor redColor], [UIColor orangeColor], [UIColor yellowColor] , [UIColor greenColor] ,[UIColor cyanColor], [UIColor blueColor],[UIColor purpleColor],  nil];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.colorsArray.count;
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ColorCellID"];
    cell.textLabel.text = [NSString stringWithFormat:@"Row %li", (long)indexPath.row];
    cell.textLabel.textColor = [self randColor];
    cell.backgroundColor = [self.colorsArray objectAtIndex:indexPath.row];


    return cell;

}

- (IBAction)goCrazy:(id)sender
{
    self.isItCrazy = !self.isItCrazy;
    if (self.isItCrazy)
    {
        self.crazyTimer =[NSTimer scheduledTimerWithTimeInterval: 0.1 target: self selector: @selector(handleTimerTick) userInfo: nil repeats: YES];
        self.crazyButton.title = @"Stop Crazy!";
        

    }
    else
    {
       [self.crazyTimer invalidate];
        self.crazyButton.title = @"Go Crazy!";
   }




}

- (void) handleTimerTick
{
    [self changeAllColors];
}


- (void) changeAllColors
{
    for (int i=0;i<self.colorsArray.count;i++)
    {
        self.colorsArray[i] = [self randColor];
    }
    [self.tableView reloadData];

}
- (IBAction)addColor:(id)sender
{
    [self.colorsArray addObject:[self randColor]];
    [self.tableView reloadData];

}

- (UIColor *) randColor
{
    CGFloat red = (arc4random()%255);
    CGFloat blue = (arc4random()%255);
    CGFloat green = (arc4random()%255);
    UIColor *randColor =[ UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
    return randColor;

}


@end

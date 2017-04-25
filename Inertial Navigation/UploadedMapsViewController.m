//
//  UploadedMapsViewController.m
//  Inertial Navigation
//
//  Created by Kristen Kozmary on 10/3/16.
//  Copyright © 2016 koz. All rights reserved.
//

#import "UploadedMapsViewController.h"


@interface UploadedMapsViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSArray *content;

@end

@implementation UploadedMapsViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return _content.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *detailCell = @"DetailCell";
  DetailCell *cell = [self.tableView dequeueReusableCellWithIdentifier:detailCell];
  if(cell == nil) {
    cell = [[DetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailCell];
    cell.imageLabel.text = @"Hello";
  }
  return cell;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

-(IBAction)didSelectPlusButton:(id)sender {
  [self performSegueWithIdentifier:@"clickedPlus" sender: self];
}

@end

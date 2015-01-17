//
//  CoursesViewController.m
//  Nerdfeed
//
//  Created by Ricky Pattillo on 1/17/15.
//  Copyright (c) 2015 Ricky Pattillo. All rights reserved.
//

#import "CoursesViewController.h"
#import "WebViewController.h"

@interface CoursesViewController ()

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, copy) NSArray *courses;

@end


@implementation CoursesViewController

#pragma mark - Initializers

- (instancetype)initWithStyle:(UITableViewStyle)style
{
   self = [super initWithStyle:style];

   if (self) {
      self.navigationItem.title = @"BNR Courses";

      NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
      _session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:nil];

      [self fetchFeed];
   }

   return self;
}


#pragma mark - View life cycle

- (void)viewDidLoad
{
   [super viewDidLoad];

   [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}


#pragma mark - Table View Datasource protocol

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return [self.courses count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
                                                           forIndexPath:indexPath];

   NSDictionary *course = self.courses[indexPath.row];
   cell.textLabel.text = course[@"title"];

   return cell;
}


#pragma mark - Table View delegate protocol

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   NSDictionary *course = self.courses[indexPath.row];
   NSURL *URL = [NSURL URLWithString:course[@"url"]];

   self.webViewController.title = course[@"title"];
   self.webViewController.URL = URL;
   [self.navigationController pushViewController:self.webViewController animated:YES];
}


#pragma mark - Web Service 

- (void)fetchFeed
{
   NSString *requestString = @"http://bookapi.bignerdranch.com/courses.json";
   NSURL *url = [NSURL URLWithString:requestString];
   NSURLRequest *request = [NSURLRequest requestWithURL:url];

   NSURLSessionDataTask *dataTask =
      [self.session dataTaskWithRequest:request
      completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
         NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
         self.courses = jsonObject[@"courses"];
         NSLog( @"%@", self.courses);

         dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
         });
      }];
   [dataTask resume];
}


@end

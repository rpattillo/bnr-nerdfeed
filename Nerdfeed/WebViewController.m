//
//  WebViewController.m
//  Nerdfeed
//
//  Created by Ricky Pattillo on 1/17/15.
//  Copyright (c) 2015 Ricky Pattillo. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate>

@property (nonatomic, weak) UIBarButtonItem *prevBarItem;
@property (nonatomic, weak) UIBarButtonItem *nextBarItem;

@end


@implementation WebViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
   self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

   if (self) {
      UIBarButtonItem *previous =
         [[UIBarButtonItem alloc] initWithTitle:@"Previous"
                                          style:UIBarButtonItemStylePlain
                                         target:self
                                         action:@selector(previous)];
      UIBarButtonItem *next =
         [[UIBarButtonItem alloc] initWithTitle:@"Next"
                                          style:UIBarButtonItemStylePlain
                                         target:self
                                         action:@selector(next)];

      self.prevBarItem = previous;
      self.nextBarItem = next;
      self.toolbarItems = @[previous, next];
   }

   return self;
}


#pragma mark - Custom accessors

- (void)setURL:(NSURL *)URL
{
   _URL = URL;
   if (_URL) {
      NSURLRequest *request = [NSURLRequest requestWithURL:_URL];
      [(UIWebView *)self.view loadRequest:request];
   }
}


#pragma mark - View life cycle

- (void)loadView
{
   UIWebView *webView = [[UIWebView alloc] init];
   webView.scalesPageToFit = YES;
   webView.delegate = self;
   self.view = webView;
}

- (void)viewWillAppear:(BOOL)animated
{
   [super viewWillAppear:animated];

   self.prevBarItem.enabled = ((UIWebView *)self.view).canGoBack;
   self.nextBarItem.enabled = ((UIWebView *)self.view).canGoForward;
   self.navigationController.toolbarHidden = NO;
}


#pragma mark - Actions

- (void)previous
{
   [(UIWebView *)self.view goBack];
}


- (void)next
{
   [(UIWebView *)self.view goForward];
}


#pragma mark - Web View delegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
   self.prevBarItem.enabled = ((UIWebView *)self.view).canGoBack;
   self.nextBarItem.enabled = ((UIWebView *)self.view).canGoForward;
}

@end

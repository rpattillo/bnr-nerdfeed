//
//  WebViewController.m
//  Nerdfeed
//
//  Created by Ricky Pattillo on 1/17/15.
//  Copyright (c) 2015 Ricky Pattillo. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate>

@property (nonatomic, weak) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *previousButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextButton;

@end


@implementation WebViewController

#pragma mark - View life cycle

- (void)viewDidLoad
{
   [super viewDidLoad];

   self.edgesForExtendedLayout = UIRectEdgeNone;
}


- (void)viewWillAppear:(BOOL)animated
{
   [super viewWillAppear:animated];

   NSURLRequest *request = [NSURLRequest requestWithURL:self.URL];
   [self.webView loadRequest:request];

   self.previousButton.enabled = self.webView.canGoBack;
   self.nextButton.enabled = self.webView.canGoForward;
}


#pragma mark - XIB Actions

- (IBAction)previous:(id)sender
{
   [self.webView goBack];
}


- (IBAction)next:(id)sender
{
   [self.webView goForward];
}


#pragma mark Web View Delegate protocol

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
   self.previousButton.enabled = self.webView.canGoBack;
   self.nextButton.enabled = self.webView.canGoForward;
}

@end

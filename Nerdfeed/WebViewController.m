//
//  WebViewController.m
//  Nerdfeed
//
//  Created by Ricky Pattillo on 1/17/15.
//  Copyright (c) 2015 Ricky Pattillo. All rights reserved.
//

#import "WebViewController.h"

@implementation WebViewController


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
   self.view = webView;
}

@end

//
//  YYWebViewController.m
//  YouYi
//
//  Created by chenghao on 2017/10/26.
//  Copyright © 2017年 com.72g.www. All rights reserved.
//

#import "YYWebViewController.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"

@interface YYWebViewController ()<UIWebViewDelegate,NJKWebViewProgressDelegate>
@property(nonatomic,strong)UIWebView *webView;
@property(nonatomic,strong)NSString *currentUrl;
@property(nonatomic,strong)NJKWebViewProgress *progressProxy;
@property(nonatomic,strong)NJKWebViewProgressView *progressView;
@end

@implementation YYWebViewController

-(instancetype)initWithUrl:(NSString *)url{
    if (self=[super init]) {
        _currentUrl=url;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.progressView=[[NJKWebViewProgressView alloc] initWithFrame:CGRectMake(0, 0, 0, 2)];
    [self.contentView addSubview:self.progressView];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(2);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
    self.webView=[[UIWebView alloc] init];
    self.webView.delegate=self;
    [self.contentView addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.progressView.mas_bottom);
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    self.progressProxy=[[NJKWebViewProgress alloc] init];
    self.webView.delegate = self.progressProxy;
    self.progressProxy.webViewProxyDelegate = self;
    self.progressProxy.progressDelegate = self;
    [self.contentView setNeedsLayout];
    [self.contentView setNeedsDisplay];
    [self loadUrl:self.currentUrl];
    
    // Do any additional setup after loading the view.
}

-(void)loadUrl:(NSString *)urlString{
    NSURL *url;
    NSMutableURLRequest *req;
    url=[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    req=[NSMutableURLRequest requestWithURL:url];
    req.HTTPMethod=@"POST";
    [self.webView loadRequest:req];
}

-(void)popBack{
    if (!self.webView.canGoBack) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self.webView goBack];
    }
}

-(void)fresh{
    [self.webView reload];
}

#pragma mark NJKWebViewProgressDelegate
- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    
    if(progress >= 1.0000f)
        self.webView.backgroundColor = [UIColor clearColor];
    
    [self.progressView setProgress:progress animated:YES];
    if (progress == 0.0) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        [UIView animateWithDuration:0.27 animations:^{
            
        }];
    }
    if (progress == 1.0) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

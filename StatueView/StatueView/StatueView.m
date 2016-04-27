//
//  StatueView.m
//  
//
//  Created by 互动 on 16/4/27.
//
//

#import "StatueView.h"
#import "AppDelegate.h"

@interface StatueView ()
@property(nonatomic,strong)UILabel* titleLabel;
@property(nonatomic,strong)UIActivityIndicatorView* activityView;
@property(nonatomic,strong)UIView* bgView;
@property(nonatomic,strong)UIImageView* statueImage;
@property(nonatomic,strong)NSTimer* timer;
@end

@implementation StatueView

#define time 3

static StatueView* statueView = nil;
+(instancetype)shareStatueView{
    if (statueView==nil) {
        static dispatch_once_t once;
        dispatch_once(&once,^{
            float width = [UIScreen mainScreen].bounds.size.width/2;
            float height = width/3.5;
            statueView = [[StatueView alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-width)/2, ([UIScreen mainScreen].bounds.size.height-height)/2-64, width, height)];
            statueView.backgroundColor = [UIColor clearColor];
        });
        
    }
    return statueView;
}

-(void)initControll:(NSString*)info statue:(stauesCode)code{
    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, statueView.frame.size.width, statueView.frame.size.height)];
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = .5;
        _bgView.layer.cornerRadius = 8;
        [statueView addSubview:_bgView];
    }
    
    if (!_activityView) {
        _activityView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake((statueView.frame.size.width-40)/2, 10, 40, 40)];
        _activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        [statueView addSubview:_activityView];
        
        
        
        _statueImage = [[UIImageView alloc]initWithFrame:_activityView.frame];
        _statueImage.backgroundColor = [UIColor clearColor];
        _statueImage.image = [UIImage imageNamed:@"info"];
        [statueView addSubview:_statueImage];
        
    }
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _activityView.frame.origin.y+_activityView.frame.size.height+10, statueView.frame.size.width, 20)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.text = @"";
        [statueView addSubview:_titleLabel];
    }
    CGRect rect = statueView.frame;
    rect.size.height = _titleLabel.frame.origin.y+_titleLabel.frame.size.height+10;
    statueView.frame = rect;
    _bgView.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
    [_activityView startAnimating];
    _titleLabel.text = info;
    
    if (code==Statue_normal) {
        _activityView.hidden = NO;
        _statueImage.hidden = YES;
    }if (code==Statue_error) {
        _statueImage.image = [UIImage imageNamed:@"info"];
        _activityView.hidden = YES;
        _statueImage.hidden = NO;
    }if (code==Statue_sucecess) {
        _statueImage.image = [UIImage imageNamed:@"success"];
        _activityView.hidden = YES;
        _statueImage.hidden = NO;
    }
    
    if (code==Statue_error||code==Statue_sucecess) {
        if (_timer) {
            [_timer invalidate];
            _timer = nil;
        }
        _timer = [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(removeView) userInfo:nil repeats:YES];
    }
    
}

-(void)removeView{
    [statueView removeFromSuperview];
    [_timer invalidate];
    _timer = nil;
}

-(void)setStatue:(NSString*)info statue:(stauesCode)code{
    AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [app.window addSubview:statueView];
    [self initControll:info statue:code];
}

+(void)showErrorStatueView:(NSString*)error statue:(stauesCode)code{
    [[self shareStatueView]setStatue:error statue:code] ;
}
+(void)showNormalStatueView:(NSString*)info statue:(stauesCode)code{
    [[self shareStatueView]setStatue:info statue:code];
}

+(void)showSuccessStatueView:(NSString*)title statue:(stauesCode)code{
    [[self shareStatueView]setStatue:title statue:code];
}

+(void)dismissStatueView{
    [[self shareStatueView]removeFromSuperview];
}

@end

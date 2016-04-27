//
//  StatueView.h
//  
//
//  Created by 互动 on 16/4/27.
//
//

#import <UIKit/UIKit.h>

@interface StatueView : UIView




typedef NS_ENUM(NSInteger, stauesCode){
    Statue_error = 0,
    Statue_sucecess = 1,
    Statue_normal = 2
    
};

+(instancetype)shareStatueView;
+(void)showSuccessStatueView:(NSString*)title statue:(stauesCode)code;
+(void)showErrorStatueView:(NSString*)error statue:(stauesCode)code;
+(void)showNormalStatueView:(NSString*)info statue:(stauesCode)code;
+(void)dismissStatueView;
@end

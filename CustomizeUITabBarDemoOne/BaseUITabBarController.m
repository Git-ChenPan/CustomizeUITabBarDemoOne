//
//  BaseUITabBarController.m
//  CustomizeUITabBarDemoOne
//
//  Created by ChenPan on 2019/4/19.
//  Copyright © 2019 ChenPan. All rights reserved.
//

#import "BaseUITabBarController.h"

#define ARC4COLOR [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

@interface BaseUITabBarController ()<UITabBarControllerDelegate>

@property (nonatomic, strong) UIButton *centerButton;

@end

@implementation BaseUITabBarController

//统一设置UITabBarItem文字Color
+ (void)initialize
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加子控制器
    [self setupChildVc:[[UIViewController alloc] init] title:@"首页" image:@"tabbar_home_os7" selectedImage:@"tabbar_home_selected_os7"];
    
    [self setupChildVc:[[UIViewController alloc] init] title:@"消息" image:@"tabbar_message_center_os7" selectedImage:@"tabbar_message_center_selected_os7"];
    
    [self setupChildVc:[[UITableViewController alloc] init] title:@"" image:nil selectedImage:nil];
    
    [self setupChildVc:[[UIViewController alloc] init] title:@"广场" image:@"tabbar_discover_os7" selectedImage:@"tabbar_discover_selected_os7"];
    
    [self setupChildVc:[[UIViewController alloc] init] title:@"我" image:@"tabbar_profile_os7" selectedImage:@"tabbar_profile_selected_os7"];
    
    //tabBar上添加一个UIButton遮盖住中间的UITabBarButton
    self.centerButton.frame = CGRectMake((self.tabBar.frame.size.width-self.tabBar.frame.size.height)/2, 5, self.tabBar.frame.size.height, self.tabBar.frame.size.height);
    [self.tabBar addSubview:self.centerButton];
    
    self.delegate = self;

}

/**
 * 初始化子控制器
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置文字和图片
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    vc.view.backgroundColor = ARC4COLOR;
    [self addChildViewController:vc];
}

// 即将点击哪个控制器代理方法，需设置self.delegate = self;
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    if ([viewController isKindOfClass:[UITableViewController class]]) {
        // 点击了中间的那个控制器，此时需要替换成自己的点击事件
        [self centerButtonAction];
        return NO;
    }
    return YES;
}

- (UIButton *)centerButton {
    if (!_centerButton) {
        _centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_centerButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [_centerButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];

        [_centerButton addTarget:self action:@selector(centerButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _centerButton;
}

- (void)centerButtonAction {
    NSLog(@"拦截了控制器跳转，在这里面做自己想做的事");
}

@end

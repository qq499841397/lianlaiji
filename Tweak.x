#import <Foundation/Foundation.h>
#import <objc/runtime.h>

// 新方法的实现：永远返回 YES
static BOOL hooked_is_diamond_vip(id self, SEL _cmd) {
    return YES;
}

// 构造函数，插件加载时自动运行
%ctor {
    // 尝试获取类
    Class targetClass = NSClassFromString(@"LNUserJointVIPInfo");
    if (!targetClass) {
        targetClass = NSClassFromString(@"LNUUserJointVIPInfo");
    }

    if (targetClass) {
        // 获取原始方法
        Method originalMethod = class_getInstanceMethod(targetClass, @selector(is_diamond_vip));
        if (originalMethod) {
            // 替换方法实现
            IMP newImp = (IMP)hooked_is_diamond_vip;
            method_setImplementation(originalMethod, newImp);
            NSLog(@"LoveBypass: Successfully hooked is_diamond_vip!");
        } else {
            // 如果找不到 is_diamond_vip，尝试其他可能的名字
            Method altMethod = class_getInstanceMethod(targetClass, @selector(isDiamondVip));
            if (altMethod) {
                IMP newImp = (IMP)hooked_is_diamond_vip;
                method_setImplementation(altMethod, newImp);
                NSLog(@"LoveBypass: Successfully hooked isDiamondVip!");
            } else {
                NSLog(@"LoveBypass: Failed to find is_diamond_vip method.");
            }
        }
    } else {
        NSLog(@"LoveBypass: Failed to find target class.");
    }
}

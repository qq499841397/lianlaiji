#import <Foundation/Foundation.h>
#import <objc/runtime.h>

static BOOL hooked_is_diamond_vip(id self, SEL _cmd) {
    // 写文件到手机，证明方法被调用了
    NSString *msg = @"is_diamond_vip was called!\n";
    NSData *data = [msg dataUsingEncoding:NSUTF8StringEncoding];
    NSString *path = @"/var/mobile/lovebypass.log";
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSFileHandle *fh = [NSFileHandle fileHandleForWritingAtPath:path];
        [fh seekToEndOfFile];
        [fh writeData:data];
        [fh closeFile];
    } else {
        [data writeToFile:path atomically:YES];
    }
    return YES;
}

%ctor {
    // 在插件加载时写文件，证明插件已被加载
    NSString *msg = @"LoveBypass plugin loaded!\n";
    NSData *data = [msg dataUsingEncoding:NSUTF8StringEncoding];
    NSString *path = @"/var/mobile/lovebypass.log";
    [data writeToFile:path atomically:YES];

    Class targetClass = NSClassFromString(@"LNUserJointVIPInfo");
    if (targetClass) {
        Method method = class_getInstanceMethod(targetClass, @selector(is_diamond_vip));
        if (method) {
            method_setImplementation(method, (IMP)hooked_is_diamond_vip);
        }
    }
}

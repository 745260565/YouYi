//
//  NSObject+runtime.m
//

#import "NSObject+runtime.h"
#import <objc/runtime.h>

@implementation NSObject (runtime)

+ (BOOL)overrideMethod:(SEL)origSel withMethod:(SEL)altSel
{
    Method origMethod =class_getInstanceMethod(self, origSel);
    if (!origMethod) {
        NSLog(@"original method %@ not found for class %@", NSStringFromSelector(origSel), [self class]);
        return NO;
    }
    
    Method altMethod =class_getInstanceMethod(self, altSel);
    if (!altMethod) {
        NSLog(@"original method %@ not found for class %@", NSStringFromSelector(altSel), [self class]);
        return NO;
    }
    
    method_setImplementation(origMethod, class_getMethodImplementation(self, altSel));
    return YES;
}

+ (BOOL)overrideClassMethod:(SEL)origSel withClassMethod:(SEL)altSel
{
    Class c = object_getClass((id)self);
    return [c overrideMethod:origSel withMethod:altSel];
}

+ (BOOL)exchangeMethod:(SEL)origSel withMethod:(SEL)altSel
{
    Method origMethod =class_getInstanceMethod(self, origSel);
    if (!origMethod) {
        NSLog(@"original method %@ not found for class %@", NSStringFromSelector(origSel), [self class]);
        return NO;
    }
    
    Method altMethod =class_getInstanceMethod(self, altSel);
    if (!altMethod) {
        NSLog(@"original method %@ not found for class %@", NSStringFromSelector(altSel), [self class]);
        return NO;
    }
    
    method_exchangeImplementations(class_getInstanceMethod(self, origSel),class_getInstanceMethod(self, altSel));
    
    return YES;
}

+ (BOOL)exchangeClassMethod:(SEL)origSel withClassMethod:(SEL)altSel
{
    Class c = object_getClass((id)self);
    return [c exchangeMethod:origSel withMethod:altSel];
}

+ (NSDictionary *)object2Dic:(id)obj{
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([obj class], &count);
    
    for (int i=0; i < count; i++) {
        objc_property_t property = properties[i];
        const char *char_f = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [obj valueForKey:propertyName];
        if (propertyValue) {
            [dic setValue:propertyValue forKey:propertyName];
        }
    }
    free(properties);
    return dic;
    
}

//+ (id)dic2Object:(NSDictionary*)dictionary{
//    return nil;
//}

@end

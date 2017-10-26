//
//  NSObject+runtime.h
//

#import <Foundation/Foundation.h>

@interface NSObject (runtime)

+ (BOOL)overrideMethod:(SEL)origSel withMethod:(SEL)altSel;
+ (BOOL)overrideClassMethod:(SEL)origSel withClassMethod:(SEL)altSel;
+ (BOOL)exchangeMethod:(SEL)origSel withMethod:(SEL)altSel;
+ (BOOL)exchangeClassMethod:(SEL)origSel withClassMethod:(SEL)altSel;
+ (NSDictionary *)object2Dic:(id)obj;
//+ (id)dic2Object:(NSDictionary*)dictionary;
@end

//
//  NSMutableDictionary+safe.h
//


#import <Foundation/Foundation.h>

@interface NSMutableDictionary(safe)

- (void)safeSetObject:(id)aObj forKey:(id<NSCopying>)aKey;

- (id)safeObjectForKey:(id<NSCopying>)aKey;

- (void)safeSetObject:(id)obj forKeyedSubscript:(id<NSCopying>)key;

@end

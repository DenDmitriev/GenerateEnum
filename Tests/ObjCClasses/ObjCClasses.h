#import <Foundation/Foundation.h>

__attribute__((swift_name("Flow1ComponentChild")))
@interface SharedFlow1ComponentChild : NSObject
@end

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Flow1ComponentChild.Screen1A")))
@interface SharedFlow1ComponentChildScreen1A : SharedFlow1ComponentChild
- (instancetype)initWithComponent:(id)component __attribute__((swift_name("init(component:)"))) __attribute__((objc_designated_initializer));
@property (readonly) id component __attribute__((swift_name("component")));
@end

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Flow1ComponentChild.Screen1B")))
@interface SharedFlow1ComponentChildScreen1B : SharedFlow1ComponentChild
- (instancetype)initWithComponent:(id)component __attribute__((swift_name("init(component:)"))) __attribute__((objc_designated_initializer));
@property (readonly) id component __attribute__((swift_name("component")));
@end

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Flow1ComponentChild.Screen1C")))
@interface SharedFlow1ComponentChildScreen1C : SharedFlow1ComponentChild
- (instancetype)initWithComponent:(id)component __attribute__((swift_name("init(component:)"))) __attribute__((objc_designated_initializer));
@property (readonly) id component __attribute__((swift_name("component")));
@end

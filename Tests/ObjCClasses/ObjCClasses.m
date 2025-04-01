#import "ObjCClasses.h"

@implementation SharedFlow1ComponentChild
@end

@implementation SharedFlow1ComponentChildScreen1A
- (instancetype)initWithComponent:(id)component {
    self = [super init];
    if (self) {
        _component = component;
    }
    return self;
}
@end

@implementation SharedFlow1ComponentChildScreen1B
- (instancetype)initWithComponent:(id)component {
    self = [super init];
    if (self) {
        _component = component;
    }
    return self;
}
@end

@implementation SharedFlow1ComponentChildScreen1C
- (instancetype)initWithComponent:(id)component {
    self = [super init];
    if (self) {
        _component = component;
    }
    return self;
}
@end

// KVORetainCycleSolution.m
#import "KVORetainCycleSolution.h"

@interface MyModel : NSObject
@property (nonatomic, strong) NSString *name;
@end

@implementation MyModel
- (void)setName:(NSString *)name {
    _name = name;
    [self willChangeValueForKey:@"name"];
    _name = name;
    [self didChangeValueForKey:@"name"];
}
@end

@interface MyViewController : UIViewController
@property (nonatomic, strong) MyModel *model;
@end

@implementation MyViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.model = [[MyModel alloc] init];
    [self.model addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"name"]) {
        NSLog("Model name changed: %@
", change[NSKeyValueChangeNewKey]);
    }
}

- (void)dealloc {
    [self.model removeObserver:self forKeyPath:@"name"];
}
@end
#import "RotatingNavigationController.h"

// Use a dummy class, because this workaround will also trigger calls to
// `viewWillAppear:` and `viewDidAppear:`.
@interface DummyController : UIViewController
@property (assign) UIInterfaceOrientationMask supportedOrientations;
@end
@implementation DummyController
- (instancetype)initWithSupportedInterfaceOrientations:(UIInterfaceOrientationMask)mask;
{
  if ((self = [super init])) {
    _supportedOrientations = mask;
  }
  return self;
}

- (void)viewWillAppear:(BOOL)animated;
{
  [super viewWillAppear:animated];
  // NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)viewDidAppear:(BOOL)animated;
{
  [super viewDidAppear:animated];
  // NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (BOOL)shouldAutorotate;
{
  return YES;
}

- (NSUInteger)supportedInterfaceOrientations;
{
  return self.supportedOrientations;
}

@end


@interface RotatingNavigationController ()
@property (assign) BOOL shouldAskControllerToAutorotate;
@end

@implementation RotatingNavigationController

- (id)initWithRootViewController:(UIViewController *)rootViewController;
{
  if ((self = [super initWithRootViewController:rootViewController])) {
    _shouldAskControllerToAutorotate = YES;
  }
  return self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
{
  // TODO check if this needs to be forced for the root view controller as well.
  if (self.viewControllers.count > 0) {
    DummyController *dummy = [[DummyController alloc] initWithSupportedInterfaceOrientations:viewController.supportedInterfaceOrientations];
    [self presentViewController:dummy animated:NO completion:NULL];
    [dummy dismissViewControllerAnimated:NO completion:NULL];
  }
  [super pushViewController:viewController animated:animated];
}

// TODO Segfaults
//
//- (UIViewController *)popViewControllerAnimated:(BOOL)animated;
//{
  //UIViewController *viewController = self.viewControllers[self.viewControllers.count - 2];
  //DummyController *dummy = [[DummyController alloc] initWithSupportedInterfaceOrientations:viewController.supportedInterfaceOrientations];
  //[self presentViewController:dummy animated:NO completion:NULL];
  //[dummy dismissViewControllerAnimated:NO completion:NULL];

  //[super popViewControllerAnimated:animated];
//}

- (BOOL)shouldAutorotate;
{
  return self.visibleViewController.shouldAutorotate;
}

- (NSUInteger)supportedInterfaceOrientations;
{
  return self.visibleViewController.supportedInterfaceOrientations;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;
{
  [self.visibleViewController willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration;
{
  [self.visibleViewController willAnimateRotationToInterfaceOrientation:interfaceOrientation duration:duration];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation;
{
  [self.visibleViewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

@end

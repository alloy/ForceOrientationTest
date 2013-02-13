#import "RotatingNavigationController.h"

// Use a dummy class, because this workaround will also trigger calls to
// `viewWillAppear:` & `viewDidAppear:`, which might trigger side-effects in
// the actual controller that the user wants displayed.
@interface DummyController : UIViewController
@property (assign) NSUInteger supportedInterfaceOrientations;
@end
@implementation DummyController
- (BOOL)shouldAutorotate; { return YES; }
@end


@interface RotatingNavigationController ()
@property (strong) DummyController *dummyController;
@end

@implementation RotatingNavigationController

- (void)forceSupportedOrientation:(UIViewController *)controller;
{
  if (self.dummyController == nil) {
    self.dummyController = [DummyController new];
  }
  self.dummyController.supportedInterfaceOrientations = controller.supportedInterfaceOrientations;
  [self presentViewController:self.dummyController animated:NO completion:NULL];
  [self.dummyController dismissViewControllerAnimated:NO completion:NULL];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
{
  // TODO check if this needs to be forced for the root view controller as well.
  if (self.viewControllers.count > 0) {
    [self forceSupportedOrientation:viewController];
  }
  [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated;
{
  [self forceSupportedOrientation:self.viewControllers[self.viewControllers.count - 2]];
  return [super popViewControllerAnimated:animated];
}

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

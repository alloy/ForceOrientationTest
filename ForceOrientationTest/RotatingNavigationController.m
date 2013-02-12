#import "RotatingNavigationController.h"

static CGFloat
angleOfOrientation(UIInterfaceOrientation orientation) {
  switch (orientation) {
    case UIInterfaceOrientationPortrait:
      return 0;
    case UIInterfaceOrientationPortraitUpsideDown:
      return M_PI;
    case UIInterfaceOrientationLandscapeLeft:
      return M_PI * 1.5;
    case UIInterfaceOrientationLandscapeRight:
      return M_PI * 1.5;
  }
}

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

- (void)forceOrientationChangeIfNecessary:(UIInterfaceOrientationMask)supported;
{
  BOOL needsToRotate = NO;

  switch (self.interfaceOrientation) {
    case UIInterfaceOrientationPortrait:
      needsToRotate = (supported & UIInterfaceOrientationMaskPortrait) != UIInterfaceOrientationMaskPortrait;
      break;
    case UIInterfaceOrientationPortraitUpsideDown:
      needsToRotate = (supported & UIInterfaceOrientationMaskPortraitUpsideDown) != UIInterfaceOrientationMaskPortraitUpsideDown;
      break;
    case UIInterfaceOrientationLandscapeLeft:
      needsToRotate = (supported & UIInterfaceOrientationMaskLandscapeLeft) != UIInterfaceOrientationMaskLandscapeLeft;
      break;
    case UIInterfaceOrientationLandscapeRight:
      needsToRotate = (supported & UIInterfaceOrientationMaskLandscapeRight) != UIInterfaceOrientationMaskLandscapeRight;
      break;
  }

  if (needsToRotate) {
    UIInterfaceOrientation rotateTo;
    CGRect frame;
    if ((supported & UIInterfaceOrientationMaskPortrait) == UIInterfaceOrientationMaskPortrait) {
      rotateTo = UIInterfaceOrientationPortrait;
      frame = CGRectMake(0, 0, 768, 1024);
    } else if ((supported & UIInterfaceOrientationMaskPortraitUpsideDown) == UIInterfaceOrientationMaskPortraitUpsideDown) {
      rotateTo = UIInterfaceOrientationPortraitUpsideDown;
      frame = CGRectMake(0, 0, 768, 1024);
    } else if ((supported & UIInterfaceOrientationMaskLandscapeLeft) == UIInterfaceOrientationMaskLandscapeLeft) {
      rotateTo = UIInterfaceOrientationLandscapeLeft;
      frame = CGRectMake(0, 0, 768, 1024);
    } else if ((supported & UIInterfaceOrientationMaskLandscapeRight) == UIInterfaceOrientationMaskLandscapeRight) {
      rotateTo = UIInterfaceOrientationLandscapeRight;
      frame = CGRectMake(0, 0, 1024, 768);
    }

    self.shouldAskControllerToAutorotate = NO;
    [[UIApplication sharedApplication] setStatusBarOrientation:rotateTo];
    self.view.transform = CGAffineTransformMakeRotation(angleOfOrientation(rotateTo));
    self.view.frame = frame;
  }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
{
  [self forceOrientationChangeIfNecessary:viewController.supportedInterfaceOrientations];
  [super pushViewController:viewController animated:animated];
}

// TODO Segfaults
//
//- (UIViewController *)popViewControllerAnimated:(BOOL)animated;
//{
  //UIViewController *viewController = self.viewControllers[self.viewControllers.count - 2];
  //[self forceOrientationChangeIfNecessary:viewController.supportedInterfaceOrientations];
  //[super popViewControllerAnimated:animated];
//}

// Setting the status bar orientation *only* works if `shouldAutorotate`
// returns `NO`.
- (BOOL)shouldAutorotate;
{
  if (self.shouldAskControllerToAutorotate) {
    return self.visibleViewController.shouldAutorotate;
  } else {
    self.shouldAskControllerToAutorotate = YES;
    return NO;
  }
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

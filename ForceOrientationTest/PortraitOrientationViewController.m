#import "PortraitOrientationViewController.h"

@implementation PortraitOrientationViewController

- (void)loadView;
{
  self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
  self.view.backgroundColor = [UIColor blueColor];

  UILabel *label = [UILabel new];
  label.textAlignment = NSTextAlignmentCenter;
  label.backgroundColor = [UIColor clearColor];
  label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
  [self.view addSubview:label];
  label.text = @"Portrait Orientations";
  label.frame = CGRectMake(0, 0, self.view.bounds.size.width, 44);
}

- (BOOL)shouldAutorotate;
{
  return YES;
}

- (NSUInteger)supportedInterfaceOrientations;
{
  return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
}

@end

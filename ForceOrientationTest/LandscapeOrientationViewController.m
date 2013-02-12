#import "LandscapeOrientationViewController.h"
#import "PortraitOrientationViewController.h"

@implementation LandscapeOrientationViewController

- (void)loadView;
{
  self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
  self.view.backgroundColor = [UIColor greenColor];

  UILabel *label = [UILabel new];
  label.textAlignment = NSTextAlignmentCenter;
  label.backgroundColor = [UIColor clearColor];
  label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
  [self.view addSubview:label];
  label.text = @"Landscape Orientations";
  label.frame = CGRectMake(0, 0, self.view.bounds.size.width, 44);

  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next"
                                                                            style:UIBarButtonItemStyleBordered
                                                                           target:self
                                                                           action:@selector(showNextController:)];
}

- (void)showNextController:(id)sender;
{
  [self.navigationController pushViewController:[PortraitOrientationViewController new]
                                       animated:YES];
}

- (BOOL)shouldAutorotate;
{
  return YES;
}

- (NSUInteger)supportedInterfaceOrientations;
{
  return UIInterfaceOrientationMaskLandscape;
}

@end

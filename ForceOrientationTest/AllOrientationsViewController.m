#import "AllOrientationsViewController.h"
#import "LandscapeOrientationViewController.h"

@implementation AllOrientationsViewController

- (void)loadView;
{
  self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
  self.view.backgroundColor = [UIColor redColor];

  UILabel *label = [UILabel new];
  label.textAlignment = NSTextAlignmentCenter;
  label.backgroundColor = [UIColor clearColor];
  label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
  [self.view addSubview:label];
  label.text = @"All Orientations";
  label.frame = CGRectMake(0, 0, self.view.bounds.size.width, 44);

  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next"
                                                                            style:UIBarButtonItemStyleBordered
                                                                           target:self
                                                                           action:@selector(showNextController:)];
}

- (void)showNextController:(id)sender;
{
  [self.navigationController pushViewController:[LandscapeOrientationViewController new]
                                       animated:YES];
}

- (BOOL)shouldAutorotate;
{
  return YES;
}

- (NSUInteger)supportedInterfaceOrientations;
{
  return UIInterfaceOrientationMaskAll;
}

@end

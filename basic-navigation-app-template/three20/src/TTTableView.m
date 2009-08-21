#import "Three20/TTTableView.h"
#import "Three20/TTStyledNode.h"
#import "Three20/TTStyledTextLabel.h"
#import "Three20/TTTableViewDelegate.h"

///////////////////////////////////////////////////////////////////////////////////////////////////
// global

static const CGFloat kCancelHighlightThreshold = 4;

///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation TTTableView

@synthesize highlightedLabel = _highlightedLabel, contentOrigin = _contentOrigin;

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
  if (self = [super initWithFrame:frame style:style]) {
    _highlightedLabel = nil;
    _highlightStartPoint = CGPointZero;
    _contentOrigin = 0;
  }
  return self;
}

- (void)dealloc {
  TT_RELEASE_SAFELY(_highlightedLabel);
  [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// UIResponder

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
  [super touchesBegan:touches withEvent:event];

  if (_highlightedLabel) {
    UITouch* touch = [touches anyObject];
    _highlightStartPoint = [touch locationInView:self];
  }
  
//  if (_menuView) {
//    UITouch* touch = [touches anyObject];
//    CGPoint point = [touch locationInView:_menuView];
//    if (point.y < 0 || point.y > _menuView.height) {
//      [self hideMenu:YES];
//    } else {
//      UIView* hit = [_menuView hitTest:point withEvent:event];
//      if (![hit isKindOfClass:[UIControl class]]) {
//        [self hideMenu:YES];
//      }
//    }
//  }
}

- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event {
  [super touchesEnded:touches withEvent:event];

  if (_highlightedLabel) {
    TTStyledElement* element = _highlightedLabel.highlightedNode;
    [element performDefaultAction];
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// UIScrollView

- (void)setContentSize:(CGSize)size {
  if (_contentOrigin) {
    CGFloat minHeight = self.height + _contentOrigin;
    if (size.height < minHeight) {
      size.height = self.height + _contentOrigin;
    }
  }

  CGFloat y = self.contentOffset.y;
  [super setContentSize:size];

  if (_contentOrigin) {
    self.contentOffset = CGPointMake(0, y);
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// UITableView

- (void)reloadData {
  CGFloat y = self.contentOffset.y;
  [super reloadData];

  if (_contentOrigin) {
    self.contentOffset = CGPointMake(0, y);
  }
}

- (void)selectRowAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated
        scrollPosition:(UITableViewScrollPosition)scrollPosition {
  if (!_highlightedLabel) {
    [super selectRowAtIndexPath:indexPath animated:animated scrollPosition:scrollPosition];
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// public

- (void)setHighlightedLabel:(TTStyledTextLabel*)label {
  if (label != _highlightedLabel) {
    _highlightedLabel.highlightedNode = nil;
    [_highlightedLabel release];
    _highlightedLabel = [label retain];
  }
}

@end

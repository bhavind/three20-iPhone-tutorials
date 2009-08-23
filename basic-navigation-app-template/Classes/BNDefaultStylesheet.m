#import "BNDefaultStyleSheet.h"
#import "Three20/TTStyle.h"
#import "Three20/TTShape.h"
#import "Three20/TTURLCache.h"



///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation BNDefaultStyleSheet


///////////////////////////////////////////////////////////////////////////////////////////////////
// styles

///////////////////////////////////////////////////////////////////////////////////////////////////
// public colors

- (UIColor*)myHeadingColor {
	return RGBCOLOR(80, 110, 140);
}

- (UIColor*)mySubtextColor {
	return [UIColor grayColor];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
// public fonts

- (UIFont*)myHeadingFont {
	return [UIFont boldSystemFontOfSize:16];
}

- (UIFont*)mySubtextFont {
	return [UIFont systemFontOfSize:13];
}

@end
#import "SIStatusItemView.h"

@implementation SIStatusItemView

@synthesize statusItem = _statusItem;
@synthesize image = _image;
@synthesize alternateImage = _alternateImage;
@synthesize isHighlighted = _isHighlighted;
@synthesize menu = _menu;
@synthesize delegate = _delegate;
@synthesize popover = _popover;

#pragma mark -

- (id)initWithStatusItem:(NSStatusItem *)statusItem
{
    CGFloat itemWidth = [statusItem length];
    CGFloat itemHeight = [[NSStatusBar systemStatusBar] thickness];
    NSRect itemRect = NSMakeRect(0.0, 0.0, itemWidth, itemHeight);
    self = [super initWithFrame:itemRect];
    
    if (self != nil)
    {
        _statusItem = [statusItem retain];
        _statusItem.view = self;
        
    }
    return self;
}

- (void)dealloc
{
    [_statusItem release];
    [_image release];
    [_alternateImage release];
    
    [super dealloc];
}

#pragma mark -

- (void)drawRect:(NSRect)dirtyRect
{
	[self.statusItem drawStatusBarBackgroundInRect:dirtyRect withHighlight:self.isHighlighted];
    
    NSImage *icon = self.isHighlighted ? self.alternateImage : self.image;
    NSSize iconSize = [icon size];
    NSRect bounds = self.bounds;
    CGFloat iconX = roundf((NSWidth(bounds) - iconSize.width) / 2);
    CGFloat iconY = roundf((NSHeight(bounds) - iconSize.height) / 2);
    NSPoint iconPoint = NSMakePoint(iconX, iconY);
    [icon compositeToPoint:iconPoint operation:NSCompositeSourceOver];
}

#pragma mark -
#pragma mark Mouse tracking

- (void)mouseDown:(NSEvent *)event
{
    [[self menu] setDelegate:self];
        
    if(_popover.shown){
        
        [_popover close];
        
    }else{
        
        [_popover showRelativeToRect:[self bounds] ofView:self preferredEdge:NSMaxYEdge];
    }
    
    [self setNeedsDisplay:YES];
}

- (void)rightMouseDown:(NSEvent *)event
{
    [self mouseDown:event];
}

#pragma mark -
#pragma mark Accessors

- (void)setHighlighted:(BOOL)newFlag
{
    if (_isHighlighted == newFlag) return;
    _isHighlighted = newFlag;
    [self setNeedsDisplay:YES];
}

#pragma mark -

- (void)setImage:(NSImage *)newImage
{
    [newImage retain];
    [_image release];
    _image = newImage;
    [self setNeedsDisplay:YES];
}

- (void)setAlternateImage:(NSImage *)newImage
{
    [newImage retain];
    [_alternateImage release];
    _alternateImage = newImage;
    if (self.isHighlighted)
        [self setNeedsDisplay:YES];
}


#pragma -
#pragma mark Menu

- (void)menuWillOpen:(NSMenu *)menu {
    [self setNeedsDisplay:YES];
}

- (void)menuDidClose:(NSMenu *)menu {
    [menu setDelegate:nil];    
    [self setNeedsDisplay:YES];
}

#pragma -
#pragma mark Drag tracking

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender
{
    if ([_delegate respondsToSelector:@selector(draggingEntered:)]) {
        _isHighlighted = YES;
        [self setNeedsDisplay: YES];
        return [_delegate draggingEntered: sender];
    }
    return NSDragOperationNone;
}

- (NSDragOperation)draggingUpdated:(id <NSDraggingInfo>)sender
{
    if ([_delegate respondsToSelector:@selector(draggingUpdated:)]) {
        return [_delegate draggingUpdated: sender];
    }
    return NSDragOperationNone;
}

- (void)draggingExited:(id <NSDraggingInfo>)sender
{
    if ([_delegate respondsToSelector:@selector(draggingExited:)]) {
        _isHighlighted = NO;
        [self setNeedsDisplay: YES];
        [_delegate draggingExited: sender];
    }
}
- (BOOL)prepareForDragOperation:(id <NSDraggingInfo>)sender
{
    if ([_delegate respondsToSelector:@selector(prepareForDragOperation:)]) {
        return [_delegate prepareForDragOperation: sender];
    }
    return NO;
}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender
{
    if ([_delegate respondsToSelector:@selector(performDragOperation:)]) {
        return [_delegate performDragOperation: sender];
    }
    return NO;
}

- (void)concludeDragOperation:(id <NSDraggingInfo>)sender
{
    if ([_delegate respondsToSelector:@selector(concludeDragOperation:)]) {
        [_delegate concludeDragOperation: sender];
    }
    _isHighlighted = NO;
    [self setNeedsDisplay: YES];
}

#pragma mark -

- (NSRect)globalRect
{
    NSRect frame = [self frame];
    frame.origin = [self.window convertBaseToScreen:frame.origin];
    return frame;
}

@end
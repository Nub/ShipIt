@interface SIStatusItemView : NSView <NSMenuDelegate> {
@private
    NSImage *_image;
    NSImage *_alternateImage;
    NSStatusItem *_statusItem;
    NSMenu *_menu;
    BOOL _isHighlighted;
    id _delegate;
}

- (id)initWithStatusItem:(NSStatusItem *)statusItem;

@property (nonatomic, readonly) NSStatusItem *statusItem;
@property (nonatomic, retain) NSImage *image;
@property (nonatomic, retain) NSMenu *menu;
@property (nonatomic, retain) NSImage *alternateImage;
@property (nonatomic, retain) id delegate;
@property (nonatomic, setter = setHighlighted:) BOOL isHighlighted;
@property (nonatomic, readonly) NSRect globalRect;

@end
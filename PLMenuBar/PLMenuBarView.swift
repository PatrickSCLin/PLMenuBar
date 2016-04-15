//
//  PLMenuBarView.swift
//  PLMenuBar
//
//  Created by Patrick Lin on 4/12/16.
//  Copyright © 2016 Patrick Lin. All rights reserved.
//

@objc public protocol PLMenuBarDelegate: NSObjectProtocol {
    
    func numberOfItemsInMenubar() -> Int;
    
    func menuBar(menuBar: PLMenuBarView, titleForItemAtIndex index: Int) -> String;
    
    optional func menuBar(menuBar: PLMenuBarView, detailItemForItemAtIndex index: Int) -> PLMenuDetailItem;
    
    optional func menuBar(menuBar: PLMenuBarView, didSelectItemAtIndex index: Int);
    
    optional func menuBar(menuBar: PLMenuBarView, didSelectDetailAtRow row: Int, Section section: Int, forItemAtIndex index: Int);
    
}

public class PLMenuComboSection: NSObject {
    
    public var preferredIndex: Int = -1;
    
    public var title: String = "";
    
    public var items: [String] = [String]();
    
    public override init() {
        
        super.init();
        
    }
    
    public init(title: String = "", items: [String], preferredIndex: Int = -1) {
        
        self.title.appendContentsOf(title);
        
        self.items.appendContentsOf(items);
        
        self.preferredIndex = preferredIndex;
        
    }
    
}

public class PLMenuDetailComboItem: PLMenuDetailItem {
    
    public var items: [PLMenuComboSection] = [PLMenuComboSection]();
    
    public init(title: String = "", items: [PLMenuComboSection]) {
        
        super.init(title: title);
        
        self.items.appendContentsOf(items);
        
    }
    
}

public class PLMenuDetailDescItem: PLMenuDetailItem {
    
    public var text: String = "";
    
    public init(title: String = "", text: String = "") {
        
        super.init(title: title);
        
        self.text.appendContentsOf(text);
        
    }
    
}

public class PLMenuDetailItem: NSObject {
    
    public var title: String = "";
    
    public init(title: String = "") {
        
        self.title.appendContentsOf(title);
        
    }
    
}

public class PLMenuBarView: UIView, UITabBarDelegate, UITableViewDelegate, PLMenuDetailComboViewDelegate {
    
    static let MenuBarMinHeight: CGFloat = 140;
    
    static let MenuBarDetailMinHeight: CGFloat = 210;
    
    static let MenuBarDetailPadding: CGFloat = 150;
    
    static let MenuBarBorderHeight: CGFloat = 1;
    
    private var shouldShowDetailView: Bool = false;
    
    private var guides: [UIFocusGuide] = [UIFocusGuide]();
    
    private var menuBar: UITabBar!;
    
    private var detailView: PLBackdropView!;
    
    private var borderView: UIView!;
    
    private var contentView: PLMenuDetailView?;
    
    public var delegate: PLMenuBarDelegate?;
    
    // MARK: Combo Delegate Methods
    
    public func combo(combo: PLMenuDetailComboView, didChangeValueAtSection section: Int, Row row: Int) {
        
        self.delegate?.menuBar?(self, didSelectDetailAtRow: row, Section: section, forItemAtIndex: (self.menuBar.selectedItem?.tag)!);
        
    }
    
    // MARK: Tabbar Delegate Methods
    
    public func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        
        let index = item.tag;
        
        if self.delegate == nil { return; }
        
        let detailItem = self.delegate!.menuBar?(self, detailItemForItemAtIndex: index);
        
        if detailItem != nil && ((detailItem! is PLMenuDetailDescItem) || (detailItem! is PLMenuDetailComboItem)) {
            
            for (_, guide) in self.guides.enumerate() {
                
                guide.owningView?.removeLayoutGuide(guide);
                
            }
            
            self.guides.removeAll();
            
            if self.contentView != nil {
                
                self.contentView?.removeFromSuperview();
                
                self.contentView = nil;
                
            }
            
            let contentFrame = CGRectMake(PLMenuBarView.MenuBarDetailPadding, 0, self.detailView.bounds.size.width - (PLMenuBarView.MenuBarDetailPadding * 2), PLMenuBarView.MenuBarDetailMinHeight);
            
            if detailItem is PLMenuDetailDescItem {
                
                self.contentView = PLMenuDetailDescView(text: (detailItem as! PLMenuDetailDescItem).text);
                
                self.contentView!.frame = contentFrame;
                
                self.detailView.addSubview(self.contentView!);
                
            }
            
            else if detailItem is PLMenuDetailComboItem {
                
                self.contentView = PLMenuDetailComboView(items: (detailItem as! PLMenuDetailComboItem).items);
                
                (self.contentView as! PLMenuDetailComboView).delegate = self;
                
                self.contentView!.frame = contentFrame;
                
                self.detailView.addSubview(self.contentView!);
                
                for (_, sectionView) in self.contentView!.contentViews.enumerate() {
                    
                    for (_, rowView) in (sectionView as! PLMenuDetailComboSectionView).rowViews.enumerate() {
                        
                        let guide = UIFocusGuide();
                        
                        self.addLayoutGuide(guide);
                        
                        guide.preferredFocusedView = rowView.contentBtn;
                        
                        guide.topAnchor.constraintEqualToAnchor(rowView.contentBtn.topAnchor).active = true;
                        
                        guide.leftAnchor.constraintEqualToAnchor(rowView.contentBtn.leftAnchor).active = true;
                        
                        guide.widthAnchor.constraintEqualToAnchor(rowView.contentBtn.widthAnchor).active = true;
                        
                        guide.heightAnchor.constraintEqualToAnchor(rowView.contentBtn.heightAnchor).active = true;
                        
                        self.guides.append(guide);
                        
                    }
                    
                }
                
            }
            
            self.shouldShowDetailView = true;
            
            self.frame = CGRectMake(0, 0, (self.superview?.frame.size.width)!, PLMenuBarView.MenuBarMinHeight + PLMenuBarView.MenuBarDetailMinHeight);
            
        }
        
        else {
            
            self.shouldShowDetailView = false;
            
            self.frame = CGRectMake(0, 0, (self.superview?.frame.size.width)!, PLMenuBarView.MenuBarMinHeight);
            
        }
        
    }
    
    // MARK: Public Methods
    
    public override func layoutSubviews() {
        
        super.layoutSubviews();
        
        if self.shouldShowDetailView == true {

            self.borderView.hidden = false;
            
            self.contentView?.alpha = 0;
            
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                
                self.menuBar.frame = CGRectMake(0, 0, self.frame.size.width, PLMenuBarView.MenuBarMinHeight);
                
                self.detailView.frame = CGRectMake(0, PLMenuBarView.MenuBarMinHeight, self.frame.size.width, PLMenuBarView.MenuBarDetailMinHeight);
                
                self.contentView?.alpha = 1;
                
                self.borderView.frame = CGRectMake(0, PLMenuBarView.MenuBarMinHeight, self.frame.size.width, PLMenuBarView.MenuBarBorderHeight);
                
                self.borderView.alpha = 1;
                
            }, completion: { (isCompleted: Bool) in
                    
                
                    
            });
            
        }
        
        else {
            
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                
                self.menuBar.frame = CGRectMake(0, 0, self.frame.size.width, PLMenuBarView.MenuBarMinHeight);
                
                self.detailView.frame = CGRectMake(0, PLMenuBarView.MenuBarMinHeight, self.frame.size.width, 0);
                
                self.contentView?.alpha = 0;
                
                self.borderView.frame = CGRectMake(0, PLMenuBarView.MenuBarMinHeight, self.frame.size.width, PLMenuBarView.MenuBarBorderHeight);
                
                self.borderView.alpha = 0;
                
            }, completion: { (isCompleted: Bool) in
                    
                self.borderView.hidden = true;
                    
            });
            
        }
        
    }

    public override func willMoveToSuperview(newSuperview: UIView?) {
        
        super.willMoveToSuperview(newSuperview);
        
        if newSuperview != nil {
            
            self.frame = CGRectMake(0, 0, newSuperview!.frame.size.width, PLMenuBarView.MenuBarMinHeight);
            
            if delegate != nil {
                
                var items: [UITabBarItem] = [UITabBarItem]();
                
                let countOfItems = self.delegate!.numberOfItemsInMenubar();
                
                for i in 0..<countOfItems {
                    
                    let titleOfItem = self.delegate?.menuBar(self, titleForItemAtIndex: i);
                    
                    let item = UITabBarItem(title: titleOfItem, image: nil, tag: i);
                    
                    items.append(item);
                    
                }
                
                self.menuBar.setItems(items, animated: true);
                
            }
            
        }
        
    }
    
    // MARK: Private Methods
    
    private func commInit() {
        
        self.menuBar = UITabBar();
        
        self.menuBar.delegate = self;
        
        self.addSubview(self.menuBar);
        
        let settings = PLBackdropViewSettingsATVMenuLight();
        
        self.detailView = PLBackdropView(frame: CGRectZero, settings: settings);
        
        self.detailView.subviews[0].autoresizingMask = UIViewAutoresizing.FlexibleWidth.union(UIViewAutoresizing.FlexibleHeight);
        
        self.detailView.backgroundColor = UIColor(white: 1, alpha: 0.3);
        
        self.detailView.clipsToBounds = true;
        
        self.addSubview(self.detailView);
        
        self.borderView = UIView();
        
        self.borderView.backgroundColor = UIColor(red: 135/255, green: 135/255, blue: 135/255, alpha: 0.2);
        
        self.addSubview(self.borderView);
        
    }
    
    // MARK: Init Methods
    
    override public init(frame: CGRect) {
        
        super.init(frame: frame);
        
        self.commInit();
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
     
        super.init(coder: aDecoder);
        
        self.commInit();
        
    }
    
}

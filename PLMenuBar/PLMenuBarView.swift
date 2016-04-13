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

public class PLMenuBarView: UIView, UITabBarDelegate, UITableViewDelegate {
    
    private let MenuBarMinHeight: CGFloat = 140;
    
    private let MenuBarDetailMinHeight: CGFloat = 210;
    
    private let MenuBarDetailPadding: CGFloat = 150;
    
    private let MenuBarBorderHeight: CGFloat = 1.5;
    
    private var shouldShowDetailView: Bool = false;
    
    private var menuBar: UITabBar!;
    
    private var detailView: PLBackdropView!;
    
    private var borderView: UIView!;
    
    private var contentView: UIView?;
    
    public var delegate: PLMenuBarDelegate?;
    
    // MARK: Tabbar Delegate Methods
    
    public func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        
        let index = item.tag;
        
        if self.delegate == nil { return; }
        
        let detailItem = self.delegate!.menuBar?(self, detailItemForItemAtIndex: index);
        
        if detailItem != nil && ((detailItem! is PLMenuDetailDescItem) || (detailItem! is PLMenuDetailComboItem)) {
            
            if detailItem is PLMenuDetailDescItem {
                
                if self.contentView != nil {
                    
                    self.contentView?.removeFromSuperview();
                    
                    self.contentView = nil;
                
                }
                
                let content: UILabel = UILabel(frame: CGRectMake(self.MenuBarDetailPadding, 0, self.bounds.size.width - (self.MenuBarDetailPadding * 2), self.MenuBarDetailMinHeight));
                
                content.numberOfLines = 0;
                
                content.font = UIFont.systemFontOfSize(18);
                
                content.textAlignment = NSTextAlignment.Center;
                
                content.text = (detailItem as! PLMenuDetailDescItem).text;
                
                self.contentView = content;
                
                self.detailView.addSubview(self.contentView!);
                
            }
            
            else if detailItem is PLMenuDetailComboItem {
                
                
                
            }
            
            self.shouldShowDetailView = true;
            
            self.frame = CGRectMake(0, 0, (self.superview?.frame.size.width)!, MenuBarMinHeight + MenuBarBorderHeight);
            
        }
        
        else {
            
            self.shouldShowDetailView = false;
            
            self.frame = CGRectMake(0, 0, (self.superview?.frame.size.width)!, MenuBarMinHeight);
            
        }
        
    }
    
    // MARK: Public Methods
    
    public override func layoutSubviews() {
        
        super.layoutSubviews();
        
        if self.shouldShowDetailView == true {
            
            self.borderView.hidden = false;
            
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                
                self.menuBar.frame = CGRectMake(0, 0, self.frame.size.width, self.MenuBarMinHeight);
                
                self.detailView.frame = CGRectMake(0, self.MenuBarMinHeight, self.frame.size.width, self.MenuBarDetailMinHeight);
                
                self.borderView.frame = CGRectMake(0, self.MenuBarMinHeight, self.frame.size.width, self.MenuBarBorderHeight);
                
                self.borderView.alpha = 1;
                
            }, completion: { (isCompleted: Bool) in
                    
                
                    
            });
            
        }
        
        else {
            
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                
                self.menuBar.frame = CGRectMake(0, 0, self.frame.size.width, self.MenuBarMinHeight);
                
                self.detailView.frame = CGRectMake(0, self.MenuBarMinHeight, self.frame.size.width, 0);
                
                self.borderView.frame = CGRectMake(0, self.MenuBarMinHeight, self.frame.size.width, self.MenuBarBorderHeight);
                
                self.borderView.alpha = 0;
                
            }, completion: { (isCompleted: Bool) in
                    
                self.borderView.hidden = true;
                    
            });
            
        }
        
    }

    public override func willMoveToSuperview(newSuperview: UIView?) {
        
        super.willMoveToSuperview(newSuperview);
        
        if newSuperview != nil {
            
            self.frame = CGRectMake(0, 0, newSuperview!.frame.size.width, MenuBarMinHeight);
            
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
        
        self.addSubview(self.detailView);
        
        self.borderView = UIView();
        
        self.borderView.backgroundColor = UIColor(red: 127/255, green: 127/255, blue: 127/255, alpha: 0.8);
        
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

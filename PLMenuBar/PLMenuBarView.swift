//
//  PLMenuBarView.swift
//  PLMenuBar
//
//  Created by Patrick Lin on 4/12/16.
//  Copyright © 2016 Patrick Lin. All rights reserved.
//

@objc public protocol PLMenuBarDelegate: NSObjectProtocol {
    
    func numberOfItemsInMenubar() -> Int
    
    func menuBar(_ menuBar: PLMenuBarView, titleForItemAtIndex index: Int) -> String
    
    @objc optional func menuBar(_ menuBar: PLMenuBarView, detailItemForItemAtIndex index: Int) -> PLMenuDetailItem
    
    @objc optional func menuBar(_ menuBar: PLMenuBarView, didSelectItemAtIndex index: Int)
    
    @objc optional func menuBar(_ menuBar: PLMenuBarView, didSelectDetailAtRow row: Int, Section section: Int, forItemAtIndex index: Int)
    
}

public enum PLMenuBarViewStyle: UInt32 {
    
    case Light, Dark
    
}

open class PLMenuComboSection: NSObject {
    
    open var preferredIndex: Int = -1
    
    open var title: String = ""
    
    open var items: [String] = [String]()
    
    public override init() {
        
        super.init()
        
    }
    
    public init(title: String = "", items: [String], preferredIndex: Int = -1) {
        
        self.title.append(title)
        
        self.items.append(contentsOf: items)
        
        self.preferredIndex = preferredIndex
        
    }
    
}

open class PLMenuDetailComboItem: PLMenuDetailItem {
    
    open var items: [PLMenuComboSection] = [PLMenuComboSection]()
    
    public init(title: String = "", items: [PLMenuComboSection]) {
        
        super.init(title: title)
        
        self.items.append(contentsOf: items)
        
    }
    
}

open class PLMenuDetailDescItem: PLMenuDetailItem {
    
    open var text: String = ""
    
    public init(title: String = "", text: String = "") {
        
        super.init(title: title)
        
        self.text.append(text)
        
    }
    
}

open class PLMenuDetailItem: NSObject {
    
    open var title: String = ""
    
    public init(title: String = "") {
        
        self.title.append(title)
        
    }
    
}

open class PLMenuBarView: UIView, UITabBarDelegate, UITableViewDelegate, PLMenuDetailComboViewDelegate {
    
    static let MenuBarMinHeight: CGFloat = 140
    
    static let MenuBarDetailMinHeight: CGFloat = 210
    
    static let MenuBarDetailPadding: CGFloat = 150
    
    static let MenuBarBorderHeight: CGFloat = 1
    
    fileprivate var selectedIndexOfItem: Int = -1
    
    fileprivate var shouldShowDetailView: Bool = false
    
    fileprivate var guides: [UIFocusGuide] = [UIFocusGuide]()
    
    fileprivate var menuBar: UITabBar!
    
    fileprivate var detailView: PLBackdropView!
    
    fileprivate var borderView: UIView!
    
    fileprivate var contentView: PLMenuDetailView?
    
    open var style: PLMenuBarViewStyle = .Light {
        didSet
        {
            if oldValue == self.style { return }
            
            self.updateStyle()
        }
    }
    
    open var delegate: PLMenuBarDelegate?
    
    // MARK: Combo Delegate Methods
    
    open func combo(_ combo: PLMenuDetailComboView, didChangeValueAtSection section: Int, Row row: Int) {
        
        self.delegate?.menuBar?(self, didSelectDetailAtRow: row, Section: section, forItemAtIndex: (self.menuBar.selectedItem?.tag)!)
        
    }
    
    // MARK: Tabbar Delegate Methods
    
    open func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        let index = item.tag
        
        if self.delegate == nil || item.tag == self.selectedIndexOfItem { return }
        
        self.selectedIndexOfItem = item.tag
        
        let detailItem = self.delegate!.menuBar?(self, detailItemForItemAtIndex: index)
        
        if detailItem != nil && ((detailItem! is PLMenuDetailDescItem) || (detailItem! is PLMenuDetailComboItem)) {
            
            for (_, guide) in self.guides.enumerated() {
                
                guide.owningView?.removeLayoutGuide(guide)
                
            }
            
            self.guides.removeAll()
            
            if self.contentView != nil {
                
                self.contentView?.removeFromSuperview()
                
                self.contentView = nil
                
            }
            
            let contentFrame = CGRect(x: PLMenuBarView.MenuBarDetailPadding, y: 0, width: self.detailView.bounds.size.width - (PLMenuBarView.MenuBarDetailPadding * 2), height: PLMenuBarView.MenuBarDetailMinHeight)
            
            if detailItem is PLMenuDetailDescItem {
                
                self.contentView = PLMenuDetailDescView(text: (detailItem as! PLMenuDetailDescItem).text)
                
                self.contentView!.frame = contentFrame
                
                self.detailView.addSubview(self.contentView!)
                
            }
            
            else if detailItem is PLMenuDetailComboItem {
                
                self.contentView = PLMenuDetailComboView(items: (detailItem as! PLMenuDetailComboItem).items)
                
                (self.contentView as! PLMenuDetailComboView).delegate = self
                
                self.contentView!.frame = contentFrame
                
                self.detailView.addSubview(self.contentView!)
                
                for (_, sectionView) in self.contentView!.contentViews.enumerated() {
                    
                    for (_, rowView) in (sectionView as! PLMenuDetailComboSectionView).rowViews.enumerated() {
                        
                        let guide = UIFocusGuide()
                        
                        self.addLayoutGuide(guide)
                        
                        guide.preferredFocusedView = rowView.contentBtn
                        
                        guide.topAnchor.constraint(equalTo: rowView.contentBtn.topAnchor).isActive = true
                        
                        guide.leftAnchor.constraint(equalTo: rowView.contentBtn.leftAnchor).isActive = true
                        
                        guide.widthAnchor.constraint(equalTo: rowView.contentBtn.widthAnchor).isActive = true
                        
                        guide.heightAnchor.constraint(equalTo: rowView.contentBtn.heightAnchor).isActive = true
                        
                        self.guides.append(guide)
                        
                    }
                    
                }
                
            }
            
            self.shouldShowDetailView = true
            
            self.frame = CGRect(x: 0, y: 0, width: (self.superview?.frame.size.width)!, height: PLMenuBarView.MenuBarMinHeight + PLMenuBarView.MenuBarDetailMinHeight)
            
        }
        
        else {
            
            self.shouldShowDetailView = false
            
            self.frame = CGRect(x: 0, y: 0, width: (self.superview?.frame.size.width)!, height: PLMenuBarView.MenuBarMinHeight)
            
        }
        
    }
    
    // MARK: Public Methods
    
    open override func layoutSubviews() {
        
        super.layoutSubviews()
        
        if PLMenuBarViewStyle(rawValue: self.detailView.style.rawValue) != self.style {
            
            self.detailView.style = PLBackdropViewStyle(rawValue: self.style.rawValue)
            
        }
        
        if self.shouldShowDetailView == true {

            self.borderView.isHidden = false
            
            self.contentView?.alpha = 0
            
            UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                
                self.menuBar.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: PLMenuBarView.MenuBarMinHeight)
                
                self.detailView.frame = CGRect(x: 0, y: PLMenuBarView.MenuBarMinHeight, width: self.frame.size.width, height: PLMenuBarView.MenuBarDetailMinHeight)
                
                self.contentView?.alpha = 1
                
                self.borderView.frame = CGRect(x: 0, y: PLMenuBarView.MenuBarMinHeight, width: self.frame.size.width, height: PLMenuBarView.MenuBarBorderHeight)
                
                self.borderView.alpha = 1
                
            }, completion: { (isCompleted: Bool) in
                    
                
                    
            })
            
        }
        
        else {
            
            UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                
                self.menuBar.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: PLMenuBarView.MenuBarMinHeight)
                
                self.detailView.frame = CGRect(x: 0, y: PLMenuBarView.MenuBarMinHeight, width: self.frame.size.width, height: 0)
                
                self.contentView?.alpha = 0
                
                self.borderView.frame = CGRect(x: 0, y: PLMenuBarView.MenuBarMinHeight, width: self.frame.size.width, height: PLMenuBarView.MenuBarBorderHeight)
                
                self.borderView.alpha = 0
                
            }, completion: { (isCompleted: Bool) in
                    
                self.borderView.isHidden = true
                    
            })
            
        }
        
    }

    open override func willMove(toSuperview newSuperview: UIView?) {
        
        super.willMove(toSuperview: newSuperview)
        
        if newSuperview != nil {
            
            self.frame = CGRect(x: 0, y: 0, width: newSuperview!.frame.size.width, height: PLMenuBarView.MenuBarMinHeight)
            
            if delegate != nil {
                
                var items: [UITabBarItem] = [UITabBarItem]()
                
                let countOfItems = self.delegate!.numberOfItemsInMenubar()
                
                for i in 0..<countOfItems {
                    
                    let titleOfItem = self.delegate?.menuBar(self, titleForItemAtIndex: i)
                    
                    let item = UITabBarItem(title: titleOfItem, image: nil, tag: i)
                    
                    items.append(item)
                    
                }
                
                self.menuBar.setItems(items, animated: true)
                
            }
            
        }
        
    }
    
    // MARK: Private Methods
    
    fileprivate func commonInit() {
        
        self.menuBar = UITabBar()
        
        self.menuBar.delegate = self
        
        self.addSubview(self.menuBar)
        
        let settings = PLBackdropViewSettingsATVMenuLight()
        
        self.detailView = PLBackdropView(frame: CGRect.zero, settings: settings)
        
        self.detailView.subviews[0].autoresizingMask = UIViewAutoresizing.flexibleWidth.union(UIViewAutoresizing.flexibleHeight)
        
        self.detailView.clipsToBounds = true
        
        self.addSubview(self.detailView)
        
        self.borderView = UIView()
        
        self.addSubview(self.borderView)
        
        self.updateStyle()
        
    }
    
    fileprivate func updateStyle() {
        
        if self.style == .Light {
            
            self.borderView.backgroundColor = UIColor(red: 135/255, green: 135/255, blue: 135/255, alpha: 0.2)
            
            self.detailView.backgroundColor = UIColor(white: 1, alpha: 0.3)
            
        }
        
        else if self.style == .Dark {
            
            self.detailView.backgroundColor = UIColor(white: 1, alpha: 0.3)
            
            self.borderView.backgroundColor = UIColor(red: 135/255, green: 135/255, blue: 135/255, alpha: 0.2)
            
        }
        
    }
    
    // MARK: Init Methods
    
    override public init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.commonInit()
    
    }
    
    required public init?(coder aDecoder: NSCoder) {
     
        super.init(coder: aDecoder)
        
        self.commonInit()
        
    }
    
}

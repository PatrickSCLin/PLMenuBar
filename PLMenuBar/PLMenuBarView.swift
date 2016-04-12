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
    
    optional func menuBar(menuBar: PLMenuBarView, didSelectItemAtIndex index: Int);
    
}

public class PLMenuBarView: UIView, UITabBarDelegate {
    
    private var menuBar: UITabBar!;
    
    private var detailView: UIVisualEffectView!;
    
    private var borderView: UIView!;
    
    public var delegate: PLMenuBarDelegate?;
    
    // MARK: Tabbar Delegate Methods
    
    public func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        
        self.frame = CGRectMake(0, 0, self.superview!.frame.size.width, 300);
     
        self.detailView.frame = CGRectMake(0, 140, self.superview!.frame.size.width, 160);
        
        self.borderView.frame = CGRectMake(0, 140, self.superview!.frame.size.width, 2);
        
    }
    
    // MARK: Public Methods
    
    public override func layoutSubviews() {
        
        super.layoutSubviews();
        
        self.menuBar.frame = CGRectMake(0, 0, self.frame.size.width, 140);
        
    }

    public override func willMoveToSuperview(newSuperview: UIView?) {
        
        super.willMoveToSuperview(newSuperview);
        
        if newSuperview != nil {
            
            self.frame = CGRectMake(0, 0, newSuperview!.frame.size.width, 140);
            
            if delegate != nil {
                
                var items: [UITabBarItem] = [UITabBarItem]();
                
                let countOfItems = self.delegate?.numberOfItemsInMenubar();
                
                for (var i = 0; i < countOfItems; i++) {
                    
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
        
        self.detailView = UIVisualEffectView(effect: UIVibrancyEffect(forBlurEffect: UIBlurEffect(style: UIBlurEffectStyle.Light)));
        
        self.detailView.backgroundColor = UIColor(red: 180/255, green: 189/255, blue: 190/255, alpha: 0.74);
        
        self.addSubview(self.detailView);
        
        self.borderView = UIView();
        
        self.borderView.backgroundColor = UIColor(red: 180/255, green: 189/255, blue: 190/255, alpha: 1);
        
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

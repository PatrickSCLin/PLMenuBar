//
//  PLMenuDetailDescView.swift
//  PLMenuBar
//
//  Created by Patrick Lin on 4/13/16.
//  Copyright © 2016 Patrick Lin. All rights reserved.
//

class PLMenuDetailDescView: PLMenuDetailView {
    
    var text: String = "";
    
    // MARK: Public Methods
    
    override func layoutSubviews() {
        
        super.layoutSubviews();
        
        CGRectMake(PLMenuBarView.MenuBarDetailPadding, 0, self.bounds.size.width - (PLMenuBarView.MenuBarDetailPadding * 2), PLMenuBarView.MenuBarDetailMinHeight)
        
    }
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        
        if newSuperview != nil {
            
            
            
        }
        
    }
    
    // MARK: Init Methods
    
    func commonInit() {
        
        let content: UILabel = UILabel();
        
        content.numberOfLines = 0;
        
        content.font = UIFont.systemFontOfSize(18);
        
        content.textAlignment = NSTextAlignment.Justified;
        
        content.text = self.text;
        
        self.addSubview(content);
        
    }
    
    convenience init(text: String) {
        
        self.init(frame: CGRectZero);
        
        self.text.appendContentsOf(text);
        
    }

}

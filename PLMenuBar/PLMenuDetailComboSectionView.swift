//
//  PLMenuDetailComboSectionView.swift
//  PLMenuBar
//
//  Created by Patrick Lin on 4/13/16.
//  Copyright © 2016 Patrick Lin. All rights reserved.
//

class PLMenuDetailComboSectionView: UIView {
    
    var item: PLMenuComboSection = PLMenuComboSection();
    
    var titleView: UILabel = UILabel();
    
    // MARK: Public Methods
    
    override func layoutSubviews() {
        
        super.layoutSubviews();
        
        self.titleView.frame = CGRectMake(30, 20, self.bounds.size.width - 30, 40);
        
    }
    
    // MARK: Init Methods
    
    func commonInit() {
    
        titleView.font = UIFont.boldSystemFontOfSize(18);
        
        titleView.alpha = 0.4;
        
        titleView.textAlignment = NSTextAlignment.Left;
        
        titleView.text = self.item.title;
        
        self.addSubview(titleView);
        
    }
    
    convenience init(item: PLMenuComboSection) {
        
        self.init(frame: CGRectZero);
        
        self.item.title = item.title;
        
        self.item.items.appendContentsOf(item.items);
        
        self.commonInit();
        
    }

}

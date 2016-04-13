//
//  PLMenuDetailComboView.swift
//  PLMenuBar
//
//  Created by Patrick Lin on 4/13/16.
//  Copyright © 2016 Patrick Lin. All rights reserved.
//

class PLMenuDetailComboView: PLMenuDetailView {

    var items: [PLMenuComboSection] = [PLMenuComboSection]();
    
    // MARK: Public Methods
    
    override func layoutSubviews() {
        
        super.layoutSubviews();
        
        let contentWidth = self.bounds.size.width / CGFloat(self.items.count);
        
        let contentHeight = self.bounds.size.height;
        
        for (index, content) in self.contentViews.enumerate() {
            
            content.frame = CGRectMake(contentWidth * CGFloat(index), 0, contentWidth, contentHeight);
            
        }
        
    }
    
    // MARK: Init Methods
    
    func commonInit() {
        
        for (_, item) in self.items.enumerate() {
            
            let content = PLMenuDetailComboSectionView(item: item);
            
            self.addSubview(content);
            
            self.contentViews.append(content);
            
        }
        
    }
    
    convenience init(items: [PLMenuComboSection]) {
        
        self.init(frame: CGRectZero);
        
        self.items.appendContentsOf(items);
        
        self.commonInit();
        
    }
    
}

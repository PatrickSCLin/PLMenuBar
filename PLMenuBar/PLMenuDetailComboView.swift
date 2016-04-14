//
//  PLMenuDetailComboView.swift
//  PLMenuBar
//
//  Created by Patrick Lin on 4/13/16.
//  Copyright © 2016 Patrick Lin. All rights reserved.
//

@objc public protocol PLMenuDetailComboViewDelegate: NSObjectProtocol {
    
    func combo(combo: PLMenuDetailComboView, didChangeValueAtSection section: Int, Row row: Int);
    
}

public class PLMenuDetailComboView: PLMenuDetailView, PLMenuDetailComboSectionViewDelegate {

    var items: [PLMenuComboSection] = [PLMenuComboSection]();
    
    public var delegate: PLMenuDetailComboViewDelegate?;
    
    // MARK: Combo Section Delegate Methods
    
    func section(section: PLMenuDetailComboSectionView, didChangeValueAtRow row: Int) {
        
        for (indexOfSection, sectionView) in self.contentViews.enumerate() {
            
            if sectionView == section {
                
                self.delegate?.combo(self, didChangeValueAtSection: indexOfSection, Row: row);
                
                break;
                
            }
            
        }
        
    }
    
    // MARK: Public Methods
    
    override public func layoutSubviews() {
        
        super.layoutSubviews();
        
        let contentWidth = self.bounds.size.width / CGFloat(self.items.count);
        
        let contentHeight = self.bounds.size.height;
        
        for (index, content) in self.contentViews.enumerate() {
            
            content.frame = CGRectMake(contentWidth * CGFloat(index), 0, contentWidth, contentHeight);
            
        }
        
    }
    
    override public func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        
        if context.nextFocusedView != nil {
            
            for (_, contentView) in self.contentViews.enumerate() {
                
                let sectionView = contentView as! PLMenuDetailComboSectionView;
                
                for (_, rowView) in sectionView.rowViews.enumerate() {
                    
                    if rowView.contentBtn === context.nextFocusedView! {
                        
                        rowView.isHighLighted = true;
                        
                    }
                    
                }
                
            }
            
        }
        
        if context.previouslyFocusedView != nil {
            
            for (_, contentView) in self.contentViews.enumerate() {
                
                let sectionView = contentView as! PLMenuDetailComboSectionView;
                
                for (_, rowView) in sectionView.rowViews.enumerate() {
                    
                    if rowView.contentBtn === context.previouslyFocusedView! {
                        
                        rowView.isHighLighted = false;
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    // MARK: Init Methods
    
    func commonInit() {
        
        for (_, item) in self.items.enumerate() {
            
            let content = PLMenuDetailComboSectionView(item: item);
            
            content.delegate = self;
            
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

//
//  PLMenuDetailComboView.swift
//  PLMenuBar
//
//  Created by Patrick Lin on 4/13/16.
//  Copyright © 2016 Patrick Lin. All rights reserved.
//

@objc public protocol PLMenuDetailComboViewDelegate: NSObjectProtocol {
    
    func combo(_ combo: PLMenuDetailComboView, didChangeValueAtSection section: Int, Row row: Int)
    
}

open class PLMenuDetailComboView: PLMenuDetailView, PLMenuDetailComboSectionViewDelegate {

    var items: [PLMenuComboSection] = [PLMenuComboSection]()
    
    open var delegate: PLMenuDetailComboViewDelegate?
    
    // MARK: Combo Section Delegate Methods
    
    func section(_ section: PLMenuDetailComboSectionView, didChangeValueAtRow row: Int) {
        
        for (indexOfSection, sectionView) in self.contentViews.enumerated() {
            
            if sectionView == section {
                
                self.delegate?.combo(self, didChangeValueAtSection: indexOfSection, Row: row)
                
                break
                
            }
            
        }
        
    }
    
    // MARK: Public Methods
    
    override open func layoutSubviews() {
        
        super.layoutSubviews()
        
        let contentWidth = self.bounds.size.width / CGFloat(self.items.count)
        
        let contentHeight = self.bounds.size.height
        
        for (index, content) in self.contentViews.enumerated() {
            
            content.frame = CGRect(x: contentWidth * CGFloat(index), y: 0, width: contentWidth, height: contentHeight)
            
        }
        
    }
    
    override open func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
        if context.nextFocusedView != nil {
            
            for (_, contentView) in self.contentViews.enumerated() {
                
                let sectionView = contentView as! PLMenuDetailComboSectionView
                
                for (_, rowView) in sectionView.rowViews.enumerated() {
                    
                    if rowView.contentBtn === context.nextFocusedView! {
                        
                        rowView.isHighLighted = true
                        
                    }
                    
                }
                
            }
            
        }
        
        if context.previouslyFocusedView != nil {
            
            for (_, contentView) in self.contentViews.enumerated() {
                
                let sectionView = contentView as! PLMenuDetailComboSectionView
                
                for (_, rowView) in sectionView.rowViews.enumerated() {
                    
                    if rowView.contentBtn === context.previouslyFocusedView! {
                        
                        rowView.isHighLighted = false
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    // MARK: Init Methods
    
    func commonInit() {
        
        for (_, item) in self.items.enumerated() {
            
            let content = PLMenuDetailComboSectionView(item: item)
            
            content.delegate = self
            
            self.addSubview(content)
            
            self.contentViews.append(content)
            
        }
        
    }
    
    convenience init(items: [PLMenuComboSection]) {
        
        self.init(frame: CGRect.zero)
        
        self.items.append(contentsOf: items)
        
        self.commonInit()
        
    }
    
}

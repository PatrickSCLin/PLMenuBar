//
//  PLMenuDetailComboSectionView.swift
//  PLMenuBar
//
//  Created by Patrick Lin on 4/13/16.
//  Copyright © 2016 Patrick Lin. All rights reserved.
//

@objc protocol PLMenuDetailComboSectionViewDelegate: NSObjectProtocol {
    
    func section(_ section: PLMenuDetailComboSectionView, didChangeValueAtRow row: Int)
    
}

class PLMenuDetailComboSectionView: UIView {
    
    var item: PLMenuComboSection = PLMenuComboSection()
    
    var titleView: UILabel = UILabel()
    
    var rowViews: [PLMenuDetailComboRowView] = [PLMenuDetailComboRowView]()
    
    var selectedIndexOfRow: Int = -1
    
    var delegate: PLMenuDetailComboSectionViewDelegate?
    
    // MARK: Public Methods
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.titleView.frame = CGRect(x: 40, y: 20, width: self.bounds.size.width - 40, height: 40)
        
        for (index, rowView) in self.rowViews.enumerated() {
            
            rowView.frame = CGRect(x: 0, y: 70 + CGFloat(60 * index), width: self.bounds.size.width, height: 40)
            
        }
        
    }
    
    // MARK: Private Methods
    
    func didPrimaryAction(_ sender: UIButton) {
        
        for (indexOfRow, rowView) in self.rowViews.enumerated() {
            
            if rowView.contentBtn == sender {
                
                if rowView.isSelected == false {
                    
                    rowView.isSelected = true
                    
                    self.delegate?.section(self, didChangeValueAtRow: indexOfRow)
                    
                }
                
            }
            
            else {
                
                rowView.isSelected = false
                
            }
            
        }
        
    }
    
    // MARK: Init Methods
    
    func commonInit() {
    
        titleView.font = UIFont.boldSystemFont(ofSize: 18)
        
        titleView.alpha = 0.4
        
        titleView.textAlignment = NSTextAlignment.left
        
        titleView.text = self.item.title
        
        self.addSubview(titleView)
        
        for (indexOfRow, titleOfRow) in self.item.items.enumerated() {
            
            let rowView = PLMenuDetailComboRowView(title: titleOfRow)
            
            rowView.isSelected = (indexOfRow == self.selectedIndexOfRow) ? true : false
            
            self.addSubview(rowView)
            
            self.rowViews.append(rowView)
            
            rowView.contentBtn.addTarget(self, action: #selector(PLMenuDetailComboSectionView.didPrimaryAction(_:)), for: UIControlEvents.primaryActionTriggered)
            
        }
        
    }
    
    convenience init(item: PLMenuComboSection) {
        
        self.init(frame: CGRect.zero)
        
        self.item.title.append(item.title)
        
        self.item.items.append(contentsOf: item.items)
        
        self.selectedIndexOfRow = item.preferredIndex
        
        self.commonInit()
        
    }

}

//
//  PLMenuDetailComboSectionView.swift
//  PLMenuBar
//
//  Created by Patrick Lin on 4/13/16.
//  Copyright © 2016 Patrick Lin. All rights reserved.
//

@objc protocol PLMenuDetailComboSectionViewDelegate: NSObjectProtocol {
    
    func section(section: PLMenuDetailComboSectionView, didChangeValueAtRow row: Int);
    
}

class PLMenuDetailComboSectionView: UIView {
    
    var item: PLMenuComboSection = PLMenuComboSection();
    
    var titleView: UILabel = UILabel();
    
    var rowViews: [PLMenuDetailComboRowView] = [PLMenuDetailComboRowView]();
    
    var selectedIndexOfRow: Int = -1;
    
    var delegate: PLMenuDetailComboSectionViewDelegate?;
    
    // MARK: Public Methods
    
    override func layoutSubviews() {
        
        super.layoutSubviews();
        
        self.titleView.frame = CGRectMake(40, 20, self.bounds.size.width - 40, 40);
        
        for (index, rowView) in self.rowViews.enumerate() {
            
            rowView.frame = CGRectMake(0, 70 + CGFloat(60 * index), self.bounds.size.width, 40);
            
        }
        
    }
    
    // MARK: Private Methods
    
    func didPrimaryAction(sender: UIButton) {
        
        for (indexOfRow, rowView) in self.rowViews.enumerate() {
            
            if rowView.contentBtn == sender {
                
                if rowView.isSelected == false {
                    
                    rowView.isSelected = true;
                    
                    self.delegate?.section(self, didChangeValueAtRow: indexOfRow);
                    
                }
                
            }
            
            else {
                
                rowView.isSelected = false;
                
            }
            
        }
        
    }
    
    // MARK: Init Methods
    
    func commonInit() {
    
        titleView.font = UIFont.boldSystemFontOfSize(18);
        
        titleView.alpha = 0.4;
        
        titleView.textAlignment = NSTextAlignment.Left;
        
        titleView.text = self.item.title;
        
        self.addSubview(titleView);
        
        for (indexOfRow, titleOfRow) in self.item.items.enumerate() {
            
            let rowView = PLMenuDetailComboRowView(title: titleOfRow);
            
            rowView.isSelected = (indexOfRow == self.selectedIndexOfRow) ? true : false;
            
            self.addSubview(rowView);
            
            self.rowViews.append(rowView);
            
            rowView.contentBtn.addTarget(self, action: #selector(PLMenuDetailComboSectionView.didPrimaryAction(_:)), forControlEvents: UIControlEvents.PrimaryActionTriggered);
            
        }
        
    }
    
    convenience init(item: PLMenuComboSection) {
        
        self.init(frame: CGRectZero);
        
        self.item.title.appendContentsOf(item.title);
        
        self.item.items.appendContentsOf(item.items);
        
        self.selectedIndexOfRow = item.preferredIndex;
        
        self.commonInit();
        
    }

}

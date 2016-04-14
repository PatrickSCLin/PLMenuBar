//
//  PLMenuDetailComboRowView.swift
//  PLMenuBar
//
//  Created by Patrick Lin on 4/14/16.
//  Copyright © 2016 Patrick Lin. All rights reserved.
//

class PLMenuDetailComboRowView: UIView {
    
    var title: String = "";
    
    var isSelected: Bool = false {
        didSet
        {
            if self.isSelected != oldValue {
                
                self.updateStyle();
                
            }
        }
    }
    
    var isHighLighted: Bool = false {
        didSet
        {
            self.updateStyle();
        }
    }
    
    var checkBoxView: UIImageView = UIImageView();
    
    var contentBtn: UIButton = UIButton();
    
    // MARK: Public Methods
    
    override func layoutSubviews() {
        
        super.layoutSubviews();
        
        self.checkBoxView.frame = CGRectMake(8, 0, 22, self.bounds.size.height);
        
        self.contentBtn.frame = CGRectMake(30, 0, self.bounds.size.width - 30, self.bounds.size.height);
        
    }
    
    // MRK: Private Methods
    
    func updateStyle() {
        
        self.checkBoxView.hidden = !self.isSelected;
        
        let color = (self.isHighLighted == true) ? UIColor.whiteColor() : UIColor(red: 39/255, green: 33/255, blue: 29/255, alpha: 0.7);
        
        self.checkBoxView.tintColor = color;
        
        self.contentBtn.setTitleColor(color, forState: UIControlState.Normal);
        
    }
    
    // MARK: Init Methods
    
    func commonInit() {
        
        self.contentBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left;
        
        self.contentBtn.setTitle(title, forState: UIControlState.Normal);
        
        if self.contentBtn.titleLabel != nil {
            
            self.contentBtn.titleLabel!.font = UIFont.boldSystemFontOfSize(28);
            
            self.contentBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0);
            
        }
        
        self.addSubview(self.contentBtn);
        
        let bundle = NSBundle(forClass: PLMenuDetailComboRowView.self);
        
        var image = UIImage(named: "button-check.png", inBundle: bundle, compatibleWithTraitCollection: nil);
        
        image = image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate);
        
        if image != nil {
            
            self.checkBoxView.image = image!;
            
            self.checkBoxView.contentMode = UIViewContentMode.ScaleAspectFit;
            
        }
        
        self.addSubview(self.checkBoxView);
        
        self.updateStyle();
        
    }
    
    convenience init(title: String) {
        
        self.init(frame: CGRectZero);
        
        self.title.appendContentsOf(title);
        
        self.commonInit();
        
    }

}

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
            
        }
    }
    
    var contentBtn: UIButton = UIButton();
    
    // MARK: Public Methods
    
    override func layoutSubviews() {
        
        super.layoutSubviews();
        
        self.contentBtn.frame = self.bounds;
        
    }
    
    // MARK: Init Methods
    
    func commonInit() {
        
        self.contentBtn.setTitle(title, forState: UIControlState.Normal);
        
        self.contentBtn.titleLabel?.font = UIFont.boldSystemFontOfSize(32);
        
        self.contentBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: -750, bottom: 0, right: 0);
        
        let bundle = NSBundle(forClass: PLMenuDetailComboRowView.self);
        
        let image = UIImage(named: "button-check.png", inBundle: bundle, compatibleWithTraitCollection: nil);
        
        print("image: \(image)");
        
        self.contentBtn.setImage(image, forState: UIControlState.Normal);
        
        self.contentBtn.imageView?.contentMode = UIViewContentMode.ScaleAspectFit;
        
        self.contentBtn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 760);
        
        self.contentBtn.layer.borderWidth = 1;
        
        self.addSubview(self.contentBtn);
        
    }
    
    convenience init(title: String) {
        
        self.init(frame: CGRectZero);
        
        self.title.appendContentsOf(title);
        
        self.commonInit();
        
    }

}

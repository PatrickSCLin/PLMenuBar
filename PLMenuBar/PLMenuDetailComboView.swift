//
//  PLMenuDetailComboView.swift
//  PLMenuBar
//
//  Created by Patrick Lin on 4/13/16.
//  Copyright © 2016 Patrick Lin. All rights reserved.
//

class PLMenuDetailComboView: PLMenuDetailView {

    var items: [PLMenuComboSection] = [PLMenuComboSection]();
    
    convenience init(items: [PLMenuComboSection]) {
        
        self.init(frame: CGRectZero);
        
        self.items.appendContentsOf(items);
        
    }
    
}

//
//  ViewController.swift
//  PLMenuDemo
//
//  Created by Patrick Lin on 4/12/16.
//  Copyright © 2016 Patrick Lin. All rights reserved.
//

import UIKit
import PLMenuBar

class ViewController: UIViewController, PLMenuBarDelegate {
    
    var menuBar: PLMenuBarView!;
    
    func numberOfItemsInMenubar() -> Int {
        
        return 2;
        
    }
    
    func menuBar(menuBar: PLMenuBarView, titleForItemAtIndex index: Int) -> String {
        
        var title = "";
        
        switch index {
            
        case 0:
            
            title = "Stream"
            
            break;
            
        case 1:
            
            title = "Audio"
            
            break;
            
        default:
            
            break;
            
        }
        
        return title;
        
    }

    override func viewDidLoad() {
        
        super.viewDidLoad();
        
        self.menuBar = PLMenuBarView();
        
        self.menuBar.delegate = self;
        
        self.view.addSubview(menuBar);
        
    }
    
}


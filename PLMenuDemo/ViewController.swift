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
    
    var menuDetailItems: [PLMenuDetailItem]!;
    
    // MARK: PLMenuBar Delegate Methods
    
    func numberOfItemsInMenubar() -> Int {
        
        return self.menuDetailItems.count;
        
    }
    
    func menuBar(menuBar: PLMenuBarView, titleForItemAtIndex index: Int) -> String {
        
        return self.menuDetailItems[index].title;
        
    }
    
    func menuBar(menuBar: PLMenuBarView, detailItemForItemAtIndex index: Int) -> PLMenuDetailItem {
        
        return self.menuDetailItems[index];
        
    }
    
    func menuBar(menuBar: PLMenuBarView, didSelectDetailAtRow row: Int, Section section: Int, forItemAtIndex index: Int) {
        
        print("index: \(index), section: \(section), row: \(row)");
        
        ((self.menuDetailItems[index] as! PLMenuDetailComboItem).items[section]).preferredIndex = row;
        
    }

    
    // MARK: Init Methods

    override func viewDidLoad() {
        
        super.viewDidLoad();
        
        let testString = "Every page in a client-server app is built on a TVML template. TVML templates define what elements can be used and in what order. Each template is designed to display information in a specific way. For example, the loadingTemplate shows a spinner and a quick description of what is happening, while the ratingTemplate shows the rating for a product. You create a new TVML file that contains a single template for each page in a client-server app. Each template page occupies the entire TV screen. \n\nEach template page uses compound and simple elements. Compound elements contain other elements, while simple elements are single lines of TVML. Elements contain the information and images that are displayed on the screen.";
        
        self.menuDetailItems = [
            PLMenuDetailDescItem(title: "TabBarItem with Desc", text: testString),
            PLMenuDetailItem(title: "TabBarItem with Nothing"),
            PLMenuDetailComboItem(title: "TabBarItem with Combo", items: [
                PLMenuComboSection(title: "Section1", items: ["option1", "option2"], preferredIndex: 1),
                PLMenuComboSection(title: "Section2", items: ["option1", "option2"], preferredIndex: 0),
                PLMenuComboSection(title: "Section3", items: ["option1", "option2"], preferredIndex: 1),
                PLMenuComboSection(title: "Section4", items: ["option1", "option2"], preferredIndex: 0),
                PLMenuComboSection(title: "Section5", items: ["option1", "option2"], preferredIndex: 1),
            ])
        ];
        
        self.menuBar = PLMenuBarView();
        
        self.menuBar.delegate = self;
        
        self.view.addSubview(menuBar);
    
    }
    
}


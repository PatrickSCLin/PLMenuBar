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
    
    func numberOfItemsInMenubar() -> Int {
        
        return self.menuDetailItems.count;
        
    }
    
    func menuBar(menuBar: PLMenuBarView, titleForItemAtIndex index: Int) -> String {
        
        return self.menuDetailItems[index].title;
        
    }
    
    func menuBar(menuBar: PLMenuBarView, detailItemForItemAtIndex index: Int) -> PLMenuDetailItem {
        
        return self.menuDetailItems[index];
        
    }

    override func viewDidLoad() {
        
        super.viewDidLoad();
        
//        let testString = "The audio element is used to play background audio for a document when the document is the top-most document in the navigation stack. Each document page that plays audio in the background must have its own audio element. If the same URL is used between pages, audio will continue to play when the new page is displayed. The audio element only supports unencrypted audio. audio can contain the following elements:";
//        
//        self.menuDetailItems = [
//            PLMenuDetailDescItem(title: "Info", text: testString),
//            PLMenuDetailItem(title: "Empty"),
//            PLMenuDetailComboItem(title: "Options", items: [
//                PLMenuComboSection(title: "Stream", items: ["Stream1", "Stream2"], preferredIndex: 1),
//                PLMenuComboSection(title: "Audio", items: ["On", "Off"], preferredIndex: 1)
//            ])
//        ];
        
        self.menuDetailItems = [
            PLMenuDetailComboItem(title: "Options", items: [
                PLMenuComboSection(title: "Stream", items: ["Stream1", "Stream2"], preferredIndex: 1),
                PLMenuComboSection(title: "Audio", items: ["On", "Off"], preferredIndex: 1)
            ])
        ];
        
        self.menuBar = PLMenuBarView();
        
        self.menuBar.delegate = self;
        
        self.view.addSubview(menuBar);
        
    }
    
}


#PLMenuBar 

PLMenuBar is a customized menubar for tvOS, simple and easy to use.

####Snapshots

Desc View             |  Combo View
:-------------------------:|:-------------------------:
![](http://i.imgur.com/KehrJI3.png)  |  ![](http://i.imgur.com/t3izApR.png)

####Requirement 

 - XCode 7.3

####Support

 - Support desc detail view
 - Support combo detail view
 - Magic

####Delegate

```swift
@objc public protocol PLMenuBarDelegate: NSObjectProtocol {
    
    func numberOfItemsInMenubar() -> Int;
    
    func menuBar(menuBar: PLMenuBarView, titleForItemAtIndex index: Int) -> String;
    
    optional func menuBar(menuBar: PLMenuBarView, detailItemForItemAtIndex index: Int) -> PLMenuDetailItem;
    
    optional func menuBar(menuBar: PLMenuBarView, didSelectItemAtIndex index: Int);
    
    optional func menuBar(menuBar: PLMenuBarView, didSelectDetailAtRow row: Int, Section section: Int, forItemAtIndex index: Int);
    
}
```

####Usage

```swift
self.menuDetailItems = [
    PLMenuDetailDescItem(title: "TabBarItem with Desc", text: "Hello, World"),
    PLMenuDetailItem(title: "TabBarItem with Nothing"),
    PLMenuDetailComboItem(title: "TabBarItem with Combo", items: [
        PLMenuComboSection(title: "Section1", items: ["option1", "option2"], preferredIndex: 1),
        PLMenuComboSection(title: "Section2", items: ["option1", "option2"], preferredIndex: 0)
    ])
];

self.menuBar = PLMenuBarView();

self.menuBar.delegate = self;

self.view.addSubview(menuBar);
```

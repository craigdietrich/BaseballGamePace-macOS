//
//  gameView.swift
//  BaseballGamePace
//
//  Created by Craig Dietrich on 9/30/19.
//  Copyright © 2019 craigdietrich.com. All rights reserved.
//

import Cocoa

class gameView: NSView {

    @IBOutlet var customView: NSView!
    @IBOutlet weak var AwayLabel: NSTextField!
    @IBOutlet weak var HomeLabel: NSTextField!
    
    public func gameValues(game: NSObject) {
        AwayLabel.stringValue = game.value(forKey: "away") as! String
        HomeLabel.stringValue = game.value(forKey: "home") as! String
    }

    // https://samwize.com/2018/11/21/creating-a-custom-nsview-with-xib/
    // https://www.youtube.com/watch?v=Wx7qk2oOV48
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setup()
    }

    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        setup()
    }

    private func setup() {
        let bundle = Bundle(for: type(of: self))
        let nib = NSNib(nibNamed: .init(String(describing: type(of: self))), bundle: bundle)!
        nib.instantiate(withOwner: self, topLevelObjects: nil)
        addSubview(customView)
        //customView.wantsLayer = true
        //customView.layer?.backgroundColor = NSColor.blue.cgColor
        //customView.widthAnchor.constraint(equalToConstant: 115.0).isActive = true
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
}

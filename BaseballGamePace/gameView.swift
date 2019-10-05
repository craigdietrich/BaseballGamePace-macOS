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
    @IBOutlet weak var FrameLabel: NSTextField!
    @IBOutlet weak var InningLabel: NSTextField!
    @IBOutlet weak var StartLabel: NSTextField!
    @IBOutlet weak var PaceLabel: NSTextField!
    
    public func gameValues(game: NSObject) {
        customView.isHidden = false
        AwayLabel.stringValue = game.value(forKey: "away") as! String
        HomeLabel.stringValue = game.value(forKey: "home") as! String
        FrameLabel.stringValue = ("Top" == game.value(forKey: "frame") as! String) ? "Top" : "Bot"
        InningLabel.stringValue = (game.value(forKey: "inning") as? String) ?? ""
        let isOver = game.value(forKey: "is_over") as! Bool
        if isOver {
            FrameLabel.stringValue = ""
            InningLabel.stringValue = ""
            PaceLabel.stringValue = "Complete"
            customView.alphaValue = 0.6
        } else {
            PaceLabel.stringValue = "+ 20 min"
            PaceLabel.textColor = NSColor.red
        }
        // Pace   https://stackoverflow.com/questions/38641982/converting-date-between-timezones-swift
    }

    internal func color() -> NSColor {
        
        return NSColor.red
        
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
        customView.isHidden = true
        //self.wantsLayer = true
        //self.layer?.backgroundColor = NSColor.red.cgColor
 
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
}

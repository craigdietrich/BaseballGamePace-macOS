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
        let isOver = game.value(forKey: "is_over") as! Bool
        let hasStarted = getHasStarted(utcTime:((game.value(forKey: "start") as? String)!))
        if isOver {  // Over
            FrameLabel.stringValue = ""
            InningLabel.stringValue = ""
            PaceLabel.stringValue = "Complete"
            customView.alphaValue = 0.6
        } else if (hasStarted) {  // In progress
            FrameLabel.stringValue = ("Top" == game.value(forKey: "frame") as! String) ? "Top" : "Bot"
            InningLabel.stringValue = (game.value(forKey: "inning") as? String) ?? ""
            StartLabel.stringValue = getStartTime(utcTime:((game.value(forKey: "start") as? String)!))
            PaceLabel.stringValue = getPace()
            PaceLabel.textColor = getColor()
        } else {  // Yet to begin
            FrameLabel.stringValue = ("Top" == game.value(forKey: "frame") as! String) ? "Top" : "Bot"
            InningLabel.stringValue = (game.value(forKey: "inning") as? String) ?? ""
            StartLabel.stringValue = getStartTime(utcTime:((game.value(forKey: "start") as? String)!))
        }
    }
    
    internal func getHasStarted(utcTime: String) -> Bool {
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.timeZone = TimeZone.current
        dateFormatterPrint.dateFormat = "HHmm"
        let datee = dateFormatterGet.date(from: utcTime)
        let startTime =  dateFormatterPrint.string(from: datee ?? Date())
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "HHmm"
        let currentTime =  dateFormatter.string(from: Date())
        print("Current time "+currentTime+" vs start time "+startTime)
        
        if (currentTime < startTime) {
            return false
        } else {
            return true
        }
        
    }
    
    internal func getStartTime(utcTime: String) -> String {
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.timeZone = TimeZone.current
        dateFormatterPrint.dateFormat = "h:mm a"
        let datee = dateFormatterGet.date(from: utcTime)
        let localDate =  dateFormatterPrint.string(from: datee ?? Date())
        print(utcTime + " -> " + localDate)
        return localDate
        
    }
    
    internal func getPace() -> String {
        
        return "Even"
        
    }
    
    internal func getColor() -> NSColor {
        
        return NSColor.orange
        
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

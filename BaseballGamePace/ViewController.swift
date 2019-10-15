//
//  ViewController.swift
//  BaseballGamePace
//
//  Created by Craig Dietrich on 9/27/19.
//  Copyright © 2019 craigdietrich.com. All rights reserved.
//

import Cocoa

extension NSLayoutConstraint {
    override public var description: String {
        let id = identifier ?? ""
        return "id: \(id), constant: \(constant)"
    }
}

class ViewController: NSViewController {

    @IBOutlet weak var gameStackView: NSStackView!
    @IBOutlet weak var currentTimeLabel: NSTextField!
    var timer: Timer?
    var timeout: Double = 30.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        go()
    }

    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    internal func go() {
        timer?.invalidate()
        let json = getJsonFromUrl()
        parseData(json: json)
        updateCurrentTime()
        timer = Timer.scheduledTimer(timeInterval: timeout, target: self, selector: #selector(loop), userInfo: nil, repeats: true)
    }
    
    @objc internal func loop() {  // In order to be able to compile to < OS10.12
        let json = getJsonFromUrl()
        parseData(json: json)
        updateCurrentTime()
    }
    
    internal func getJsonFromUrl() -> Array<Any> {  // https://developer.apple.com/swift/blog/?id=37
        let feed = ""
        let url = URL(string: feed)
        do {
            let contents = try String(contentsOf: url!)
            let data = Data(contents.utf8)
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            return json as! Array
        } catch {
            // TODO: contents could not be loaded
        }
        return []
    }
    
    internal func parseData(json: Array<Any>) {
        
        // Rmmove existing
        while let first = gameStackView.arrangedSubviews.first {
            gameStackView.removeArrangedSubview(first)
            first.removeFromSuperview()
        }
        // Add per row
        var numRows: Double = Double(json.count / 3)
        numRows.round(.down)
        numRows = numRows - 1
        if json.count % 3 > 0 {
            numRows = numRows + 1
        }
        for j in 0...Int(numRows) {
            parseRow(json: json, start: j)
        }
        
    }
                
    internal func parseRow(json: Array<Any>, start: Int) {

        var views = [gameView]()
        let a = 3 * start
        let b = a + 2
        for j in a...b {
            let game = gameView(frame: NSMakeRect(0, 0, 112, 32))
            if json.indices.contains(j) {
                game.gameValues(game: json[j] as! NSObject)
            }
            views += [game]
        }
        
        let stack = NSStackView(views: views)
        stack.orientation = NSUserInterfaceLayoutOrientation.horizontal
        stack.distribution = NSStackView.Distribution.fillEqually
        stack.spacing = 0.0
        gameStackView.addArrangedSubview(stack)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint = NSLayoutConstraint(
            item: stack,
            attribute: NSLayoutConstraint.Attribute.leading,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: gameStackView,
            attribute: NSLayoutConstraint.Attribute.leading,
            multiplier: 1.0,
            constant: 0
        )
        leadingConstraint.identifier = "leading_"+String(start)
        let trailingConstraint = NSLayoutConstraint(
            item: stack,
            attribute: NSLayoutConstraint.Attribute.trailing,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: gameStackView,
            attribute: NSLayoutConstraint.Attribute.trailing,
            multiplier: 1.0,
            constant: 0
        )
        trailingConstraint.identifier = "trailing_"+String(start)
        let bottomContraint = NSLayoutConstraint(
            item: stack,
            attribute: NSLayoutConstraint.Attribute.height,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: nil,
            attribute: NSLayoutConstraint.Attribute.notAnAttribute,
            multiplier: 1.0,
            constant: 32
        )
        bottomContraint.identifier = "bottom_"+String(start)
        gameStackView.addConstraints([leadingConstraint, trailingConstraint, bottomContraint])

    }
    
    func updateCurrentTime() {
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.timeZone = TimeZone.current
        dateFormatterPrint.dateFormat = "yyyy-MM-dd h:mm a"
        let localDate =  dateFormatterPrint.string(from: Date())
        currentTimeLabel.stringValue = localDate
        
    }
    
    @IBAction func clickedOpenScoreboard(_ sender: NSButton) {
        let url = URL(string: "https://www.espn.com/mlb/scoreboard")!
        if NSWorkspace.shared.open(url) {
            print("default browser was successfully opened")
        }
    }
    
    @IBAction func clickedOpenWebsite(_ sender: NSButton) {
        let url = URL(string: "https://craigdietrich.com")!
        if NSWorkspace.shared.open(url) {
            print("default browser was successfully opened")
        }
    }
    
}

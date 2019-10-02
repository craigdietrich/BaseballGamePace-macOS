//
//  ViewController.swift
//  BaseballGamePace
//
//  Created by Craig Dietrich on 9/27/19.
//  Copyright © 2019 craigdietrich.com. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var gameStackView: NSStackView!
    @IBOutlet weak var currentTimeLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseData()
        parseData()
        parseData()
        parseData()
        parseData()
        updateCurrentTime()
        //games.wantsLayer = true
        //games.layer?.backgroundColor = NSColor.red.cgColor
    }

    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    func parseData() {
        
        var views = [gameView]()
        
        let game1 = gameView(frame: NSMakeRect(0, 0, 115, 32))
        game1.AwayLabel.stringValue = "SEA"
        game1.HomeLabel.stringValue = "OAK"
        views += [game1]
             
        let game2 = gameView(frame: NSMakeRect(0, 0, 115, 32))
        game2.AwayLabel.stringValue = "MIA"
        game2.HomeLabel.stringValue = "LAD"
        views += [game2]
        
        let game3 = gameView(frame: NSMakeRect(0, 0, 115, 32))
        game3.AwayLabel.stringValue = "NYM"
        game3.HomeLabel.stringValue = "NYY"
        views += [game3]
        
        let stack = NSStackView(views: views)
        stack.orientation = NSUserInterfaceLayoutOrientation.horizontal
        stack.distribution = NSStackView.Distribution.fillEqually
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
        let trailingConstraint = NSLayoutConstraint(
            item: stack,
            attribute: NSLayoutConstraint.Attribute.trailing,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: gameStackView,
            attribute: NSLayoutConstraint.Attribute.trailing,
            multiplier: 1.0,
            constant: 0
        )
        let bottomContraint = NSLayoutConstraint(
            item: stack,
            attribute: NSLayoutConstraint.Attribute.height,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: nil,
            attribute: NSLayoutConstraint.Attribute.notAnAttribute,
            multiplier: 1.0,
            constant: 32
        )
        gameStackView.addConstraints([leadingConstraint, trailingConstraint, bottomContraint])

    }
    
    func updateCurrentTime() {
        let currentDateTime = Date()
        let userCalendar = Calendar.current
        let requestedComponents: Set<Calendar.Component> = [
            .year,
            .month,
            .day,
            .hour,
            .minute,
            .second
        ]
        let dateTimeComponents = userCalendar.dateComponents(requestedComponents, from: currentDateTime)
        var month: String = String(dateTimeComponents.month!)
        if (month.count == 1) {month = "0" + month}
        var day: String = String(dateTimeComponents.day!)
        if (day.count == 1) {day = "0" + day}
        var hour: String = String(dateTimeComponents.hour!)
        if (hour.count == 1) {hour = "0" + hour}
        var minute: String = String(dateTimeComponents.minute!)
        if (minute.count == 1) {minute = "0" + minute}
        var second: String = String(dateTimeComponents.second!)
        if (second.count == 1) {second = "0" + second}
        let formattedTime = String(dateTimeComponents.year!)  + "-" + month  + "-" + day  + " " + hour  + ":" + minute  + ":" + second
        currentTimeLabel.stringValue = formattedTime
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


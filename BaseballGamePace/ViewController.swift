//
//  ViewController.swift
//  BaseballGamePace
//
//  Created by Craig Dietrich on 9/27/19.
//  Copyright © 2019 craigdietrich.com. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var currentTimeLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCurrentTime()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
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


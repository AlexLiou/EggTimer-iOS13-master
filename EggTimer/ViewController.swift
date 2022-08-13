//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!

    let eggTimes = ["Soft":300, "Medium":420, "Hard":720]

    var counter = 60 {
        didSet {
            if counter == 0 {
                titleLabel.text = "Done!"
            }
        }
    }

    var timer = Timer()

    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()

        let hardness = sender.currentTitle!
        let result = eggTimes[hardness]!
        counter = result

        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }

    @objc func updateCounter(count: Int) {
        if counter > 0 {
            print("\(counter) seconds remaining")
            counter -= 1
        } else {
            timer.invalidate()
        }
    }

}

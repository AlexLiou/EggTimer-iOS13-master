//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet var progressBar: UIProgressView!
    @IBOutlet var titleLabel: UILabel!
    var player: AVAudioPlayer?

    let eggTimes = ["Soft":3, "Medium":5, "Hard":12]

    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0 {
        didSet {
            if secondsPassed == totalTime {
                titleLabel.text = "Done!"
            }
        }
    }

    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()

        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!

        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness

        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }

    @objc func updateCounter(count: Int) {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
            print(progressBar.progress)
        } else {
            timer.invalidate()
            playSound()
        }
    }

    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            guard let player = player else { return }

            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }

}

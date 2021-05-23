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

    let TIMER_SPEED = 1.0

    let DONE_TEXT = "Done!"

    let DEFAULT_TEXT = "How do you like your eggs?"

    @IBOutlet weak var timerProgressBar: UIProgressView!
    @IBOutlet weak var headerLabel: UILabel!
    var timer: Timer? = nil

    let eggTimes = [
        "Soft": Float(5 * 60),
        "Medium": Float(7 * 60),
        "Hard": Float(12 * 60)
    ]

//    var eggTime : Float = 1

    @IBAction func onHardnessSelected(_ sender: UIButton) {

        if (headerLabel!.text != DEFAULT_TEXT) {
            headerLabel.text = DEFAULT_TEXT
            timerProgressBar.progress = 0.0
            timer?.invalidate()
            return
        }

        let hardness = sender.currentTitle!

        timerProgressBar.progress = 0
        headerLabel.text = hardness

        let eggTime = eggTimes[hardness] ?? -1.0

        NSLog("Time for %@ is %d", hardness, eggTime)

        if (eggTime == -1) {
            return
        }

        if (timer == nil || !(timer?.isValid ?? false)) {
            runTimer(eggTime: eggTime)
        } else {
            stopTimer()
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    private func runTimer(eggTime: Float) {
        var counter: Float = Float(eggTime)

        timer = Timer.scheduledTimer(withTimeInterval: TIMER_SPEED, repeats: true) { [self] (_timer) in
            counter -= 1;
            print(counter);
            timerProgressBar.progress = (eggTime - counter) / eggTime
            if (counter == 0) {
                _timer.invalidate()
                playAlarmClock()
                headerLabel!.text = "Done!"
                timerProgressBar.progress = 1
            }
        }
    }

    private func playAlarmClock() {
        AudioServicesPlayAlertSound(SystemSoundID(1033))
    }
}

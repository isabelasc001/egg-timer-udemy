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
    
    @IBOutlet weak var progressViewBar: UIProgressView!
    @IBOutlet weak var eggStatus: UILabel!
    
    var soundPlayer: AVAudioPlayer!
    var timerCounts = Timer()
    
    let eggTimes = ["Soft": 3, "Medium": 420, "Hard": 720]
    
    var totalTime = 0
    
    var secondsPassed = 0
    
    func updateLabelText() {
          eggStatus.text = "YOUR EGG IS READY!"

          DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
              self.resetLabelText()
          }
      }

      func resetLabelText() {
          eggStatus.text = "Select How You Prefere Your Eggs..."
      }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        soundPlayer = try! AVAudioPlayer(contentsOf: url!)
        soundPlayer.play()
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        timerCounts.invalidate()
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        
        progressViewBar.progress = 0.0
        secondsPassed = 0
        eggStatus.text = hardness
        
        timerCounts = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
        
    }
    
    @objc func timerUpdate() {
    
        if secondsPassed < totalTime {
            secondsPassed += 1
            let progressPercentage = Float(secondsPassed)/Float(totalTime)
            progressViewBar.progress = progressPercentage
            
        } else {
            timerCounts.invalidate()
            playSound()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.updateLabelText()
                    }
        }
    }
}

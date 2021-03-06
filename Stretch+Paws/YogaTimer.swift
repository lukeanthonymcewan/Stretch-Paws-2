//
//  YogaTimer.swift
//  Stretch+Paws
//
//  Created by Luke McEwan on 11/19/21.
//

import Foundation
import AVFoundation


class YogaTimer: ObservableObject {
//Timer states
    @Published var timerActive = false
    @Published var timerPaused = false
    @Published var timerEnded = false
    @Published var timerDuration = 30
    var yogaTimer = Timer()
    var audioPlayer: AVAudioPlayer?
    
//Timer functionality
    
    //Start timer
    func startTimer() {
        // Timer becomes active
        timerActive = true
        timerPaused = false
        timerEnded = false
        yogaTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block : {
            Timer in self.timerDuration -= 1
            //If the time gets to zero, stop the timer
            if self.timerDuration == 0 {
                self.stopTimer()
            }
        })
    }
    
    
    //Pause timer
    func pauseTimer() {
        timerActive = false
        timerPaused = true
        yogaTimer.invalidate()
    }
    
    //End timer
    func stopTimer() {
        //Play a sound
        playSound(sound: "chime", type: "wav")
        //Timer has ended
        timerEnded = true
        //Timer is no longer active
        timerActive = false
        //Timer stops running
        yogaTimer.invalidate()
        //Reset duration of timer
        timerDuration = 30
    }
    
    //Play sound
    func playSound(sound: String, type: String) {
        if let path = Bundle.main.path(forResource: sound, ofType: type) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.play()
            } catch {
                print("ERROR")
            }
        }
    }
    //Timer styles
    
    func setTitleText() -> String {
        if timerEnded {
            return "You did it!"
        }
        else {
            return "Hold that pose"
        }
    }
    
    func setDescriptionText() -> String {
        if timerEnded {
            return "Purrrrfect"
        }
        else {
            return "Try staying in this pose for 30 seconds. If you need to come out sooner, that's okay."
        }
    }
    
}

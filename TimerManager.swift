//
//  TimerManager.swift
//  Timer App
//
//  Created by Michael on 6/17/20.
//  Copyright © 2020 Lokely & Song. All rights reserved.
//

import Foundation
import SwiftUI

class TimerManager: ObservableObject{
    @Published var timerMode: TimerMode = .initial
    @Published var secondsLeft = UserDefaults.standard.integer(forKey:"timerLength")
    @Published var restOrPlay = "Study"
    
    var timer = Timer()
    
    func setTimerLength(minutes: Int){
        let defaults = UserDefaults.standard
        defaults.set(minutes,forKey: "timerLength")
        secondsLeft = minutes
        
    }
    func start(){
        timerMode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            if self.secondsLeft == 0{
                self.reset()
                self.restOrPlay = self.restOrPlay == "Study" ? "Rest" : "Study"
            } else{
                self.secondsLeft -= 1
            }
        })
    }
    
    func reset(){
        self.timerMode = .initial
        self.secondsLeft = UserDefaults.standard.integer(forKey: "timderLength")
        timer.invalidate()
    }
    
    func pause(){
        self.timerMode = .paused
        timer.invalidate()
    }
}

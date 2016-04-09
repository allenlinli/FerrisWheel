//
//  ViewController.swift
//  Ferris Wheel
//
//  Created by allenlinli on 4/7/16.
//  Copyright © 2016 allenlinli. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, FerrisWheelDelegate {
    var ferrisWheel: FerrisWheel!
    var wheelRotatingSoundPlayer: AVAudioPlayer! = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ferrisWheel = FerrisWheel(frame: view.frame, delegate: self)
        view.addSubview(ferrisWheel)
        
        let path = NSBundle.mainBundle().pathForResource("ferriswheel", ofType:"mp3")!
        let url = NSURL(fileURLWithPath: path)
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
            try AVAudioSession.sharedInstance().setActive(true)
            wheelRotatingSoundPlayer = try AVAudioPlayer(contentsOfURL: url)
        }
        catch {
            print("Can not load sound :( ")
            fatalError()
        }
        
        wheelRotatingSoundPlayer.numberOfLoops = -1
    }

    
    func ferrisWheelDidStartRotate(){
        wheelRotatingSoundPlayer.play()
    }
    
    func ferrisWheelDidFinishRotate(){
        wheelRotatingSoundPlayer.pause()
    }
}


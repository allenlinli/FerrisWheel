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
        view.backgroundColor = UIColor.grayColor()
        
        let wheelSize = CGSize(width: 320.0, height: 320.0)
        let wheelFrame = CGRect(x: view.center.x - wheelSize.width/2, y: view.center.y - wheelSize.height/2, width: wheelSize.width, height: wheelSize.height)
        ferrisWheel = FerrisWheel(frame:wheelFrame, delegate: self)
        ferrisWheel.backgroundColor = UIColor.redColor()
        view.addSubview(ferrisWheel)
        
        //>>setup audio player
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


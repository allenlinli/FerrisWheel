//
//  ViewController.swift
//  Ferris Wheel
//
//  Created by allenlinli on 4/7/16.
//  Copyright © 2016 allenlinli. All rights reserved.
//

import UIKit
import AVFoundation

let WheelSize = CGSize(width: 320.0, height: 320.0)

class ViewController: UIViewController {
    var ferrisWheel: FerrisWheel!
    var wheelRotatingSoundPlayer: AVAudioPlayer! = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 105.0/255.0, green: 122.0/255.0, blue: 138.0/255.0, alpha: 1)
        
        let wheelFrame = CGRect(x: view.center.x - WheelSize.width/2, y: view.center.y - WheelSize.height/2, width: WheelSize.width, height: WheelSize.height)
        ferrisWheel = FerrisWheel(frame:wheelFrame, delegate: self)
        view.addSubview(ferrisWheel)
        
        assert(ferrisWheel.frame == CGRect(x: 0.0,y: 80.0,width: 320.0,height: 320.0),"wheelFrame:\(wheelFrame)")
        
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
}


extension ViewController: CarriageDelegate, FerrisWheelDelegate{
    func ferrisWheelDidStartRotate(){
        wheelRotatingSoundPlayer.play()
    }
    
    func ferrisWheelDidFinishRotate(){
        wheelRotatingSoundPlayer.pause()
    }
    
    func carriageDidTapped(sender: Carriage?) {
        let initialFrame = sender?.convertRect((sender?.bounds)!, toView: view)
        let showInformationView = ShowInformationView(frame: initialFrame!, contentViewFrame: view.bounds)
        view.addSubview(showInformationView)
        
        
        //for testing
        showInformationView.backgroundColor = UIColor.orangeColor()
        print("showInformationView.frame:\(showInformationView.frame)")
        
        weak var wSelf = self
        UIView.animateWithDuration(5, delay: 1.0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
            showInformationView.frame = wSelf!.view.frame
            
            }, completion: { (finished: Bool) -> Void in
                print("In Completion------------------------------- ")
                print("showInformationView.frame:\(showInformationView.frame)")
                print("showInformationView.contentView.frame: \(showInformationView.contentView!.frame)")
                print("showInformationView.menuButton.frame:\(showInformationView.menuButton.frame)")
                print("showInformationView.topBarView.frame:\(showInformationView.topBarView.frame)")
                print("view.frame:\(wSelf!.view.frame)")
        })
    }
}


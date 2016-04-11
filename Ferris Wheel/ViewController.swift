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
    var initialCarriageFrame: CGRect?
    var showInformationView: ShowInformationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.startPoint = CGPointZero
        gradient.endPoint  = CGPoint(x: 1,y: 1)
        let colorOfTopLeft = UIColor(red: 120.0/255.0,green: 136.0/255.0,blue: 152.0/255.0, alpha: 1)
        let colorOfDownRight = UIColor(red: 57.0/255.0,green: 79.0/255.0,blue: 96.0/255.0, alpha: 1)
        gradient.colors = [colorOfTopLeft.CGColor, colorOfDownRight.CGColor]
        view.layer.insertSublayer(gradient, atIndex: 0)
        
        let wheelFrame = CGRect(x: view.center.x - WheelSize.width/2, y: view.center.y - WheelSize.height/2, width: WheelSize.width, height: WheelSize.height)
        ferrisWheel = FerrisWheel(frame:wheelFrame, delegate: self)
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
}


extension ViewController: CarriageDelegate, FerrisWheelDelegate, MenuButtonDelegate{
    func ferrisWheelDidStartRotate(){
        wheelRotatingSoundPlayer.play()
    }
    
    func ferrisWheelDidFinishRotate(){
        wheelRotatingSoundPlayer.pause()
    }
    
    func carriageDidTapped(sender: Carriage?) {
        initialCarriageFrame = sender?.convertRect((sender?.bounds)!, toView: view)
        print("view.bounds:\(view.bounds)")
        showInformationView = ShowInformationView(frame: initialCarriageFrame!, contentViewFrame: view.bounds, delegate: self)
        view.addSubview(showInformationView!)
        
        weak var wSelf = self
        
        //this is workaround to add 14 on y, ie. "view.frame.origin.y+14". Don't know how to make view.frame correct
        let selfViewFrame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y+16, width: view.frame.width, height: view.frame.height)
        UIView.animateWithDuration(0.7, delay: 1.0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
            wSelf!.showInformationView!.frame = selfViewFrame
            wSelf?.view.userInteractionEnabled = false
            }, completion: { (finished: Bool) -> Void in
            wSelf?.view.userInteractionEnabled = true
        })
    }
    
    func menuButtonTapped() {
        print("menuButtonTapped")
        weak var wSelf = self
        UIView.animateWithDuration(0.7, delay: 1.0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
            wSelf!.showInformationView!.frame = wSelf!.initialCarriageFrame!
            wSelf?.view.userInteractionEnabled = false
            }, completion: { (finished: Bool) -> Void in
                wSelf!.showInformationView!.removeFromSuperview()
                wSelf?.view.userInteractionEnabled = true
        })
    }
}


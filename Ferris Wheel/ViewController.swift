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
    var choosedCarriage: Carriage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.startPoint = CGPointZero
        gradient.endPoint  = CGPoint(x: 1,y: 1)
        let lighterGray = UIColor(red: 120.0/255.0,green: 136.0/255.0,blue: 152.0/255.0, alpha: 1)
        let darkerGray = UIColor(red: 57.0/255.0,green: 79.0/255.0,blue: 96.0/255.0, alpha: 1)
        gradient.colors = [lighterGray.CGColor, darkerGray.CGColor]
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
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewDidDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PresentInformationViewSegueID" {
            let infoVC = segue.destinationViewController as! InformationViewController
            infoVC.carriage = choosedCarriage
        }
    }
}


extension ViewController: CarriageDelegate, FerrisWheelDelegate {
    func ferrisWheelDidStartRotate(){
        wheelRotatingSoundPlayer.play()
    }
    
    func ferrisWheelDidFinishRotate(){
        wheelRotatingSoundPlayer.pause()
    }
    
    func carriageDidTapped(sender: Carriage?) {
        choosedCarriage = sender
        performSegueWithIdentifier("PresentInformationViewSegueID", sender: nil)
    }
}


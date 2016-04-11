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
        view.backgroundColor = UIColor(red: 105.0/255.0, green: 122.0/255.0, blue: 138.0/255.0, alpha: 1)
        
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
        showInformationView = ShowInformationView(frame: initialCarriageFrame!, contentViewFrame: view.bounds, delegate: self)
        guard let uShowInformationView = showInformationView else {
            fatalError("no showInformationView")
        }
        view.addSubview(showInformationView!)
        
//        //for testing
//        uShowInformationView.backgroundColor = UIColor.orangeColor()
//        print("showInformationView.frame:\(uShowInformationView.frame)")
        
        weak var wSelf = self
        let selfViewFrame = view.frame
        UIView.animateWithDuration(5, delay: 1.0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
            wSelf!.showInformationView!.frame = selfViewFrame
            }, completion: { (finished: Bool) -> Void in
                print("In Completion------------------------------- ")
                print("showInformationView.frame:\(uShowInformationView.frame)")
                print("showInformationView.contentView.frame: \(uShowInformationView.contentView!.frame)")
                print("showInformationView.menuButton.frame:\(uShowInformationView.menuButton.frame)")
                print("wSelf.view.frame:\(wSelf!.view.frame)")
//                print(UIWindow.screen.bouns)
        })
    }
    
    func menuButtonTapped() {
        print("menuButtonTapped")
        weak var wSelf = self
        UIView.animateWithDuration(5, delay: 1.0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
            wSelf!.showInformationView!.frame = wSelf!.initialCarriageFrame!
            }, completion: { (finished: Bool) -> Void in
                wSelf!.showInformationView!.removeFromSuperview()
        })
    }
}


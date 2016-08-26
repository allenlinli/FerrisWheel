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
    
    fileprivate let infoVCPresentAnimationController = InfoVCPresentAnimationController()
    fileprivate let infoVCDismissAnimationController = InfoVCDismissAnimationController()
    
    fileprivate let presentAnimationController = InfoVCPresentAnimationController()
    fileprivate let dismissAnimationController = InfoVCDismissAnimationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.startPoint = CGPoint.zero
        gradient.endPoint  = CGPoint(x: 1,y: 1)
        let lighterGray = UIColor(red: 120.0/255.0,green: 136.0/255.0,blue: 152.0/255.0, alpha: 1)
        let darkerGray = UIColor(red: 57.0/255.0,green: 79.0/255.0,blue: 96.0/255.0, alpha: 1)
        gradient.colors = [lighterGray.cgColor, darkerGray.cgColor]
        view.layer.insertSublayer(gradient, at: 0)
        
        let wheelFrame = CGRect(x: view.center.x - WheelSize.width/2, y: view.center.y - WheelSize.height/2, width: WheelSize.width, height: WheelSize.height)
        ferrisWheel = FerrisWheel(frame:wheelFrame, delegate: self)
        view.addSubview(ferrisWheel)
        
        //>>setup audio player
        let path = Bundle.main.path(forResource: "ferriswheel", ofType:"mp3")!
        let url = URL(fileURLWithPath: path)
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
            try AVAudioSession.sharedInstance().setActive(true)
            wheelRotatingSoundPlayer = try AVAudioPlayer(contentsOf: url)
        }
        catch {
            print("Can not load sound :( ")
            fatalError()
        }
        wheelRotatingSoundPlayer.numberOfLoops = -1
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PresentInformationViewSegueID" {
            let infoVC = segue.destination as! InformationViewController
            infoVC.carriage = choosedCarriage
            infoVC.menuButtonPressedDelegate = self
            infoVC.transitioningDelegate = self
        }
    }
}


extension ViewController: FerrisWheelDelegate, InformationViewControllerDelegate{
    func ferrisWheelDidStartRotate(){
        wheelRotatingSoundPlayer.play()
    }
    
    func ferrisWheelDidStopRotate(){
        wheelRotatingSoundPlayer.pause()
    }
    
    func openCarriage(_ sender: Carriage!) {
        choosedCarriage = sender
        performSegue(withIdentifier: "PresentInformationViewSegueID", sender: nil)
    }
    
    func menuButtonPressed(_ sender: InformationViewController?){
        dismiss(animated: true) {
        }
    }
}


extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        infoVCPresentAnimationController.originFrame = ferrisWheel.convert(choosedCarriage!.frame, to: view)
        return infoVCPresentAnimationController
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        infoVCDismissAnimationController.destinationFrame = ferrisWheel.convert(choosedCarriage!.frame, to: view)
        return infoVCDismissAnimationController
    }
}

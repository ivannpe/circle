//
//  animationViewController.swift
//  Circle
//
//  Created by Leena Loo on 5/2/20.
//  Copyright © 2020 Ivanna Peña and Leena Loo. All rights reserved.
//

import UIKit
import CoreGraphics
import AVFoundation

class animationViewController: UIViewController {
/*
    let shapeLayer = CAShapeLayer()
    let darkOrange = UIColor(red: 0.8784, green: 0.349, blue: 0.0824, alpha: 1.0)
    let pink = UIColor(red: 0.9961, green: 0.6431, blue: 0.6235, alpha: 1.0)
    let lightBlue = UIColor(red: 0.7608, green: 0.8667, blue: 0.902, alpha: 1.0)
    let darkBlue = UIColor(red: 0, green: 0.1059, blue: 0.3137, alpha: 1.0)
    let grayBlue = UIColor(red: 0.2941, green: 0.3412, blue: 0.4275, alpha: 1.0)
    let lightOrange = UIColor(red: 0.9216, green: 0.6353, blue: 0.4902, alpha: 1.0)
    */
    
    @IBOutlet weak var viewContain: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    var twinkle: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //logoImageView.center = CGPoint(x:512, y:364)
        view.addSubview(logoImageView)
        //generates sound at a delay to match with animation
        let path = Bundle.main.path(forResource: "twinkle.wav", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        delay(1){
            do {
                self.twinkle = try AVAudioPlayer(contentsOf: url)
                self.twinkle?.play()
            } catch {
                // couldn't load file :(
            }
        }
        //animate logo image
        UIView.animate(withDuration: 4, delay: 1, animations: {
            //rotate
            self.logoImageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            //scale up
            self.logoImageView.transform = CGAffineTransform(scaleX: 4, y:4)
        } )
                //instantiate welcome screen controller
                let welcomePageViewController = storyboard?.instantiateViewController(withIdentifier: "WelcomePageViewController") as! WelcomeScreenViewController
        //delay segue after animation
        delay(4.5){
            welcomePageViewController.modalPresentationStyle = .fullScreen
            self.present(welcomePageViewController, animated:true, completion:nil)
        }
        
        // Do any additional setup after loading the view.
        /*
        //code for different loading animation
        //draw circle
        let center = view.center
        let circularPath = UIBezierPath (arcCenter: center, radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = darkOrange.cgColor
        shapeLayer.lineWidth = 10
        
        shapeLayer.strokeEnd = 0
        
        //to add the layer to view
        view.layer.addSublayer(shapeLayer)
        

        print("animate start")
        //start animation
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        
        //set the animation to 2 seconds
        basicAnimation.duration = 3
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey:"shapeLayerAdd")
 */
        
        //logoImageView.transform = CGAffineTransform(scaleX: 2, y:2)
        //logoImageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)

        //view.addSubview(logoImageView)
    }
    
    //delay function taken from stackoverflow https://stackoverflow.com/questions/24034544/dispatch-after-gcd-in-swift
    
    func delay(_ delay: Double, closure:@escaping ()->()){
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }

}

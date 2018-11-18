//
//  CanvasController.swift
//  Vision
//
//  Created by Brandon Ward on 10/8/18.
//  Copyright © 2018 LEDBoyzz. All rights reserved.
//
// Code based on this tutorial:
// https://www.raywenderlich.com/6721-welcome-to-the-new-raywenderlich-com

import UIKit

class CanvasController: UIViewController {
    
    var CANVAS_DATA: [UIColor: [CGPoint]] = [:]
    var COLOR: UIColor = UIColor.black;
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var tempImageView: UIImageView!
    
    //MARK: Drawing variables
    var lastPoint = CGPoint.zero
//    var color = UIColor.black
    var color = UIColor(red: 0.0, green: 0.5, blue: 0.5, alpha: 0.0)
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var swiped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //resestPressed() -> a function for clearing the canvas
    @IBAction func resetPressed(_ sender: Any) {
        mainImageView.image = nil
        tempImageView.image = nil
        CANVAS_DATA = [:]
        COLOR = UIColor.black;
    }
    
    
    //To be send pressed
    @IBAction func sendPressed(_ sender: Any) {
        
        for k in CANVAS_DATA.keys {
            print("the key is...")
            print(k)
            print("the values are ...")
            print(CANVAS_DATA[k])
            
        }
    }
    
    //pencilPressed() -> a function for determing the pencil and color
    @IBAction func pencilPressed(_ sender: UIButton) {
        guard let pencil = Pencil(tag: sender.tag) else {
            return
        }
        color = pencil.color
        COLOR = pencil.color
        if pencil == .eraser {
            opacity = 1.0
        }
    }
    
    //touchesBegan() -> records user movement on the canavas.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        swiped = false
        lastPoint = touch.location(in: view)
    }
    
    //drawLine() -> function that draws line for user
    func drawLine(from fromPoint: CGPoint, to toPoint: CGPoint) {
        
        UIGraphicsBeginImageContext(view.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        tempImageView.image?.draw(in: view.bounds)
        
        context.move(to: fromPoint)
        context.addLine(to: toPoint)
        context.setLineCap(.round)
        context.setBlendMode(.normal)
        context.setLineWidth(brushWidth)
        context.setStrokeColor(color.cgColor)
        context.strokePath()
        
        tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        tempImageView.alpha = opacity
        UIGraphicsEndImageContext()
    }
    
    //touchesMoved() -> a function for recording when touches moved
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        swiped = true
        let currentPoint = touch.location(in: view)
        drawLine(from: lastPoint, to: currentPoint)
        lastPoint = currentPoint
        
        //Records canvas point data into dictionary.
        if CANVAS_DATA[COLOR] != nil {
            CANVAS_DATA[COLOR]?.append(lastPoint)
        } else {
            var point = [CGPoint]()
            point.append(lastPoint)
            CANVAS_DATA.updateValue(point, forKey: COLOR)
        }
        
    }
    
    //touchesEneded() -> records when the touches have ended and draws in view
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swiped {
            drawLine(from: lastPoint, to: lastPoint)
        }
        
        // Merge tempImageView into mainImageView
        UIGraphicsBeginImageContext(mainImageView.frame.size)
        mainImageView.image?.draw(in: view.bounds, blendMode: .normal, alpha: 1.0)
        tempImageView?.image?.draw(in: view.bounds, blendMode: .normal, alpha: opacity)
        mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }


}

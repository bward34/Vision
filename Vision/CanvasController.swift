//
//  CanvasController.swift
//  Vision
//
//  Created by Brandon Ward on 10/8/18.
//  Copyright © 2018 LEDBoyzz. All rights reserved.

import UIKit

class CanvasController: UIViewController {
    
    var CANVAS_DATA: [String: String] = [:]
    var COLOR: UIColor = UIColor.black;
    var data = ""
    var layer = "1"
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var tempImageView: UIImageView!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    //MARK: Drawing variables
    var lastPoint = CGPoint.zero
    var color = UIColor.black
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var swiped = false
    var r = 0
    var g = 0
    var b = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stepper.wraps = true
        stepper.autorepeat = true
        stepper.maximumValue = 6
    }
    
    
    //resestPressed() -> a function for clearing the canvas
    @IBAction func resetPressed(_ sender: Any) {
        mainImageView.image = nil
        tempImageView.image = nil
        CANVAS_DATA = [:]
        COLOR = UIColor.black;
    }
    
    
    //sendPressed() -> formats the canvas drawing data and sends it
    @IBAction func sendPressed(_ sender: Any) {
        
        if(CANVAS_DATA.count != 0) {
            prepDictionary()
            info.isHidden = false
            print(data)
            if socket.sendData(data: data) {
                info.text = "Drawing sent!"
                info.textColor = UIColor.green
            } else {
                info.text = "Connection Timeout!"
                info.textColor = UIColor.red
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.info.isHidden = true
            }
        }
    }
    
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        valueLabel.text = Int(sender.value).description
        layer = Int(sender.value).description
    }
    
    //pencilPressed() -> a function for determing the pencil and color
    @IBAction func pencilPressed(_ sender: UIButton) {
        guard let pencil = Pencil(tag: sender.tag) else {
            return
        }
        
        color = pencil.color
        r = Int(((pencil.hexColor & 0xFF0000) >> 16) * 0xFF)
        g = Int(((pencil.hexColor & 0x00FF00) >> 8) * 0xFF)
        b = Int((pencil.hexColor & 0x0000FF) * 0xFF)
        
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
        
        let x = Int(lastPoint.x / 1.03)
        let y = lastPoint.y < 75 ? 0 : lastPoint.y > 470 ? 31 : Int(lastPoint.y / 15.5)
        print(lastPoint)
        print("\(x) and \(y)")
        let X_AND_Z = "0" + layer + " " + String(format: "%02d", y) + " " +  String(format: "%03d", x)
        let color = String(format: "%05d", r) + " " + String(format: "%05d", g) + " " + String(format: "%05d", b)
        
        //Records canvas point data into dictionary.
        if CANVAS_DATA[X_AND_Z] != nil {
            CANVAS_DATA[X_AND_Z] = color
        } else {
            CANVAS_DATA.updateValue(color, forKey: X_AND_Z)
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
    
    //prepDictionary() -> converts the dicionary to a string before sending it
    func prepDictionary() {
        
        data =  "1" + " " + String(format: "%05d", CANVAS_DATA.count) + " "
        for (coordinate, color) in CANVAS_DATA
        {
            data = data + coordinate + " " + color + " "
        }
    }


}

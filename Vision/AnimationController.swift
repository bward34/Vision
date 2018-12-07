//
//  AnimationController.swift
//  Vision
//
//  Created by Brandon Ward on 10/27/18.
//  Copyright © 2018 LEDBoyzz. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire
import SwiftSocket

class AnimationController: UIViewController {
    
    var r = 0
    var g = 0
    var b = 0
    
    let colorArray = [ 0x000000, 0xfe0000, 0xff7900, 0xffb900, 0xffde00, 0xfcff00, 0xd2ff00, 0x05c000, 0x00c0a7, 0x0600ff, 0x6700bf, 0x9500c0, 0xbf0199, 0xffffff ]
    
    @IBOutlet var info : UILabel!
    @IBOutlet weak var selectedColorView: UIView!
    @IBOutlet weak var slider: UISlider!

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    let shapeObject = Object()
    
    //sliderChanged() -> gets the slider values for the color
    @IBAction func sliderChanged(sender: AnyObject) {
        selectedColorView.backgroundColor = uiColorFromHex(rgbValue: colorArray[Int(slider.value)])
    }
    
    // uiColorFromHex() -> sets the rgb value to the correct format
    func uiColorFromHex(rgbValue: Int) -> UIColor {
        
        let red =   CGFloat((rgbValue & 0xFF0000) >> 16) / 0xFF
        r =  ((rgbValue & 0xFF0000) >> 16) * 0xFF
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 0xFF
        g = ((rgbValue & 0x00FF00) >> 8) * 0xFF
        let blue =  CGFloat(rgbValue & 0x0000FF) / 0xFF
        b = (rgbValue & 0x0000FF) * 0xFF
        let alpha = CGFloat(1.0)
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    
    @IBAction func sendPressed(_ sender: Any) {
        
        var dataArray = shapeObject.points
        let count = Int(dataArray[1][0])! + 2
        for i in 2..<count {
            dataArray[i][3] = String(format: "%05d", r)
            dataArray[i][4] = String(format: "%05d", g)
            dataArray[i][5] = String(format: "%05d", b)
        }
        let data = shapeObject.convertArrayToString(array: dataArray)
        print(data)
        sendToSocket(data: data)
    }
    
    
    @IBAction func sprialPressed(_ sender: Any) {
        
        var dataArray = shapeObject.sprial
        let count = Int(dataArray[1][0])! + 2
        for i in 2..<count {
            dataArray[i][3] = String(format: "%05d", r)
            dataArray[i][4] = String(format: "%05d", g)
            dataArray[i][5] = String(format: "%05d", b)
        }
        let data = shapeObject.convertArrayToString(array: dataArray)
        print(data)
       sendToSocket(data: data)
    }
    
    @IBAction func tentPressed(_ sender: Any) {
        
        var dataArray = shapeObject.tent
        let count = Int(dataArray[1][0])! + 2
        for i in 2..<count {
            dataArray[i][3] = String(format: "%05d", r)
            dataArray[i][4] = String(format: "%05d", g)
            dataArray[i][5] = String(format: "%05d", b)
        }
        let data = shapeObject.convertArrayToString(array: dataArray)
        print(data)
        sendToSocket(data: data)
    }
    
    @IBAction func starPressed(_ sender: Any) {
        
        var dataArray = shapeObject.star
        let count = Int(dataArray[1][0])! + 2
        for i in 2..<count {
            dataArray[i][3] = String(format: "%05d", r)
            dataArray[i][4] = String(format: "%05d", g)
            dataArray[i][5] = String(format: "%05d", b)
        }
        let data = shapeObject.convertArrayToString(array: dataArray)
        print(data)
        sendToSocket(data: data)
    }
    
    @IBAction func tuningPressed(_ sender: Any) {
        
        var dataArray = shapeObject.tuning
        let count = Int(dataArray[1][0])! + 2
        for i in 2..<count {
            dataArray[i][3] = String(format: "%05d", r)
            dataArray[i][4] = String(format: "%05d", g)
            dataArray[i][5] = String(format: "%05d", b)
        }
        let data = shapeObject.convertArrayToString(array: dataArray)
        print(data)
        sendToSocket(data: data)
    }
    
    @IBAction func improvedStarPressed(_ sender: Any) {
        
        var dataArray = shapeObject.star_improve
        let count = Int(dataArray[1][0])! + 2
        for i in 2..<count {
            dataArray[i][3] = String(format: "%05d", r)
            dataArray[i][4] = String(format: "%05d", g)
            dataArray[i][5] = String(format: "%05d", b)
        }
        let data = shapeObject.convertArrayToString(array: dataArray)
        print(data)
        sendToSocket(data: data)
    }
    
    @IBAction func u_of_u_singlePressed(_ sender: Any) {
        
        var dataArray = shapeObject.uofu_one_layer
        let count = Int(dataArray[1][0])! + 2
        for i in 2..<count {
            dataArray[i][3] = String(format: "%05d", r)
            dataArray[i][4] = String(format: "%05d", g)
            dataArray[i][5] = String(format: "%05d", b)
        }
        let data = shapeObject.convertArrayToString(array: dataArray)
        print(data)
        sendToSocket(data: data)
    }
    
    @IBAction func u_of_u_multiPressed(_ sender: Any) {
        
        var dataArray = shapeObject.uofu_seven_layer
        let count = Int(dataArray[1][0])! + 2
        for i in 2..<count {
            dataArray[i][3] = String(format: "%05d", r)
            dataArray[i][4] = String(format: "%05d", g)
            dataArray[i][5] = String(format: "%05d", b)
        }
        let data = shapeObject.convertArrayToString(array: dataArray)
        print(data)
        sendToSocket(data: data)
    }

    
    func sendToSocket(data: String) {
        
        info.isHidden = false
        if socket.sendData(data: data) {
            info.text = "Animation sent!"
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

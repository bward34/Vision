//
//  ShapesController.swift
//  Vision
//
//  Created by Brandon Ward on 11/17/18.
//  Copyright © 2018 LEDBoyzz. All rights reserved.
//

import UIKit

class ShapesController: UIViewController {
    
    var shapeObject = Object()
    var dataArray: [[String]] = [[]]
    var shape = "cube"
    var r = 0
    var g = 0
    var b = 0
    
    let colorArray = [ 0x000000, 0xfe0000, 0xff7900, 0xffb900, 0xffde00, 0xfcff00, 0xd2ff00, 0x05c000, 0x00c0a7, 0x0600ff, 0x6700bf, 0x9500c0, 0xbf0199, 0xffffff ]
    
    @IBOutlet weak var selectedColorView: UIView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var info: UILabel!
    
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
    
    //cubePress() -> sets the shape to cube
    @IBAction func cubePressed(_ sender: Any) {
        shape = "cube"
    }
    
    //spherePress() -> sets the shape to sphere
    @IBAction func spherePressed(_ sender: Any) {
        shape = "sphere"
    }
    
    //conePressed() -> sets the shape to cone
    @IBAction func conePressed(_ sender: Any) {
        shape = "cone"
    }
    
    //sendPressed() -> sets the object to cone
    @IBAction func sendPressed(_ sender: Any) {
        
        print("r: \(r) g: \(g) b: \(b)")
        switch shape {
        case "cube":
            dataArray = shapeObject.cube
        case "cone":
            dataArray = shapeObject.points
        case "sphere":
            dataArray = shapeObject.sphere
        default:
            dataArray = shapeObject.cube
        }
        let count = Int(dataArray[1][0])! + 2
        for i in 2..<count {
            dataArray[i][3] = String(format: "%05d", r)
            dataArray[i][4] = String(format: "%05d", g)
            dataArray[i][5] = String(format: "%05d", b)
        }

        print(shapeObject.convertArrayToString(array: dataArray))
        info.isHidden = false
        if socket.sendData(data: shapeObject.convertArrayToString(array: dataArray)) {
            info.text = "Shape sent!"
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

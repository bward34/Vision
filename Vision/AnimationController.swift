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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    let shapeObject = Object()
    
    
    @IBAction func sendPressed(_ sender: Any) {
        
     let data = shapeObject.convertArrayToString(array: shapeObject.points)
        print(data)
        socket.sendData(data: data)
    }
    
    
    @IBAction func sprialPressed(_ sender: Any) {
        
        let data = shapeObject.convertArrayToString(array: shapeObject.sprial)
        print(data)
        socket.sendData(data: data)
    }
}

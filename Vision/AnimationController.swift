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
     let client = TCPClient(address: "192.168.43.199", port: 23)
        switch client.connect(timeout: 1) {
        case .success:
            switch client.send(string: data) {
            case .success:
                    print("success")
             
            case .failure(let error):
                print(error)
            }
       case .failure(let error):
           print(error)
        
       }
        usleep(350000)
        client.close()
    }
}

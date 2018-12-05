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
        socket.sendData(data: String(data[data.index(data.startIndex, offsetBy: 0)..<data.index(data.startIndex, offsetBy: 7)]))
        print( String(data[data.index(data.startIndex, offsetBy: 0)..<data.index(data.startIndex, offsetBy: 7)]))
        let splitWord = String(data[data.index(data.startIndex, offsetBy: 7)..<data.index(data.endIndex, offsetBy: 0)])
        let splitArray = splitWord.split(by: 840)
        
        for word in splitArray {
        print(word)
           var count = 0
           while(!socket.sendData(data: word)) {
            }
        }
    }
    
}
    extension String {
        func split(by length: Int) -> [String] {
            var startIndex = self.startIndex
            var results = [Substring]()
            
            while startIndex < self.endIndex {
                let endIndex = self.index(startIndex, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
                results.append(self[startIndex..<endIndex])
                startIndex = endIndex
            }
            
            return results.map { String($0) }
        }
    }


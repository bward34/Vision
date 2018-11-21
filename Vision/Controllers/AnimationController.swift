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
    
    
    let parameters = """
        Data in Non Binary Format :
        Z Layer: 1
        Angle: 45
        Radius: 24
        Data in Binary Format:
        00000001
        00101101
        00011000
        Data in Non Binary Format:
        Z Layer: 1
        Angle: 47
        Radius: 23
        Data in Binary Format:
        00000001
        00101111
        00010111
        Data in Non Binary Format:
        Z Layer: 1
        Angle: 48
        Radius: 23
        Data in Binary Format:
        00000001
        00110000
        00010111
        Data in Non Binary Format:
        Z Layer: 1
        Angle: 48
        Radius: 23
        Data in Binary Format:
        00000001
        00110000
        00010111
        Data in Non Binary Format:
        Z Layer: 1
        Angle: 46
        Radius: 22
        Data in Binary Format:
        00000001
        00101110
        00010110
        Data in Non Binary Format:
        Z Layer: 1
        Angle: 45
        Radius: 22
        Data in Binary Format:
        00000001
        00101101
        00010110
        Data in Non Binary Format:
        Z Layer: 1
        Angle: 45
        Radius: 22
        Data in Binary Format:
        00000001
        00101101
        00010110
        Data in Non Binary Format:
        Z Layer: 1
        Angle: 43
        Radius: 22
        Data in Binary Format:
        00000001
        00101011
        00010110
        Data in Non Binary Format:
        Z Layer: 1
        Angle: 42
        Radius: 23
        Data in Binary Format:
        00000001
        00101010
        00010111
        Data in Non Binary Format:
        Z Layer: 1
        Angle: 42
        Radius: 23
        Data in Binary Format:
        00000001
        00101010
        00010111
        Data in Non Binary Format:
        Z Layer: 1
        Angle: 44
        Radius: 23
        Data in Binary Format:
        00000001
        00101100
        00010111
        Data in Non Binary Format:
        Z Layer: 1
        Angle: 45
        Radius: 24
        Data in Binary Format:
        00000001
        00101101
        00011000
        Data in Non Binary Format:
        Z Layer: 1
        Angle: 45
        Radius: 24
        Data in Binary Format:
        00000001
        00101101
        00011000
        Data in Non Binary Format:
        Z Layer: 1
        Angle: 45
        Radius: 23
        Data in Binary Format:
        00000001
        00101101
        00010111
        Data in Non Binary Format:
        Z Layer: 2
        Angle: 45
        Radius: 24
        Data in Binary Format:
        00000010
        00101101
        00011000
        Data in Non Binary Format:
        Z Layer: 2
        Angle: 47
        Radius: 23
        Data in Binary Format:
        00000010
        00101111
        00010111
        Data in Non Binary Format:
        Z Layer: 2
        Angle: 48
        Radius: 23
        Data in Binary Format:
        00000010
        00110000
        00010111
        Data in Non Binary Format:
        Z Layer: 2
        Angle: 48
        Radius: 23
        Data in Binary Format:
        00000010
        00110000
        00010111
        Data in Non Binary Format:
        Z Layer: 2
        Angle: 46
        Radius: 22
        Data in Binary Format:
        00000010
        00101110
        00010110
        Data in Non Binary Format:
        Z Layer: 2
        Angle: 45
        Radius: 22
        Data in Binary Format:
        00000010
        00101101
        00010110
        Data in Non Binary Format:
        Z Layer: 2
        Angle: 45
        Radius: 22
        Data in Binary Format:
        00000010
        00101101
        00010110
        Data in Non Binary Format:
        Z Layer: 2
        Angle: 43
        Radius: 22
        Data in Binary Format:
        00000010
        00101011
        00010110
        Data in Non Binary Format:
        Z Layer: 2
        Angle: 42
        Radius: 23
        Data in Binary Format:
        00000010
        00101010
        00010111
        Data in Non Binary Format:
        Z Layer: 2
        Angle: 42
        Radius: 23
        Data in Binary Format:
        00000010
        00101010
        00010111
        Data in Non Binary Format:
        Z Layer: 2
        Angle: 44
        Radius: 23
        Data in Binary Format:
        00000010
        00101100
        00010111
        Data in Non Binary Format:
        Z Layer: 2 hi taylor
        """
    
    
    @IBAction func sendPressed(_ sender: Any) {
        
     let client = TCPClient(address: "192.168.43.149", port: 23)
        switch client.connect(timeout: 1) {
        case .success:
            switch client.send(string: parameters) {
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

//
//  AnimationController.swift
//  Vision
//
//  Created by Brandon Ward on 10/27/18.
//  Copyright © 2018 LEDBoyzz. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class AnimationController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    let parameters = [
        "data": """
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
        Z Layer: 2
        """
    ]
    
    @IBAction func sendPressed(_ sender: Any) {
       // Alamofire.request(.POST, "https://httpbin.org/post", parameters: parameters, encoding: .JSON)
        
        let url = "http://172.20.10.4:23"
        Alamofire.request(url, method:.post, parameters:parameters,encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                print(response)
            case .failure( _):
                print("error")
            }
        }
    // -> HTTP body: {"foo": [1, 2, 3], "bar": {"baz": "qux"}
    
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

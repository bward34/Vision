//
//  WebSocket.swift
//  Vision
//
//  Created by Brandon Ward on 11/21/18.
//  Copyright © 2018 LEDBoyzz. All rights reserved.
//

import Foundation
import SwiftSocket

class WebSocket {

    var client = TCPClient(address: "192.168.43.199", port: 23)
    
    func sendData(data: String) -> Bool {
        var suc = true
        switch client.connect(timeout: 1) {
        case .success:
        switch client.send(string: data) {
        case .success:
        print("success")
            
        case .failure(let error):
        print(error)
        suc = false
        }
        case .failure(let error):
        print(error)
        suc = false
        }
        usleep(350000)
        client.close()
        return suc
    }
}

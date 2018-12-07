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

    //Default ip address being sent to
    var client = TCPClient(address: "192.168.43.199", port: 23)
    
    //sendData() -> formats data and preps it for sending
    func sendData(data: String) -> Bool {
        var successType = true
        transmitData(data: String(data[data.index(data.startIndex, offsetBy: 0)..<data.index(data.startIndex, offsetBy: 7)]))
        print( String(data[data.index(data.startIndex, offsetBy: 0)..<data.index(data.startIndex, offsetBy: 7)]))
        let splitWord = String(data[data.index(data.startIndex, offsetBy: 7)..<data.index(data.endIndex, offsetBy: 0)])
        let splitArray = splitWord.split(by: 840)
        for word in splitArray {
            print(word)
            var count = 0
            while(!transmitData(data: word) && count != 3) {
                count = count + 1
                successType = false
            }
        }
        return successType
    }
    
    //transmitData() -> sends data to device using socket
    func transmitData(data: String) -> Bool {
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
        usleep(200000)
        client.close()
        return suc
    }
}

//Class extension for splitting a string
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


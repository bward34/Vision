//
//  Object.swift
//  Vision
//
//  Created by Brandon Ward on 11/10/18.
//  Copyright © 2018 LEDBoyzz. All rights reserved.
//

import UIKit

class Object {
    

    //Test Data
  var points: [[String]] = [["1"],["00008"],["00","00","000","65535","00000","00000"],["00","01","001","00000","65535","00000"],["00","02","002","00000","00000","65535"],["00","03","003","65535","65535","65535"],["00","04","004","65535","65535","65535"],["00","05","005","65535","65535","65535"],["00","06","006","65535","65535","65535"],["00","06","006","65535","65535","65535"]]
    
    //convertArrayToString() -> converts the array to a format ready for sending
    func convertArrayToString(array: [[String]]) -> String {
        var returnData = ""
        for nestedArray in array {
            for value in nestedArray {
                returnData = returnData + value + " "
            }
        }
        return returnData
    }
}

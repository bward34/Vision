//
//  Object.swift
//  Vision
//
//  Created by Brandon Ward on 11/10/18.
//  Copyright © 2018 LEDBoyzz. All rights reserved.
//

import UIKit

class Object {
    
    
let points: [[String]] = [["1"],["00008"],["00","00","000","65535","00000"],["00","01","001","00000","65535"],["00","02","002","00000","00000"],["00","03","003","65535","65535"],["00","04","004","65535","65535"],["00","05","005","65535","65535"],["00","06","006","65535","65535"],["00","06","006","65535","65535"]]
    
    
    func convertArrayToString(array: [[String]]) -> String {
        //let layer:Int = Int(array[1][0])!
        var returnData = ""
        
        for nestedArray in array {
            for value in nestedArray {
                returnData = returnData + value + " "
            }
        }
        return returnData
    }
    
    let a1 = 0xFF000000
    let a2 = 0x00FF0000
    let a3 = 0x0000FF00
    let a4 = 0x000000FF
    
    func getByte(number: Int, a_val: Int, shift: Int) -> Int  {
        return ((number & a_val) >> shift)
    }
    
    func getPixelCount(number: Int) -> String {
        let c1 = String(convertToChar(number: getByte(number: number, a_val: a1, shift: 24)))
        let c2 = String(convertToChar(number: getByte(number: number, a_val: a2, shift: 16)))
        let c3 = String(convertToChar(number: getByte(number: number, a_val: a3, shift: 8)))
        let c4 = String(convertToChar(number: getByte(number: number, a_val: a4, shift: 0)))
        return c1 + c2 + c3 + c4
    }
    
    func convertToChar(number: Int) -> Character {
        let y = UnicodeScalar(number)
        let char = Character(y!)
        return char
    }
}

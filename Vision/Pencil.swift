//
//  Pencil.swift
//  Vision
//
//  Created by Brandon Ward on 10/10/18.
//  Copyright © 2018 LEDBoyzz. All rights reserved.
//

import Foundation
import UIKit

enum Pencil {
    case black
    case grey
    case red
    case darkblue
    case lightBlue
    case darkGreen
    case lightGreen
    case brown
    case orange
    case yellow
    case eraser
    
    init?(tag: Int) {
        switch tag {
        case 1:
            self = .black
        case 2:
            self = .grey
        case 3:
            self = .red
        case 4:
            self = .darkblue
        case 5:
            self = .lightBlue
        case 6:
            self = .darkGreen
        case 7:
            self = .lightGreen
        case 8:
            self = .brown
        case 9:
            self = .orange
        case 10:
            self = .yellow
        case 11:
            self = .eraser
        default:
            return nil
        }
    }
    
    var hexColor: uint {
        switch self {
        case .black:
            return 0x000000
        case .grey:
            return 0x808080
        case .red:
            return 0xFF0000
        case .darkblue:
            return 0x0000ff
        case .lightBlue:
            return 0xadd8e6
        case .darkGreen:
            return 0x008000
        case .lightGreen:
            return 0x0ed80e
        case .brown:
            return 0x8B4513
        case .orange:
            return 0xffa500
        case .yellow:
            return 0xffff00
        case .eraser:
            return 0xffffff
        }
    }

    var color: UIColor {
        switch self {
        case .black:
            return .black
        case .grey:
            return UIColor(white: 105/255.0, alpha: 1.0)
        case .red:
            return UIColor(red: 1, green: 0, blue: 0, alpha: 1.0)
        case .darkblue:
            return UIColor(red: 0, green: 0, blue: 1, alpha: 1.0)
        case .lightBlue:
            return UIColor(red: 51/255.0, green: 204/255.0, blue: 1, alpha: 1.0)
        case .darkGreen:
            return UIColor(red: 102/255.0, green: 204/255.0, blue: 0, alpha: 1.0)
        case .lightGreen:
            return UIColor(red: 102/255.0, green: 1, blue: 0, alpha: 1.0)
        case .brown:
            return UIColor(red: 160/255.0, green: 82/255.0, blue: 45/255.0, alpha: 1.0)
        case .orange:
            return UIColor(red: 1, green: 102/255.0, blue: 0, alpha: 1.0)
        case .yellow:
            return UIColor(red: 1, green: 1, blue: 0, alpha: 1.0)
        case .eraser:
            return .white
        }
    }
}

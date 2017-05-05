//
//  TextPresentable.swift
//  BabylonHealth
//
//  Created by Alessandro dos Santos Pinto on 05/05/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import Foundation

import UIKit

protocol TextPresentable {
    var textFont: UIFont { get }
    var textColor: UIColor { get }
}

extension TextPresentable {
    
    var textFont: UIFont {
        return UIFont.boldSystemFont(ofSize: 15)
    }
    
    var textColor: UIColor {
        return UIColor.purple
    }
}

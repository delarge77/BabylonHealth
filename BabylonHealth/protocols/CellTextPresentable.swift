//
//  TextPresentable.swift
//  BabylonHealth
//
//  Created by Alessandro dos Santos Pinto on 05/05/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import Foundation

import UIKit

protocol CellTextPresentable {
    var postsFont: UIFont { get }
    var postsColor: UIColor { get }
    var commentsFont: UIFont { get }
    var commentsColor: UIColor { get }
}

extension CellTextPresentable {
    
    var postsFont: UIFont {
        return UIFont.boldSystemFont(ofSize: 15)
    }
    
    var postsColor: UIColor {
        return UIColor.purple
    }
    
    var commentsFont: UIFont {
        return UIFont.boldSystemFont(ofSize: 15)
    }
    
    var commentsColor: UIColor {
        return UIColor.blue
    }
}

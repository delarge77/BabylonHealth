//
//  UIViewController+Navigation.swift
//  BabylonHealth
//
//  Created by Alessandro dos Santos Pinto on 06/05/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    var contents: UIViewController {
        if let nav = self as? UINavigationController {
            return nav.visibleViewController ?? self
        } else {
            return self
        }
    }
}

//
//  Persistable.swift
//  BabylonHealth
//
//  Created by Alessandro dos Santos Pinto on 08/05/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import Foundation
import RealmSwift

protocol Persistable {
    
    associatedtype ManagedObject: RealmSwift.Object
    init(managedObject: ManagedObject)
    func managedObject() -> ManagedObject
}

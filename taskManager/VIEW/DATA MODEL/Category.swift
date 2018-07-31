//
//  Category.swift
//  taskManager
//
//  Created by Cristi_Tohatan on 31/07/2018.
//  Copyright © 2018 Cristi_Tohatan. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object{
    
    @objc dynamic var name : String = ""
    let items = List<Item>()
    
    
}

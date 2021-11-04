//
//  User.swift
//  CRUDDemo
//
//  Created by Agustín Embuena on 4/11/21.
//

import Foundation
import UIKit

struct User: Codable  {
    public var id: Int
    public var name: String
    public var birthdate: String
    
    init(name:String , birthdate: String) {
        self.name = name
        self.birthdate = birthdate
        self.id = 0
    }
}

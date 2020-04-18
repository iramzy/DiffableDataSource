//
//  Contact.swift
//  DiffableDataSource
//
//  Created by Ahmed Ramzy on 4/15/20.
//  Copyright © 2020 Ahmed Ramzy. All rights reserved.
//

import Foundation

struct Contact: Hashable {
    var name: String
    var phone: String
    var type: ContactType
}
          
enum ContactType{
    case lintSchool
    case swiftCairo
}

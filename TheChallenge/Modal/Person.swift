//
//  Person.swift
//  TheChallenge
//
//  Created by Trevor Walker on 7/19/19.
//  Copyright © 2019 Trevor Walker. All rights reserved.
//

import Foundation
//Makes Person
struct Person: Equatable {
    var person: String
}

//Makes an array of people
struct People: Equatable {
    var people: [Person]
}

//Makes a 2d array on people
struct Group: Equatable {
    var group: [[People]]
}

//
//  Pet.swift
//  Pet Shop
//
//  Created by Ferry Dwianta P on 17/04/24.
//

import Foundation

struct Pet: Codable, Hashable {
    let id: String
    let url: String
    let breeds: [Breed]?
    let width: Int?
    let height: Int?
    var price: Int?
}

//
//  Breed.swift
//  Pet Shop
//
//  Created by Ferry Dwianta P on 17/04/24.
//

import Foundation

struct Breed: Codable, Hashable {
    let weight, height: Size
    let id: Int
    let name, lifeSpan: String
    let breedGroup, bredFor: String?
    let temperament, referenceImageID: String

    enum CodingKeys: String, CodingKey {
        case weight, height, id, name
        case bredFor = "bred_for"
        case breedGroup = "breed_group"
        case lifeSpan = "life_span"
        case temperament
        case referenceImageID = "reference_image_id"
    }
}

struct Size: Codable, Hashable {
    let imperial, metric: String
}

//
//  Meme.swift
//  StatesideTest
//
//  Created by Ernesto Gonzalez on 1/22/18.
//  Copyright © 2018 Ernesto Gonzalez. All rights reserved.
//

import Foundation

struct Meme: Decodable {

    var displayName: String
    var ranking: Int
    var imageUrl: String
}

extension Meme: Equatable {

    static func == (lhs: Meme, rhs: Meme) -> Bool {
        return lhs.ranking == rhs.ranking
    }
}

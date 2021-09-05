//
//  Card.swift
//  X_Project_Storyboard
//
//  Created by Юрий Ни on 05.09.2021.
//

import Foundation

struct Card {
    var identifier: Int
    var isMatch: Bool = false
    var isFaced: Bool = false

    static var identifierFactory = 0
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }

    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}

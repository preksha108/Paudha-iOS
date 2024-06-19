//
//  CardModel.swift
//  PaudhaUI
//
//  Created by Anant Narain on 18/01/24.
//

import Foundation

struct CardModel: Identifiable {
    let id = UUID()
    let title: String
    let content: String
}

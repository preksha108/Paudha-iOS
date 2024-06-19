//
//  Page.swift
//  PaudhaUI
//
//  Created by user1 on 23/03/24.
//

import Foundation

struct Page: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var description: String
    var imageUrl: String
    var tag: Int
    
    static var samplePage = Page(name: "Title Example", description: "This is a sample description for the purpose of debugging", imageUrl: "work", tag: 0)
    static var samplePages: [Page] = [
        Page(name: "Welcome to Paudha!", description: "Make your plants smile....", imageUrl: "logo", tag: 0),
        Page(name: "Green Guardian", description: "Identify your plants,Diagnose their health,Keep them happy", imageUrl: "ob2", tag: 1),
        Page(name: "Care Reminders", description: "Keep your plant care schedule in check!", imageUrl: "ob1", tag: 2),
    ]
}

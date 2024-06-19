//
//  Reminder.swift
//  PaudhaUI
//
//  Created by user1 on 13/02/24.
//

import SwiftUI
import UserNotifications
import EventKit

struct Reminder: Identifiable, Codable {
    var id = UUID()
    var name: String
    var imageData: Data?
    var location: String
    var action: String
    var repeatOptions: [Date]
    var time: Date
    var lastWatering: Date
    var isCompleted: Bool = false
    
    // Computed property to convert Data to UIImage
    var image: UIImage? {
        guard let imageData = imageData else { return nil }
        return UIImage(data: imageData)
    }
    
    // Initializer to accept all parameters
    init(name: String, imageData: Data?, location: String, action: String, repeatOptions: [Date], time: Date, lastWatering: Date) {
        self.name = name
        self.imageData = imageData
        self.location = location
        self.action = action
        self.repeatOptions = repeatOptions
        self.time = time
        self.lastWatering = lastWatering
    }
}

//  Copyright © 2019 Frulwinn. All rights reserved.

import Foundation

struct Users: Codable {
    var id: String
    var username: String //required 32 char max
    var password: String //required 32 char max
    var avatar: String
    var activity: [Activity]
    var reflection: [Reflection]
}

struct Activity: Codable, Equatable {
    var name: String //title
    var engagement: Int
    var enjoymentLevel: Int
    var energyLevel: Int
    let timestamp: Date
    let identifier: String
    
    init(name: String, engagement: Int, enjoymentLevel: Int, energyLevel: Int, timestamp: Date = Date(), identifier: String = UUID().uuidString) {
        (self.name, self.engagement, self.enjoymentLevel, self.energyLevel, self.timestamp, self.identifier) = (name, engagement, enjoymentLevel, energyLevel, timestamp, identifier)
    }
}

struct Reflection: Codable, Equatable {
    var journalEntry: String
    let timestamp: Date
    var suprises: String
    var insights: String
    let identifier: String
    
    init(journalEntry: String, timestamp: Date = Date(), surprises: String, insights: String, identifier: String = UUID().uuidString) {
        (self.journalEntry, self.timestamp, self.suprises, self.insights, self.identifier) = (journalEntry, timestamp, surprises, insights, identifier)
    }
}

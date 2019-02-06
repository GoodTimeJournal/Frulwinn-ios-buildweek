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
    let id: String
    
    init(name: String, engagement: Int, enjoymentLevel: Int, energyLevel: Int, timestamp: Date = Date(), id: String = UUID().uuidString) {
        (self.name, self.engagement, self.enjoymentLevel, self.energyLevel, self.timestamp, self.id) = (name, engagement, enjoymentLevel, energyLevel, timestamp, id)
    }
}

struct Reflection: Codable, Equatable {
    var journalEntry: String
    let timestamp: Date
    var suprises: String
    var insights: String
    let id: String
    
    init(journalEntry: String, timestamp: Date = Date(), surprises: String, insights: String, id: String = UUID().uuidString) {
        (self.journalEntry, self.timestamp, self.suprises, self.insights, self.id) = (journalEntry, timestamp, surprises, insights, id)
    }
}

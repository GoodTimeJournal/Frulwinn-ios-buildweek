//  Copyright © 2019 Frulwinn. All rights reserved.

import Foundation

struct Users: Codable {
    var id: String
    var name: String
    var username: String //required 32 char max
    var password: String //required 32 char max
    var email: String
    var avatar: String
    var activity: [Activity]
    var reflection: [Reflection]
}

struct Activity: Codable, Equatable {
    var name: String //title
    var engagement: Int
    var enjoymentRating: Int
    var energyLevel: Int
    let timestamp: Date
    let id: String
    
    init(name: String, engagement: Int, enjoymentRating: Int, energyLevel: Int, timestamp: Date = Date(), id: String = UUID().uuidString) {
        (self.name, self.engagement, self.enjoymentRating, self.energyLevel, self.timestamp, self.id) = (name, engagement, enjoymentRating, energyLevel, timestamp, id)
    }
}

struct Reflection: Codable, Equatable {
    var journalEntry: String
    let timestamp: Date
    var suprises: String
    var insights: String
    var trends: String
    let id: String
    
    init(journalEntry: String, timestamp: Date = Date(), surprises: String, insights: String, trends: String, id: String = UUID().uuidString) {
        (self.journalEntry, self.timestamp, self.suprises, self.insights, self.trends, self.id) = (journalEntry, timestamp, surprises, insights, trends, id)
    }
}

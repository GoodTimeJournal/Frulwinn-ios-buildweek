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
    let fk: Int
    
    init(name: String, engagement: Int, enjoymentRating: Int, energyLevel: Int, timestamp: Date = Date(), fk: Int = UUID().hashValue) {
        (self.name, self.engagement, self.enjoymentRating, self.energyLevel, self.timestamp, self.fk) = (name, engagement, enjoymentRating, energyLevel, timestamp, fk)
    }
}

typealias Reflections = [Reflection]

struct Reflection: Codable, Equatable {
    var journalEntry: String
    let timestamp: String?
    var surprises: String
    var insights: String
    var trends: String
    var week: String
    let fk: Int
    var id: Int
    
    init(journalEntry: String, timestamp: String?, surprises: String, insights: String, trends: String, week: String, fk: Int = UUID().hashValue, id: Int) {
        (self.journalEntry, self.timestamp, self.surprises, self.insights, self.trends, self.week, self.fk, self.id) = (journalEntry, timestamp, surprises, insights, trends, week, fk, id)
    }
}

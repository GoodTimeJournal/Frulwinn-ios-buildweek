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
    var name: String
    var engagement: Int
    var enjoymentRating: Int
    var energyLevel: Int
    let timestamp: String?
    let fk: Int
    var id: Int
    
    init(name: String, engagement: Int, enjoymentRating: Int, energyLevel: Int, timestamp: String?, fk: Int = UUID().hashValue, id: Int) {
        (self.name, self.engagement, self.enjoymentRating, self.energyLevel, self.timestamp, self.fk, self.id) = (name, engagement, enjoymentRating, energyLevel, timestamp, fk, id)
    }
}

typealias Reflections = [Reflection]
typealias Activities = [Activity]

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

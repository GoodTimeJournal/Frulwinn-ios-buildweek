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
    var enjoyment: Int
    var energy: Int
    let timestamp: Date
    let identifier: String
    
    init(name: String, engagement: Int, enjoyment: Int, energy: Int, timestamp: Date = Date(), identifier: String = UUID().uuidString) {
        (self.name, self.engagement, self.enjoyment, self.energy, self.timestamp, self.identifier) = (name, engagement, enjoyment, energy, timestamp, identifier)
    }
}

struct Reflection: Codable {
    var journalEntry: String // journal entry title?
    let timestamp: Date
    var suprises: String //surprises worked
    var insights: String // insights did not work
    let identifier: String
    
    init(journalEntry: String, timestamp: Date = Date(), surprises: String, insights: String, identifier: String = UUID().uuidString) {
        (self.journalEntry, self.timestamp, self.suprises, self.insights, self.identifier) = (journalEntry, timestamp, surprises, insights, identifier)
    }
}

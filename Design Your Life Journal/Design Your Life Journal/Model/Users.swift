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
    var engagement: String //detail
    var timestamp: Date
    var enjoymentRating: Int
    
    init(name: String, engagement: String, timestamp: Date = Date(), enjoymentRating: Int) {
        (self.name, self.engagement, self.timestamp, self.enjoymentRating) = (name, engagement, timestamp, enjoymentRating)
    }
}

struct Reflection: Codable {
    var journalEntry: String // journal entry title?
    var timestamp: Date
    var suprises: String //surprises worked
    var insights: String // insights did not work
    
    init(journalEntry: String, timestamp: Date = Date(), surprises: String, insights: String) {
        (self.journalEntry, self.timestamp, self.suprises, self.insights) = (journalEntry, timestamp, surprises, insights)
    }
}

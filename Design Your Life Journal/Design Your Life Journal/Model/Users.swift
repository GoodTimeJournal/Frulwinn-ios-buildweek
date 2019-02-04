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

struct Activity: Codable {
    var timestamp: String
    var name: String //title
    var engagement: String //detail
    var enjoymentRating: Int
}

struct Reflection: Codable {
    var timestamp: String
    var journalEntry: String // journal entry title?
    var suprises: String //surprises worked
    var insights: String // insights did not work
    
}

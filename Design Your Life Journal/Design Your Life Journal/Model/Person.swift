//  Copyright © 2019 Frulwinn. All rights reserved.

import UIKit

struct Person: Codable {
    var name: String
    var profilePic: String
    var activityLog: [ActivityLog]
    var reflectionLog: [ReflectionLog]
}

struct ActivityLog: Codable {
    var timestamp: String
    var activityTitle: String
    var activityDetail: String
    var isEnjoy: Bool = false
}

struct ReflectionLog: Codable {
    var timestamp: String
    var reflectionTitle: String
    var reflectionDetailWork: String
    var reflectionDetailNotWork: String
    
}

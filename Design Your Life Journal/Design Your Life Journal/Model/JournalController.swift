//  Copyright © 2019 Frulwinn. All rights reserved.

import Foundation

//let baseURL = URL(string: "https://books-2462b.firebaseio.com/")!
let baseURL = URL(string: "https://polar-plateau-24996.herokuapp.com/activities")!

enum httpMethod: String {
    case put = "PUT"
    case delete = "DELETE"
    case post = "POST"
}

class JournalController {
    
    //MARK: - Properties
    private(set) var activities: [Activity] = []
    private(set) var reflections: [Reflection] = []
    
    //for activity
    func postActivity(activity: Activity, completion: @escaping (Error?) -> Void) {
        
        let authToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImFkbWluIiwicGFzc3dvcmQiOiIkMmEkMTQkSk8vbHB4RjZKa1MwUVhleFNwMmZHdS9Pc1lvU01URU1TZnF4YURac2VVclFyUkdiR2FiVlciLCJpYXQiOjE1NDk0MjAwODcsImV4cCI6MTU0OTc4MDA4N30.9Ke9kzZ9kCZA97ds-AQZuEm-f_N38rIODkzqA9tkGYk" //provided by Backend

        let url = baseURL
      
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.post.rawValue
        urlRequest.setValue(authToken, forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let activity: [String: Any] = ["name": activity.name, "fk": 1, "enjoymentRating": activity.enjoymentRating, "energyLevel": activity.energyLevel, "engagement": activity.engagement]
        let jsonTodo: Data
        do {
            jsonTodo = try JSONSerialization.data(withJSONObject: activity, options: [])
            urlRequest.httpBody = jsonTodo
        } catch {
            print("Error: cannot create JSON from todo")
            return
        }
        
//        do {
//            let jsonEncoder = JSONEncoder()
//            urlRequest.httpBody = try jsonEncoder.encode(activity)
//        } catch {
//            NSLog("error encoding reflection")
//            completion(error)
//            return
//        }
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (_, response, error) in
            print(response)
            if let error = error {
                NSLog("error trying to POST data: \(error)")
                completion(error)
                return
            }
            completion(nil)
        }
        dataTask.resume()
    }
    
    func createActivity(name: String, engagement: Int, enjoymentRating: Int, energyLevel: Int, fk: Int, completion: @escaping (Error?) -> Void) {
        
        let activity = Activity(name: name, engagement: engagement, enjoymentRating: enjoymentRating, energyLevel: energyLevel, fk: fk)
        postActivity(activity: activity, completion: completion)
    }
    
    func updateActivity(activity: Activity, name: String, engagement: Int, enjoymentRating: Int, energyLevel: Int, fk: Int, completion: @escaping (Error?) -> Void) {
        let authToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImFkbWluIiwicGFzc3dvcmQiOiIkMmEkMTQkSk8vbHB4RjZKa1MwUVhleFNwMmZHdS9Pc1lvU01URU1TZnF4YURac2VVclFyUkdiR2FiVlciLCJpYXQiOjE1NDk0MjAwODcsImV4cCI6MTU0OTc4MDA4N30.9Ke9kzZ9kCZA97ds-AQZuEm-f_N38rIODkzqA9tkGYk" //provided by Backend

        guard let index = activities.index(of: activity) else { return }
        
        activities[index].name = name
        activities[index].engagement = engagement
        activities[index].enjoymentRating = enjoymentRating
        activities[index].energyLevel = energyLevel
        postActivity(activity: activities[index], completion: completion)
    }
    
    func fetchActivities(completion: @escaping (Error?) -> Void) {
        let authToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImFkbWluIiwicGFzc3dvcmQiOiIkMmEkMTQkSk8vbHB4RjZKa1MwUVhleFNwMmZHdS9Pc1lvU01URU1TZnF4YURac2VVclFyUkdiR2FiVlciLCJpYXQiOjE1NDk0MjAwODcsImV4cCI6MTU0OTc4MDA4N30.9Ke9kzZ9kCZA97ds-AQZuEm-f_N38rIODkzqA9tkGYk" //provided by Backend

        let url = baseURL.appendingPathExtension("activity")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(authToken, forHTTPHeaderField: "Authorization") // authToken here will be the authorization
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("unable to decode activity: \(error)")
                completion(error)
                return
            }
            
            if let data = data {
                let jsonDecoder = JSONDecoder()
                
                do {
                    let activitiesDictionary = try jsonDecoder.decode([String: Activity].self, from: data)
                    let activities = activitiesDictionary.map { $0.value }
                    self.activities = activities.sorted(by: { $0.timestamp > $1.timestamp })
                    completion(nil)
                } catch {
                    NSLog("could not decode activity data")
                    completion(error)
                    return
                }
            }
        }
        dataTask.resume()
    }
    func deleteActivity(activity: Activity, completion: @escaping (Error?) -> Void) {
        let authToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImFkbWluIiwicGFzc3dvcmQiOiIkMmEkMTQkSk8vbHB4RjZKa1MwUVhleFNwMmZHdS9Pc1lvU01URU1TZnF4YURac2VVclFyUkdiR2FiVlciLCJpYXQiOjE1NDk0MjAwODcsImV4cCI6MTU0OTc4MDA4N30.9Ke9kzZ9kCZA97ds-AQZuEm-f_N38rIODkzqA9tkGYk" //provided by Backend

        let url = baseURL.appendingPathComponent(String(activity.fk))
            .appendingPathExtension("activity")
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.delete.rawValue
        request.addValue(authToken, forHTTPHeaderField: "Authorization") // authToken here will be the authorization
        
        do {
            let encoder = JSONEncoder()
            let encodedActivity = try encoder.encode(activity)
            request.httpBody = encodedActivity
        } catch {
            NSLog("error encoding activity: \(error)")
            completion(error)
            return
        }
        
        
        let dataTask = URLSession.shared.dataTask(with: request) { (_, response, error) in
            print(response)
            if let error = error {
                NSLog("error trying to delete activity data: \(error)")
                completion(error)
                return
            }
            
            guard let index = self.activities.index(of: activity) else { return }
            self.activities.remove(at: index)
            completion(nil)
        }
        dataTask.resume()
    }
    
    //for reflection
    func postReflection(reflection: Reflection, completion: @escaping (Error?) -> Void) {
        let authToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImFkbWluIiwicGFzc3dvcmQiOiIkMmEkMTQkSk8vbHB4RjZKa1MwUVhleFNwMmZHdS9Pc1lvU01URU1TZnF4YURac2VVclFyUkdiR2FiVlciLCJpYXQiOjE1NDk0MjAwODcsImV4cCI6MTU0OTc4MDA4N30.9Ke9kzZ9kCZA97ds-AQZuEm-f_N38rIODkzqA9tkGYk" //provided by Backend

        let url = baseURL.appendingPathComponent(reflection.id).appendingPathExtension("json")
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.post.rawValue
        
        do {
            let jsonEncoder = JSONEncoder()
            urlRequest.httpBody = try jsonEncoder.encode(reflection)
        } catch {
            NSLog("error encoding reflection")
            completion(error)
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (_, _, error) in
            if let error = error {
                NSLog("error trying to PUT data: \(error)")
                completion(error)
                return
            }
            completion(nil)
        }
        dataTask.resume()
    }
    
    func createReflection(journalEntry: String, surprises: String, insights: String, trends: String, completion: @escaping (Error?) -> Void) {
        let authToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImFkbWluIiwicGFzc3dvcmQiOiIkMmEkMTQkSk8vbHB4RjZKa1MwUVhleFNwMmZHdS9Pc1lvU01URU1TZnF4YURac2VVclFyUkdiR2FiVlciLCJpYXQiOjE1NDk0MjAwODcsImV4cCI6MTU0OTc4MDA4N30.9Ke9kzZ9kCZA97ds-AQZuEm-f_N38rIODkzqA9tkGYk" //provided by Backend

        let reflection = Reflection(journalEntry: journalEntry, surprises: surprises, insights: insights, trends: trends)
        postReflection(reflection: reflection, completion: completion)
    }
    
    func updateReflection(reflection: Reflection, journalEntry: String, surprises: String, insights: String, trends: String, completion: @escaping (Error?) -> Void) {
        let authToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImFkbWluIiwicGFzc3dvcmQiOiIkMmEkMTQkSk8vbHB4RjZKa1MwUVhleFNwMmZHdS9Pc1lvU01URU1TZnF4YURac2VVclFyUkdiR2FiVlciLCJpYXQiOjE1NDk0MjAwODcsImV4cCI6MTU0OTc4MDA4N30.9Ke9kzZ9kCZA97ds-AQZuEm-f_N38rIODkzqA9tkGYk" //provided by Backend

        guard let index = reflections.index(of: reflection) else { return }

        reflections[index].journalEntry = journalEntry
        reflections[index].suprises = surprises
        reflections[index].insights = insights
        reflections[index].trends = trends
        postReflection(reflection: reflections[index], completion: completion)
    }
    
    func fetchReflections(completion: @escaping (Error?) -> Void) {
        let authToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImFkbWluIiwicGFzc3dvcmQiOiIkMmEkMTQkSk8vbHB4RjZKa1MwUVhleFNwMmZHdS9Pc1lvU01URU1TZnF4YURac2VVclFyUkdiR2FiVlciLCJpYXQiOjE1NDk0MjAwODcsImV4cCI6MTU0OTc4MDA4N30.9Ke9kzZ9kCZA97ds-AQZuEm-f_N38rIODkzqA9tkGYk" //provided by Backend
        let url = baseURL.appendingPathExtension("reflections")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(authToken, forHTTPHeaderField: "Authorization") //authToken here will be the authorization token provided by Travis
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("error getting reflections: \(error)")
                //completion(error)
                return
            }
            
            guard let data = data else {
                completion(error)
                return
            }
                
                do {
                    let jsonDecoder = JSONDecoder()
                    let reflections = try jsonDecoder.decode(Reflection.self, from: data)
                    //let reflection = reflections.map { $0.value }
                    print("reflections", reflections)
                    //self.reflections = reflections.sorted(by: { $0.timestamp > $1.timestamp })
                    //completion(nil)
                    self.reflections = [reflections]
                } catch {
                    NSLog("could not decode activity data")
                    completion(error)
                    return
                }
            }
        dataTask.resume()
    }
    
    func deleteReflection(reflection: Reflection, completion: @escaping (Error?) -> Void) {
        let authToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImFkbWluIiwicGFzc3dvcmQiOiIkMmEkMTQkSk8vbHB4RjZKa1MwUVhleFNwMmZHdS9Pc1lvU01URU1TZnF4YURac2VVclFyUkdiR2FiVlciLCJpYXQiOjE1NDk0MjAwODcsImV4cCI6MTU0OTc4MDA4N30.9Ke9kzZ9kCZA97ds-AQZuEm-f_N38rIODkzqA9tkGYk" //provided by Backend

        let url = baseURL.appendingPathComponent(reflection.id)
            .appendingPathExtension("reflection")
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.delete.rawValue
        request.addValue(authToken, forHTTPHeaderField: "Authorization") // authToken here will be the authorization
        
        do {
            let encoder = JSONEncoder()
            let encodedActivity = try encoder.encode(reflection)
            request.httpBody = encodedActivity
        } catch {
            NSLog("error encoding activity: \(error)")
            completion(error)
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                NSLog("error trying to delete reflection data: \(error)")
                completion(error)
                return
            }
            //NEED TO FIX
            guard let index = self.reflections.index(of: reflection) else { return }
            self.reflections.remove(at: index)
            completion(nil)
        }
        dataTask.resume()
    }
}

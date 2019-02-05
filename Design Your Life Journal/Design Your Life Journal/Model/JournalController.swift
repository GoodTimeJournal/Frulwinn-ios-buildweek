//  Copyright © 2019 Frulwinn. All rights reserved.

import Foundation

let baseURL = URL(string: "https://books-2462b.firebaseio.com/")!

enum httpMethod: String {
    case put = "PUT"
    case delete = "DELETE"
}

class JournalController {
    
    //MARK: - Properties
    private(set) var activities: [Activity] = []
    private(set) var reflections: [Reflection] = []
    
    //for activity
    func searchActivity(searchTerm: String, completion: @escaping (Error?) -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchQueryItem = URLQueryItem(name: "name", value: searchTerm)
        urlComponents?.queryItems = [searchQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            NSLog("wasn't able to construct URL")
            completion(NSError())
            return
        }
        let dataTask = URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("error fetching search results for activities : \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("results didn't return valid data")
                completion(NSError())
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let activities = try jsonDecoder.decode([Activity].self, from: data)
                self.activities = activities
                completion(nil)
            } catch {
                NSLog("error decoding JSON: \(error)")
                completion(error)
                return
            }
        }
        dataTask.resume()
    }
    
    func putActivity(activity: Activity, completion: @escaping (Error?) -> Void) {
        let url = baseURL.appendingPathComponent(activity.identifier).appendingPathExtension("json")
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.put.rawValue
        
        do {
            let jsonEncoder = JSONEncoder()
            urlRequest.httpBody = try jsonEncoder.encode(activity)
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
    
    func createActivity(name: String, engagement: String, enjoymentRating: Int, completion: @escaping (Error?) -> Void) {
        let activity = Activity(name: name, engagement: engagement, enjoymentRating: enjoymentRating)
        putActivity(activity: activity, completion: completion)
    }
    
    func updateActivity(activity: Activity, name: String, engagement: String, enjoymentRating: Int, completion: @escaping (Error?) -> Void) {
        guard let index = activities.index(of: activity) else { return }
        activities[index].name = name
        activities[index].engagement = engagement
        activities[index].enjoymentRating = enjoymentRating
        putActivity(activity: activities[index], completion: completion)
    }
    
    func fetchActivities(completion: @escaping (Error?) -> Void) {
        let url = baseURL.appendingPathExtension("json")
        
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
        let url = baseURL.appendingPathComponent(activity.identifier)
            .appendingPathExtension("json")
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.delete.rawValue
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (_, _, error) in
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
    func putReflection(reflection: Reflection, completion: @escaping (Error?) -> Void) {
        let url = baseURL.appendingPathComponent(reflection.identifier).appendingPathExtension("json")
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.put.rawValue
        
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
    
    func createReflection(journalEntry: String, surprises: String, insights: String, completion: @escaping (Error?) -> Void) {
        let reflection = Reflection(journalEntry: journalEntry, surprises: surprises, insights: insights)
        putReflection(reflection: reflection, completion: completion)
    }
    
    func updateReflection(reflection: Reflection, journalEntry: String, surprises: String, insights: String, completion: @escaping (Error?) -> Void) {
        //NEED TO FIX
//        guard let index = reflections.index(of: reflection) else { return }
//
//        reflections[index].journalEntry = journalEntry
//        reflections[index].surprises = surprises
//        reflections[index].insights = insights
//        putReflection(reflection: reflections[index], completion: completion)
    }
    
    func fetchReflections(completion: @escaping (Error?) -> Void) {
        let url = baseURL.appendingPathExtension("json")
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("unable to decode activity: \(error)")
                completion(error)
                return
            }
            
            if let data = data {
                let jsonDecoder = JSONDecoder()
                
                do {
                    let reflectionsDictionary = try jsonDecoder.decode([String: Reflection].self, from: data)
                    let reflections = reflectionsDictionary.map { $0.value }
                    self.reflections = reflections.sorted(by: { $0.timestamp > $1.timestamp })
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
    
    func deleteReflection(reflection: Reflection, completion: @escaping (Error?) -> Void) {
        let url = baseURL.appendingPathComponent(reflection.identifier)
            .appendingPathExtension("json")
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.delete.rawValue
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (_, _, error) in
            if let error = error {
                NSLog("error trying to delete reflection data: \(error)")
                completion(error)
                return
            }
            //NEED TO FIX
//            guard let index = self.reflections.index(at: reflection) else { return }
//            self.reflections.remove(at: index)
            completion(nil)
        }
        dataTask.resume()
    }
    
    func searchReflection(searchTerm: String, completion: @escaping (Error?) -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchQueryItem = URLQueryItem(name: "journalEntry", value: searchTerm)
        urlComponents?.queryItems = [searchQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            NSLog("wasn't able to construct URL")
            completion(NSError())
            return
        }
        let dataTask = URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("error fetching search results for reflections : \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("results didn't return valid data")
                completion(NSError())
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let reflections = try jsonDecoder.decode([Reflection].self, from: data)
                self.reflections = reflections
                completion(nil)
            } catch {
                NSLog("error decoding JSON: \(error)")
                completion(error)
                return
            }
        }
        dataTask.resume()
    }
}

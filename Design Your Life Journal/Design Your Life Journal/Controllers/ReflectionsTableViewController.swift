//
//  ReflectionsTableViewController.swift
//  Design Your Life Journal
//
//  Created by Lambda_School_Loaner_34 on 2/4/19.
//  Copyright © 2019 Frulwinn. All rights reserved.
//

import UIKit

class ReflectionsTableViewController: UITableViewController {
    
    //MARK: - Properties
    let journalController = JournalController()
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        journalController.fetchReflections { (error) in
            if let error = error {
                NSLog("Could not fetch data from reflections: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journalController.reflections.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reflectionCell", for: indexPath) as! ReflectionsTVCell

        let reflection = journalController.reflections[indexPath.row]
        cell.reflection = reflection
        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let reflection = journalController.reflections[indexPath.row]
        
        if editingStyle == .delete {
            journalController.deleteReflection(reflection: reflection) { (error) in
                if let error = error {
                    NSLog("Could not delete reflection: \(error)")
                    return
                }
                DispatchQueue.main.async {
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addReflectionsSegue" {
            guard let destination = segue.destination as? ReflectionsDetailVC else { return }
            
            destination.journalController = journalController
            
        } else if segue.identifier == "reflectionsCellSegue" {
            guard let destination = segue.destination as? ReflectionsDetailVC,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            
            destination.journalController = journalController
            destination.reflection = journalController.reflections[indexPath.row]
        }
    }
}

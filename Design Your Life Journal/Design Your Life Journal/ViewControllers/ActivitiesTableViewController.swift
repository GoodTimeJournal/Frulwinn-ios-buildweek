//  Copyright © 2019 Frulwinn. All rights reserved.

import UIKit

class ActivitiesTableViewController: UITableViewController {
    
    //MARK: - Properties
    let journalController = JournalController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
        journalController.fetchActivities { (error) in
            if let error = error {
                NSLog("Could not fetch activity data: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTheme()
        journalController.fetchActivities { (error) in
            if let error = error {
                NSLog("Could not fetch activity data: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func setTheme() {
        //textfield
        tableView.separatorColor = .lightGray
        view.backgroundColor = .white
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journalController.activities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "activitiesCell", for: indexPath) as! ActivitiesTVCell

        let activity = journalController.activities[indexPath.row]
        cell.activity = activity
        style(cell: cell)
        return cell
    }
    
    func style(cell: UITableViewCell) {
        cell.textLabel?.font = Appearance.montserratRegularFont(with: .caption1, pointSize: 24)
        cell.textLabel?.adjustsFontForContentSizeCategory = true
        cell.textLabel?.textColor = .skyBlue
        cell.textLabel?.backgroundColor = .clear
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
    }


    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let activity = journalController.activities[indexPath.row]
        
        if editingStyle == .delete {
            journalController.deleteActivity(activity: activity) { (error) in
                if let error = error {
                    NSLog("Could not delete activity: \(error)")
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
        if segue.identifier == "activitiesAddSegue" {
            guard let destination = segue.destination as? ActivitiesDetailVC else { return }
            
            destination.journalController = journalController
            
        } else if segue.identifier == "activitiesCellSegue" {
            guard let destination = segue.destination as? ActivitiesDetailVC,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            
            destination.journalController = journalController
            destination.activity = journalController.activities[indexPath.row]
        }
    }
}

//  Copyright © 2019 Frulwinn. All rights reserved.

import UIKit

class ReflectionsTableViewController: UITableViewController {
    
    //MARK: - Properties
    let journalController = JournalController()
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTheme()
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
    
    func setTheme() {
        //textfield
        tableView.separatorColor = .skyBlue
        view.backgroundColor = .white
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journalController.reflections.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reflectionCell", for: indexPath) as! ReflectionsTVCell

        let reflection = journalController.reflections[indexPath.row]
        cell.reflection = reflection
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

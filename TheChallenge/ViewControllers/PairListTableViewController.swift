//
//  PairListTableViewController.swift
//  TheChallenge
//
//  Created by Trevor Walker on 7/19/19.
//  Copyright © 2019 Trevor Walker. All rights reserved.
//

import UIKit

class PairListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return PersonController.shared.groups.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return PersonController.shared.groups[section].count
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Group \(section + 1)"
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        cell.textLabel?.text = PersonController.shared.groups[indexPath.section][indexPath.row]
        return cell
    }
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            PersonController.shared.delete(name: PersonController.shared.groups[indexPath.section][indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    @IBAction func addTapped(_ sender: Any) {
        presentAlert()
    }
    @IBAction func radomizeTapped(_ sender: Any) {
        PersonController.shared.randomize()
        self.tableView.reloadData()
    }
}
extension PairListTableViewController: UIAlertViewDelegate{
    func presentAlert() {
        //Setting up Alert
        let alertController = UIAlertController(title: "Add Person", message: "Add someone new to the list.", preferredStyle: .alert)
        //Customizing Alert
        alertController.addTextField { (textField) -> Void in
            textField.placeholder = "FullName"
            textField.autocorrectionType = .yes
            textField.autocapitalizationType = .sentences
        }
        //Actions
        let addAction = UIAlertAction(title: "Add Person", style: .default) { (_) in
            guard let textInField = alertController.textFields?.first?.text else {return}
            if textInField != "" {
                PersonController.shared.add(name: textInField)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        let cancelAction = UIAlertAction(title:"Cancel", style: .destructive)
        //Adding Actions
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        //Presenting Alert
        self.present(alertController, animated: true, completion: nil)
    }
}

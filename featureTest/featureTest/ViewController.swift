//
//  ViewController.swift
//  
//
//  Created by Robbie Gay on 2/12/20.
//

import UIKit
import TinyConstraints

class ViewController: UITableViewController {
    
    let humans = ["Robbie", "Anna"]
    let cats = ["Waffles", "Poppy"]
    
    let cellID = "cellID"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sets nav bar title
        navigationItem.title = "Housemates"
        // This line switches the title from large to small when yo scroll
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Names the delegate
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let humansLabel = UILabel()
        humansLabel.text = "Humans"
        humansLabel.backgroundColor = .lightGray
        
        let catLabel = UILabel()
        catLabel.text = "Cats"
        catLabel.backgroundColor = .lightGray
        
        if section == 0 {
            return humansLabel
        } else {
            return catLabel
        }
    }
    
    // Creates table sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // Creates rows for EACH SECTION (Adds all rows to each section)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return humans.count
        } else {
            return cats.count
        }
    }
    
    // Creates the cell in EACH ROW (Adds a cell to each row)
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let humanCell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let catCell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        let humanName = humans[indexPath.row]
        humanCell.textLabel?.text = "\(humanName) [Section: \(indexPath.section) Row: \(indexPath.row)]"
        
        let catName = cats[indexPath.row]
        catCell.textLabel?.text = "\(catName) [Section: \(indexPath.section) Row: \(indexPath.row)]"
        
        if indexPath.section == 0 {
            return humanCell
        } else {
            return catCell

        }
    }
}

// You can right click, and select "refactor" to change all the names in the document at once!

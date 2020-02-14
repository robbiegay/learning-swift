//
//  ViewController.swift
//  
//
//  Created by Robbie Gay on 2/12/20.
//

import UIKit
import TinyConstraints

class ViewController: UITableViewController {
    // Try to write code that allows you to change only these top level variables, and everything below works automatically
        
    let twoDimensionalArray = [
        ["Robbie", "Anna"],
        ["Waffles", "Poppy"],
        ["Table", "Couch", "TV", "Snacks", "Some fruit", "Pots", "Pans", "FireStick", "The remote (somewhere)", "Rug", "Another rug"],
        ["Living Room", "Kitchen", "Bedroom", "Dining Room"]
    ]
    
    let headers = ["Humans", "Cats", "Objects", "Rooms"]
    
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
    
    // Creates headers for sections
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let label = UILabel()
        label.text = headers[section]
        label.backgroundColor = .lightGray
        
        return label
    }
    
    // Creates table sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return twoDimensionalArray.count
    }
    
    // Creates rows for EACH SECTION (Adds all rows to each section)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return twoDimensionalArray[section].count
    }
    
    // Creates the cell in EACH ROW (Adds a cell to each row)
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        let name = twoDimensionalArray[indexPath.section][indexPath.row]
        
        cell.textLabel?.text = "\(name) [Section: \(indexPath.section) Row: \(indexPath.row)]"
        
        return cell
    }
}

// You can right click, and select "refactor" to change all the names in the document at once!

//
//  FruitTableViewController.swift
//  featureTest
//
//  Created by Robbie Gay on 2/12/20.
//  Copyright © 2020 robbiegay. All rights reserved.
//

import UIKit

class FruitTableViewController: UITableViewController {
    
    let fruit = [
        ["Orange", "Grapefruit", "Lemon", "Lime"],
        ["Blueberry", "Rasberry", "Cherry"],
        ["Honeycrisp", "Gala", "Fuji"],
        ["Pineapple", "Mango", "Papaya"],
        ["Anjo", "Asian", "Callery", "Pyrus"]
    ]
    
    let headers = ["Citrus", "Berries", "Apples", "Trpoical", "Pears"]
    
    let cellID = "cellID"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Fruit"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // MISSED REGISTERING CELL
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = headers[section]
        label.backgroundColor = .lightGray
        return label
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fruit.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Missed adding [section]
        return fruit[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let name = fruit[indexPath.section][indexPath.row]
        
        // MISSED THIS PART:
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = fruit[indexPath.section][indexPath.row]
        // -----------------
        
        return cell
    }
}

//
//  ViewController.swift
//  
//
//  Created by Robbie Gay on 2/12/20.
//

import UIKit
import TinyConstraints

class ViewController: UITableViewController {
    
    let data = ["Robbie", "Anna", "Poppy", "Waffles"]
    let cellID = "cellID"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sets nav bar title
        navigationItem.title = "Housemates"
        // This line switches the title from large to small when yo scroll
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
}

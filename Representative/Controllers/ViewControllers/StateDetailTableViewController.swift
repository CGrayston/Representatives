//
//  StateDetailTableViewController.swift
//  Representative
//
//  Created by Chris Grayston on 2/7/19.
//  Copyright © 2019 DevMtnStudent. All rights reserved.
//

import UIKit

class StateDetailTableViewController: UITableViewController {
    
    // Landing pad
    var state: String?
    
    var representatives: [Representative] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 200
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        guard let state = state else { return }
        RepresentativeController.searchRepresentatives(forState: state) { (representatives) in
            
            self.representatives = representatives
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return representatives.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "representativeCell", for: indexPath) as? RepresentativeTableViewCell else { return UITableViewCell() }
        
        let representative = representatives[indexPath.row]
    
        cell.representative = representative
        cell.updateViews()
        
        return cell
    }
    
    
    
}

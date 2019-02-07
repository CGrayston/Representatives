//
//  RepresentativeTableViewCell.swift
//  Representative
//
//  Created by Chris Grayston on 2/7/19.
//  Copyright © 2019 DevMtnStudent. All rights reserved.
//

import UIKit

class RepresentativeTableViewCell: UITableViewCell {

    // Landing Pad
    var representative: Representative? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var partyLabel: UILabel!
    @IBOutlet weak var districtLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    
    func updateViews() {
        
        guard let representative = representative else { return }
        partyLabel.text = representative.party
        districtLabel.text = representative.district
        nameLabel.text = representative.name
        phoneNumberLabel.text = representative.phone
        websiteLabel.text = representative.link
        
        partyLabel.textColor = representative.party == "Republican" ? .red : .blue
        
    }

}

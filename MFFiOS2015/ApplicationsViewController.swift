//
//  ApplicationsViewController.swift
//  MFFiOS2015
//
//  Created by Fernandez Astigarraga Emilio on 08/12/15.
//  Copyright © 2015 avast. All rights reserved.
//

import UIKit

class ApplicationsViewController: UITableViewController {
    
    var applications: [Application]!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return applications.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier", forIndexPath: indexPath) as! ApplicationTableViewCell

        let application = applications[indexPath.row]
        cell.application = application

        return cell
    }

}

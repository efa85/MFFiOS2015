//
//  ViewController.swift
//  MFFiOS2015
//
//  Created by Fernandez Astigarraga Emilio on 01/12/15.
//  Copyright © 2015 avast. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = NSLocalizedString("mapScreen.title", value: "MFF Map", comment: "Map screen title")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

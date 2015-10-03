//
//  ViewController.swift
//  Safe Walk
//
//  Created by angel diaz on 10/3/15.
//  Copyright © 2015 Angel Diaz. All rights reserved.
//

import UIKit
import Parse
import Bolts

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let testObject = PFObject(className: "TestObject")
        testObject["foo"] = "bar"
        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("Object has been saved.")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


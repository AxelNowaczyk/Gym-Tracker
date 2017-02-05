//
//  AddWorkoutViewController.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 30/01/2017.
//  Copyright © 2017 Axel Nowaczyk. All rights reserved.
//

import UIKit

class AddWorkoutTableViewController: UITableViewController {

    @IBAction func leftBarButtonItemWasPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

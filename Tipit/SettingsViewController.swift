//
//  SettingsViewController.swift
//  Tipit
//
//  Created by Nader Neyzi on 8/12/17.
//  Copyright © 2017 Nader Neyzi. All rights reserved.
//

import UIKit

protocol SettingsDelegate: class {
    func changeTipControlIndex(_ index: Int)
}

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipControl: UISegmentedControl!

    let defaults = UserDefaults.standard
    weak var delegate: SettingsDelegate?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        tipControl.selectedSegmentIndex = defaults.object(forKey: "default%Index") as? Int ?? 0
    }

    @IBAction func defaultTipChanged(_ sender: Any) {
        defaults.set(tipControl.selectedSegmentIndex , forKey: "default%Index")
        defaults.synchronize()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if (isMovingFromParentViewController && delegate != nil){
            delegate!.changeTipControlIndex(tipControl.selectedSegmentIndex)
        }
    }
}

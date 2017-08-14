//
//  ViewController.swift
//  Tipit
//
//  Created by Nader Neyzi on 8/12/17.
//  Copyright © 2017 Nader Neyzi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!

    let defaults = UserDefaults.standard

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        tipControl.selectedSegmentIndex = defaults.object(forKey: "default%Index") as? Int ?? 0
        calculateTip(self)
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }

    @IBAction func calculateTip(_ sender: Any) {
        let tipPrecentages = [0.18, 0.20, 0.25]

        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPrecentages[tipControl.selectedSegmentIndex]
        let total = bill + tip

        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let settingsViewController = segue.destination as! SettingsViewController
        settingsViewController.delegate = self
    }
}

extension ViewController: SettingsDelegate {
    func changeTipControlIndex(_ index: Int) {
        tipControl.selectedSegmentIndex = index
    }
}


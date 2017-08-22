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
    @IBOutlet weak var tipView: UIView!
    @IBOutlet weak var billView: UIView!
    @IBOutlet weak var settingBarButton: UIBarButtonItem!

    let defaults = UserDefaults.standard
    let currencyFormatter = NumberFormatter()
    var billFieldCenterY:CGFloat = 0
    var centerHeightOfView:CGFloat = 0
    var darkColor:UIColor = .black
    var lightColor:UIColor = .white

    override func viewDidLoad() {
        super.viewDidLoad()

        //Set colors
        darkColor = tipView.backgroundColor!
        lightColor = view.backgroundColor!
        settingBarButton.tintColor = lightColor
        billField.tintColor = darkColor

        //Set positions
        billFieldCenterY = billField.center.y
        centerHeightOfView = view.center.y - navigationController!.navigationBar.frame.size.height - UIApplication.shared.statusBarFrame.size.height
        billField.center = CGPoint(x: billField.center.x, y: centerHeightOfView)
        tipView.center = CGPoint(x: tipView.center.x, y: tipView.center.y+400)
        tipControl.center = CGPoint(x: tipControl.center.x, y: tipControl.center.y+400)

        //Set billField format
        currencyFormatter.numberStyle = .currency
        billField.placeholder = currencyFormatter.currencySymbol

        //Load stored UI
        loadBill()
        toggleDarkTheme()
        tipControl.selectedSegmentIndex = defaults.object(forKey: "default%Index") as? Int ?? 0

        billField.becomeFirstResponder()
    }

    func loadBill() {
        let dateOfLastBackground = defaults.object(forKey: "dateOfLastBackground") as! Date
        if Date().timeIntervalSince(dateOfLastBackground) < 600 {
            billField.text = defaults.object(forKey: "lastBill") as? String
            if billField.text != "" {
                calculateTip(self)
            }
        }
    }

    @IBAction func calculateTip(_ sender: Any?) {
        if ((sender as? UISegmentedControl) == nil) && billField.text == "" {
            animateViewsDown()
        } else if ((sender as? ViewController) != nil) || (billField.center.y == centerHeightOfView && billField.text?.characters.count == 1) {
            animateViewsUp()
        }

        let tipPrecentages = [0.18, 0.20, 0.25]

        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPrecentages[tipControl.selectedSegmentIndex]
        let total = bill + tip

        let formattedTip = currencyFormatter.string(from: NSNumber(value: tip))
        tipLabel.text = formattedTip
        let formattedTotal = currencyFormatter.string(from: NSNumber(value: total))
        totalLabel.text = formattedTotal
        billField.placeholder = currencyFormatter.currencySymbol
    }

    func animateViewsUp() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.billField.center = CGPoint(x: self.billField.center.x, y: self.billFieldCenterY)
            self.tipView.center = CGPoint(x: self.tipView.center.x, y: self.tipView.center.y-400)
            self.tipControl.center = CGPoint(x: self.tipControl.center.x, y: self.tipControl.center.y-400)
        }) { (finished) in
        }
    }

    func animateViewsDown() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.billField.center = CGPoint(x: self.billField.center.x, y: self.centerHeightOfView)
            self.tipView.center = CGPoint(x: self.tipView.center.x, y: self.tipView.center.y+400)
            self.tipControl.center = CGPoint(x: self.tipControl.center.x, y: self.tipControl.center.y+400)
        }) { (finished) in
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let settingsViewController = segue.destination as! SettingsViewController
        settingsViewController.delegate = self
        settingsViewController.darkColor = darkColor
        settingsViewController.lightColor = lightColor
    }
}

extension ViewController: SettingsDelegate {
    func changeTipControlIndex(_ index: Int) {
        tipControl.selectedSegmentIndex = index
        calculateTip(tipControl)
    }

    func toggleDarkTheme () {
        if defaults.object(forKey: "dark?") as! Bool {
            billField.keyboardAppearance = .dark
            settingBarButton.tintColor = darkColor
        } else {
            billField.keyboardAppearance = .default
            settingBarButton.tintColor = lightColor
        }
    }
}

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
    func toggleDarkTheme()
}

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var defaultTipLabel: UILabel!
    @IBOutlet weak var darkThemeSwitch: UISwitch!
    @IBOutlet weak var darkThemeLabel: UILabel!

    let defaults = UserDefaults.standard
    weak var delegate: SettingsDelegate?
    var darkColor:UIColor = .black
    var lightColor:UIColor = .white

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        tipControl.selectedSegmentIndex = defaults.object(forKey: "default%Index") as? Int ?? 0

        darkThemeSwitch.tintColor = darkColor
        if defaults.object(forKey: "dark?") == nil {
            defaults.set(false, forKey: "dark?")
            defaults.synchronize()
        } else if defaults.object(forKey: "dark?") as! Bool {
            goDark()
            darkThemeSwitch.isOn = true
        }
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

    @IBAction func darkThemeToggled(_ sender: Any?) {
        if defaults.object(forKey: "dark?") as! Bool {
            goLight()
        } else {
            goDark()
        }
        delegate?.toggleDarkTheme()
    }

    func goDark() {
        defaults.set(true , forKey: "dark?")
        view.backgroundColor = darkColor
        navigationController?.navigationBar.backgroundColor = darkColor
        defaultTipLabel.textColor = lightColor
        darkThemeLabel.textColor = lightColor
        tipControl.tintColor = lightColor
        defaults.synchronize()
    }

    func goLight() {
        defaults.set(false , forKey: "dark?")
        view.backgroundColor = lightColor
        navigationController?.navigationBar.backgroundColor = lightColor
        defaultTipLabel.textColor = darkColor
        darkThemeLabel.textColor = darkColor
        tipControl.tintColor = darkColor
        defaults.synchronize()
    }
}

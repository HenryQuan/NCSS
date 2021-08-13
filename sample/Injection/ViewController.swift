//
//  ViewController.swift
//  Injection
//
//  Created by Yiheng Quan on 25/9/20.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var valueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showVerionAlert()
        valueLabel.text = "\(defaultValue())"
        Injection.test()
    }
    
    func showVerionAlert() {
        let pref = UserDefaults.standard
        // Get app version
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        let displayed = pref.bool(forKey: appVersion)
        // Show this only once
        if !displayed {
            let alert = UIAlertController(title: "Version \(appVersion)", message: "A new upgrade with some minor changes :)", preferredStyle: .alert)
            alert.addAction(.init(title: "Close", style: .default))
            self.present(alert, animated: true)
            pref.setValue(true, forKey: appVersion)
        }
    }
    
    @IBAction func onTapMeButtonPressed(_ sender: Any) {
        let value = Int(valueLabel.text!)!
        valueLabel.text = "\(value + 1)"
    }
    
    func defaultValue() -> Int {
        var value = 0
        for i in 0...100 {
            value += i
        }
        return value
    }
}

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
    }
    
    @IBAction func onTapMeButtonPressed(_ sender: Any) {
        let value = Int(valueLabel.text!)!
        valueLabel.text = "\(value + 1)"
    }
}


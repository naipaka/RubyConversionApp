//
//  ViewController.swift
//  RubyConversionApp
//
//  Created by rMac on 2019/07/06.
//  Copyright © 2019 naipaka. All rights reserved.
//

import UIKit

struct Response {
    var request_id = ""
    var output_type = ""
    var converted = ""
}

class ViewController: UIViewController {

    @IBOutlet weak var inputCharacter: UITextField!
    @IBOutlet weak var rubyCharacter: UILabel!
    @IBOutlet weak var outputCharacter: UILabel!
    @IBOutlet weak var outputView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 出力先の枠線の設定
        outputView.layer.borderWidth = 1.0
        outputView.layer.borderColor = UIColor.red.cgColor
    }
    
    @IBAction func convertRuby(_ sender: UIButton) {
        let inputText = inputCharacter.text
        if inputText == "" {
            return
        }
        
        
    }
    
}


//
//  ViewController.swift
//  RubyConversionApp
//
//  Created by rMac on 2019/07/06.
//  Copyright © 2019 naipaka. All rights reserved.
//

import UIKit
import Alamofire
import Keys

struct ResponseData: Codable {
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
        
        // 枠に対して文字の大きさを自動調節
        inputCharacter.adjustsFontSizeToFitWidth = true
        rubyCharacter.adjustsFontSizeToFitWidth = true
        outputCharacter.adjustsFontSizeToFitWidth = true
    }
    
    @IBAction func convertRuby(_ sender: UIButton) {
        guard let inputText = inputCharacter.text else {
            return
        }
        
        if inputText != "" {
            // レスポンスを画面に返す
            HttpRequest(sentence: inputText, completion: {(responseData: ResponseData) -> Void in
                self.outputCharacter.text = inputText
                self.rubyCharacter.text = responseData.converted
            })
        }
    }
    
    // ひらがな化APIにリクエスト送信する
    func HttpRequest(sentence: String, completion: @escaping (ResponseData)->Void) {
        // リクエスト情報
        let url = "https://labs.goo.ne.jp/api/hiragana"
        let headers: HTTPHeaders = [
            "Contenttype": "application/json"
        ]
        let appKey: RubyConversionAppKeys = RubyConversionAppKeys()
        let parameters:[String: Any] = [
            "app_id": appKey.hiraganaAPIKey,
            "sentence": sentence,
            "output_type": "hiragana"
        ]
        
        // リクエスト送信
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            guard let jsonData = response.data else {
                print("response err")
                return
            }
            let responseData = try! JSONDecoder().decode(ResponseData.self, from: jsonData)
            completion(responseData)
        }
    }
    
    @IBAction func downKeyboard(_ sender: Any) {
        inputCharacter.endEditing(true)
    }
}




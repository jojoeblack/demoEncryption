//
//  ViewController.swift
//  demoEncrypt
//
//  Created by MacPro on 2018/5/12.
//  Copyright © 2018年 JoeMac01. All rights reserved.
//

import UIKit
import CryptoSwift

class ViewController: UIViewController {

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var keyTextField: UITextField!
    @IBOutlet weak var outputTextField: UITextField!
    var messageOriginal: String = ""
    let privateKey: String = keyRandom.init().key
    var encryptedStr: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }

    @IBAction func encryptTapped(_ sender: Any) {
        // 資料加密後再使用Base64編碼
        if inputTextField.text != nil {
        messageOriginal = inputTextField.text!
        } else {
            print("input error")
            return
        }
        
        
        
        encryptedStr = messageOriginal.aesEncrypt(key: privateKey , iv: privateKey)!
        keyTextField.text = privateKey
        outputTextField.text = encryptedStr
    }
    
    @IBAction func sendTapped(_ sender: Any) {
        //連到接收頁
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let receiverVC = mainStoryboard.instantiateViewController(withIdentifier: "receiverPage") as! ReceiverViewController
        receiverVC.messageReceived = encryptedStr
        receiverVC.privateKey = privateKey
        self.navigationController?.pushViewController(receiverVC, animated: true)
        return
    }
    
    @IBAction func originalEditted(_ sender: Any) {
    }
    
}

extension String {
    
    /// AES加密
    ///
    /// - Parameters:
    ///   - key: key
    ///   - iv: iv
    /// - Returns: String
    func aesEncrypt(key: String, iv: String) -> String? {
        var result: String?
        do {
            // 用UTF8的编碼方式將字串轉成Data
            let data: Data = self.data(using: String.Encoding.utf8, allowLossyConversion: true)!
            
            // 用AES的方式將Data加密
            let aecEnc: AES = try AES(key: key, iv: iv)
            let enc = try aecEnc.encrypt(data.bytes)
            
            // 使用Base64編碼方式將Data轉回字串
            let encData: Data = Data(bytes: enc, count: enc.count)
            result = encData.base64EncodedString()
        } catch {
            print("\(error.localizedDescription)")
        }
        
        return result
    }
    
    /// AES解密
    ///
    /// - Parameters:
    ///   - key: key
    ///   - iv: iv
    /// - Returns: String
    func aesDecrypt(key: String, iv: String) -> String? {
        var result: String?
        do {
            // 使用Base64的解碼方式將字串解碼後再轉换Data
            let data = Data(base64Encoded: self, options: Data.Base64DecodingOptions(rawValue: 0))!
            
            // 用AES方式將Data解密
            let aesDec: AES = try AES(key: key, iv: iv)
            let dec = try aesDec.decrypt(data.bytes)
            
            // 用UTF8的編碼方式將解完密的Data轉回字串
            let desData: Data = Data(bytes: dec, count: dec.count)
            result = String(data: desData, encoding: .utf8)!
        } catch {
            print("\(error.localizedDescription)")
        }
        
        return result
    }
}

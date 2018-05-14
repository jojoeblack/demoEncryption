//
//  ReceiverViewController.swift
//  demoEncrypt
//
//  Created by MacPro on 2018/5/13.
//  Copyright © 2018年 JoeMac01. All rights reserved.
//

import UIKit
import CryptoSwift

class ReceiverViewController: UIViewController {
    var messageReceived:String = ""
    var privateKey:String = ""
    @IBOutlet weak var originalLbl: UILabel!
    @IBOutlet weak var decryptedLbl: UILabel!
    
    @IBOutlet weak var originalTextField: UITextField!
    
    @IBOutlet weak var decryptedTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        originalTextField.text = messageReceived
        
    }
    
    @IBAction func originalEditted(_ sender: Any) {
    }
    
    @IBAction func decryptedEditted(_ sender: Any) {
    }
    @IBAction func decryptTapped(_ sender: Any) {
        let myAlterController = UIAlertController(title: "解密", message: "請輸入金鑰", preferredStyle: UIAlertControllerStyle.alert)
        myAlterController.addTextField(configurationHandler: {
            (textField: UITextField) -> Void in
            textField.placeholder = "Input Key"
        })
        
        let okAction = UIAlertAction(title: "確認", style: UIAlertActionStyle.destructive, handler: {
            (ACTION) -> Void in
            guard let userKey = myAlterController.textFields![0].text,
            !userKey.isEmpty else
            {
                print("error")
                return
            }
            let userKeyPlusFour = userKey + userKey + userKey + userKey
            if self.privateKey ==  userKeyPlusFour {
                let decryptedStr: String = self.messageReceived.aesDecrypt(key: self.privateKey, iv: self.privateKey)!
                self.decryptedTextField.text = decryptedStr
            } else {
                self.decryptedTextField.text = "請輸入正確金鑰"
            }
        })
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: {
            (ACTION) -> Void in
        })
        
        myAlterController.addAction(cancelAction)
        myAlterController.addAction(okAction)
        self.present(myAlterController, animated: true, completion: nil)
        // 使用Base64解碼後再將資料解密
        
    }
    

}

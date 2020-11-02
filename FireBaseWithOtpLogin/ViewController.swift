//
//  ViewController.swift
//  FireBaseWithOtpLogin
//
//  Created by swapnil jadhav on 30/10/20.
//  Copyright © 2020 t. All rights reserved.
//

import UIKit
import Firebase
class ViewController: UIViewController {

    
    @IBOutlet weak var phoneText: UITextField!
    
    
    @IBOutlet weak var otpText: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth.auth().languageCode = "hi";
        
       
    }
    
    @IBAction func sendOtpToNumber(_ sender: UIButton) {
        
        
        
        guard let phone = phoneText.text else {return}
        PhoneAuthProvider.provider().verifyPhoneNumber(phone, uiDelegate: nil) { (verificationID, error) in
          if let error = error {
           print(error.localizedDescription)
            return
          }
         
         else
          {
              
             
             print(verificationID)
            
            guard let verifyid = verificationID else {return}
            
            
            UserDefaults.standard.set(verifyid, forKey: "verificationId")
            
           
         }
         
        }
         
         
        
        
    }
    
    @IBAction func LoginAction(_ sender: UIBarButtonItem) {
        
        
        guard let otp = otpText.text else {return}
        
        
        guard let verificationId = UserDefaults.standard.string(forKey: "verificationId") else {
            return
        }
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: otp)
        
        Auth.auth().signIn(with: credential) { (success, error) in
            
            if error == nil
            {
                
                let phone = self.phoneText.text
                
                let alertController = UIAlertController(title: "Got it", message: "\(phone) you are true user", preferredStyle: .alert)
                
                
                let action = UIAlertAction(title: "Ok", style: .default) { (alertaction) in
                
                    
                    
                }
                alertController.addAction(action)
                
                self.present(alertController, animated: true, completion: nil)
                
                
            }
            else
            {
                let phone = self.phoneText.text
                
                let alertController = UIAlertController(title: "Fault", message: "\(phone) you are wrong user", preferredStyle: .alert)
                
                
                let action = UIAlertAction(title: "Ok", style: .default) { (alertaction) in
                
                    
                    
                }
                alertController.addAction(action)
                
                self.present(alertController, animated: true, completion: nil)
                
                
                
               
            }
        }
    }
    

}


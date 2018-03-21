//
//  FirstViewController.swift
//  tempproj-mdavia
//
//  Created by Alexander Otpushchenko on 19.03.2018.
//  Copyright © 2018 Alex Otpushchenko. All rights reserved.
//

import UIKit
import Firebase

class FirstViewController: UIViewController {
    
    @IBOutlet weak var TextPhoneNum: UITextField!
    @IBOutlet weak var TextMail: UITextField!
    
    @IBOutlet weak var LabelPhoneNum: UILabel!
    @IBOutlet weak var LabelMail: UILabel!
    
    @IBOutlet weak var TextPhoneCode: UITextField!

    @IBOutlet weak var TextMailPass: UITextField!
    
    
//    @IBAction func PhoneNumEnter(_ sender: Any) {
//        LabelPhoneNum.text = "+" + TextPhoneNum.text!
//
//        PhoneAuthProvider.provider().verifyPhoneNumber(LabelPhoneNum.text!, uiDelegate: nil) { (verificationID, error) in
//            if let error = error {
//                print(error.localizedDescription)
//                self.showMessagePrompt(error.localizedDescription)
//                return
//            }
//            // Sign in using the verificationID and the code sent to the user
//            // ...
//        }
//    }
    
    @IBAction func MailReg(_ sender: Any) {
        Auth.auth().createUser(withEmail: TextMail.text!, password: TextMailPass.text!) { (user, error) in
            
                if let error = error {
                    print(error)
                    return
                }
                print("Аккаунт \(user!.email!) создан")
        }
        
    }
    
    @IBAction func MailAuth(_ sender: Any) {
        Auth.auth().signIn(withEmail: TextMail.text!, password: TextMailPass.text!) { (user, error) in
            
            if let error = error {
                print(error)
                return
            } else {
                print("Вход в аккаунт прошел успешно")

            }
            
        }
        
    }
    
    @IBAction func LogOut(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print("Выход из аккаунта прошел успешно")
        } catch let signOutError as NSError {
            print ("Ошибка логаута: %@", signOutError)
        }
        
    }
    
//    @IBAction func CheckPhoneCode(_ sender: Any) {
//
//        
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}


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
        showTextInputPrompt(withMessage: "Email:") { (userPressedOK, email) in
            if let email = email {
                self.showTextInputPrompt(withMessage: "Password:") { (userPressedOK, password) in
                    if let password = password {
                        self.showSpinner {
                            // [START create_user]
                            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                                // [START_EXCLUDE]
                                self.hideSpinner {
                                    if let error = error {
                                        self.showMessagePrompt(error.localizedDescription)
                                        return
                                    }
                                    print("\(user!.email!) created")
                                    self.navigationController!.popViewController(animated: true)
                                }
                                // [END_EXCLUDE]
                            }
                            // [END create_user]
                        }
                    } else {
                        self.showMessagePrompt("password can't be empty")
                    }
                }
            } else {
                self.showMessagePrompt("email can't be empty")
            }
        }
    }
    
    @IBAction func MailAuth(_ sender: Any) {
        if let email = self.TextMail.text, let password = self.TextMailPass.text {
            showSpinner {
                // [START headless_email_auth]
                Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                    // [START_EXCLUDE]
                    self.hideSpinner {
                        if let error = error {
                            self.showMessagePrompt(error.localizedDescription)
                            return
                        }
                        self.navigationController!.popViewController(animated: true)
                    }
                    // [END_EXCLUDE]
                }
                // [END headless_email_auth]
            }
        } else {
            self.showMessagePrompt("email/password can't be empty")
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


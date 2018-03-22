//
//  FirstViewController.swift
//  tempproj-mdavia
//
//  Created by Alexander Otpushchenko on 19.03.2018.
//  Copyright © 2018 Alex Otpushchenko. All rights reserved.
//

import UIKit
import Firebase

class MailViewController: UIViewController {
    
    @IBOutlet weak var TextMail: UITextField!
        
    @IBOutlet weak var TextMailPass: UITextField!

    @IBOutlet weak var LabelDebug: UILabel!
    
    @IBAction func MailReg(_ sender: Any) {
        let email = TextMail.text
        let pass = TextMailPass.text
        if TextMail.text == "" || TextMailPass.text == "" {
            
            //Обработка ошибки "пустые поля"
            let alertController = UIAlertController(title: "Ошибка", message: "Введите почту и пароль", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        } else {
            
            //Процесс создания нового пользователя
            Auth.auth().createUser(withEmail: email!, password: pass!) { (user, error) in
                
                if error == nil {
                    print("Регистрация пройдена")
                    
                    //Возврат на окно профиля при успешной регистрации
                    let prevViewController = self.storyboard?.instantiateViewController(withIdentifier: "Профиль")
                    self.present(prevViewController!, animated: true, completion: nil)
                    
                } else {
                    
                    //Вывод информации об ошибке
                    let alertController = UIAlertController(title: "Ошибка", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
            
        }
        
    }
    
    
    //Авторизация под существующим логином (почта)
    @IBAction func MailAuth(_ sender: Any) {
        Auth.auth().signIn(withEmail: TextMail.text!, password: TextMailPass.text!) { (user, error) in
            
            if error == nil {
                print("Вход в аккаунт прошел успешно")
                
                //Возврат на окно профиля при успешной авторизации
                let prevViewController = self.storyboard?.instantiateViewController(withIdentifier: "Профиль")
                self.present(prevViewController!, animated: true, completion: nil)
                
            } else {
                
                //Вывод информации об ошибке
                let alertController = UIAlertController(title: "Ошибка", message: error?.localizedDescription, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
                return
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


//
//  FirstViewController.swift
//  tempproj-mdavia
//
//  Created by Alexander Otpushchenko on 19.03.2018.
//  Copyright © 2018 Alex Otpushchenko. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class MailViewController: UIViewController {
    
    @IBOutlet weak var TextMail: UITextField!
    @IBOutlet weak var TextMailPass: UITextField!
    @IBOutlet weak var LabelDebug: UILabel!

    //Переменная для работы с БД (ниже добавим пользователя)
    var databaseRef: DatabaseReference!
    
    
    //Процесс регистрации при помощи почты и пароля
    @IBAction func MailReg(_ sender: Any) {
        let email = TextMail.text
        let pass = TextMailPass.text
        
        //Обработка ошибки "пустые поля"
        if email == "" || pass == "" {
            
            let alertController = UIAlertController(title: "Ошибка", message: "Введите почту и пароль", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        } else {
            

            //Процесс создания нового пользователя
            Auth.auth().createUser(withEmail: email!, password: pass!) { (user, error) in
                
                if error == nil {
                    print("Регистрация пройдена")
                    
                    user?.createProfileChangeRequest().displayName = user?.email
                    
                    
                    
                    //Добавляем учетку в базу данных "user_profiles"
                    self.databaseRef = Database.database().reference()
                    
                    self.databaseRef.child("user_profiles").child(user!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                        
                        let snapshot = snapshot.value as? NSDictionary
                        
                        if(snapshot == nil) {
                            self.databaseRef.child("user_profiles").child(user!.uid).child("name").setValue(user?.email)
                            self.databaseRef.child("user_profiles").child(user!.uid).child("email").setValue(user?.email)
                        }
                        
                        
                    })
                    
                    
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


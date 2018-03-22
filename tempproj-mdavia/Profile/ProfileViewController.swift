//
//  ProfileViewController.swift
//  tempproj-mdavia
//
//  Created by Alexander Otpushchenko on 21.03.2018.
//  Copyright © 2018 Alex Otpushchenko. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var LabelProfileName: UILabel!
    @IBOutlet weak var LabelUserId: UILabel!
    @IBOutlet weak var LabelForDebug: UILabel!

    
    @IBOutlet weak var ImageProfile: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Операции, выполняемые при загрузке формы.
        profileDataUpdate()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Выход из системы пользователя
    @IBAction func ProfileLogOut(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print("Выход из аккаунта прошел успешно")
            profileDataUpdate()
        } catch let signOutError as NSError {
            print ("Ошибка логаута: %@", signOutError)
        }
        
    }
    
    //Заполняем профильные данные пользователя
    func profileDataUpdate() {
        let firebaseUser = Auth.auth().currentUser
        
        //проверка на наличие активного пользователя в системе
        if firebaseUser != nil {
//            ImageProfile. = firebaseUser?.photoURL
            LabelUserId.text = firebaseUser?.uid
            LabelProfileName.text = firebaseUser?.displayName
        } else {
            ImageProfile.image = #imageLiteral(resourceName: "profile")
            LabelUserId.text = "Пользовательский ID"
            LabelProfileName.text = "Имя профиля"
            
        }
    }
    
    
}

//
//  WelcomeViewControllor.swift
//  Clima
//
//  Created by Samridh Agarwal on 23/05/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit
import Firebase
class WelcomeViewController:UIViewController{
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        if let email=emailTextField.text ,let password=passwordTextField.text{
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let error = error{
                    self.emailTextField.placeholder="Try again with relevant details"
                }
                else{
                    self.performSegue(withIdentifier: "LoginToApp", sender: self)
                }
            }
        }
        
    }
    
//    @IBAction func signupButtonPressed(_ sender: UIButton) {
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "LoginToApp "){
            let WeatherVC=segue.destination as! WeatherViewController
        }
    }
}

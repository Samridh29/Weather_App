

import UIKit
import Firebase

class SignUpViewController:UIViewController{
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.hidesWhenStopped=true
    }
    
    @IBAction func signupPressed(_ sender: UIButton) {
        if let email=emailTextField.text, let password=passwordTextField.text{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error=error{
                    self.emailTextField.placeholder="\(error.localizedDescription)"
                    
                }
                else{
                    self.performSegue(withIdentifier: "SignupApp", sender: self)
                    self.spinner.startAnimating()
                }
            }
        }
        else{
            if(emailTextField.text == ""){
                emailTextField.placeholder="This field can't be empty"
            }
            else{
                passwordTextField.placeholder="Enter a password to register"
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "SignupApp"){
            let WeatherVC = segue.destination as! WeatherViewController
            spinner.stopAnimating()
        }
    }
}

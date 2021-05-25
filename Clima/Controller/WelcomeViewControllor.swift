import UIKit
import Firebase
import GoogleSignIn

class WelcomeViewController:UIViewController{
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
        spinner.hidesWhenStopped=true
        navigationController?.isNavigationBarHidden=true
    }
    
    func googleBtnTapped(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let authentication = user.authentication {
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
            Auth.auth().signIn(with: credential) { user, error in
                if error != nil {
                    print("Problem at signing in with google with error : \(error.debugDescription)")
                }
                else if error == nil {
                    self.performSegue(withIdentifier: "LoginToApp", sender: self)
                }
            }
        }
    }
    
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        if let email=emailTextField.text ,let password=passwordTextField.text{
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let error = error{
                    self.emailTextField.placeholder="Try again with relevant details"
                }
                else{
                    self.performSegue(withIdentifier: "LoginToApp", sender: self)
                    self.spinner.startAnimating()
                }
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "LoginToApp"){
            let WeatherVC=segue.destination as! WeatherViewController
            spinner.stopAnimating()
        }
    }
}

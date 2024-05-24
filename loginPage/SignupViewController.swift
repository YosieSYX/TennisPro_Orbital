//
//  SignupViewController.swift
//  loginPage
//
//  Created by 杨清如 on 20/5/24.
//

import UIKit
import Firebase

class SignupViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func createButton(_ sender: Any) {
        guard let email=emailText.text else{return}
        guard let password=passwordText.text else{return}
        
        Auth.auth().createUser(withEmail: email, password: password) { firebaseResult, error in
            if let e=error{
                print(e)
            }
            else{
                self.performSegue(withIdentifier: "gotoNext", sender: self)
                
            }
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  ViewController.swift
//  devslopes-social
//
//  Created by Guilherme Gomes Cardoso on 5/18/17.
//  Copyright © 2017 Guilherme Cardoso. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FBSDKCoreKit
import FBSDKLoginKit
import FacebookLogin
import FacebookCore

class SignInVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var passwordTxtFld: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        passwordTxtFld.delegate = self
        emailTxtField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.emailTxtField.resignFirstResponder()
        self.passwordTxtFld.resignFirstResponder()
        return true
    }
    
    @IBAction func facebookSignInPressed(_ sender: UIButton) {
        print("pressed")
        let loginManager = LoginManager()
        loginManager.logIn([ .publicProfile ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print("Error from FACEBOOK Auth")
                print(error.localizedDescription)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in!")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: accessToken.authenticationToken)
                self.firebaseAuth(credential)
                
            }
        }
    }
    
    @IBAction func signInTapped(_ sender: UIButton) {
        if let email = emailTxtField.text, let pwd = passwordTxtFld.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
                
                if let error = error as? NSError {
                    if let errCode = FIRAuthErrorCode(rawValue: error.code) {
                        switch errCode {
                        case .errorCodeWeakPassword:
                            //handle weak password
                            print("MYRIUM: Email user unable to authenticate with Firebase using email, weak password")
                            break
                        case .errorCodeInvalidEmail: break
                        case .errorCodeUserNotFound:
                            FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
                                if error != nil {
                                    print("MYRIUM: Email user unable to authenticate with Firebase using email")
                                } else{
                                    print("MYRIUM: Email user authenticated with Firebase using email")
                                    
                                }
                            })
                            break;
                        default: break
//                            self.printError(error: error, stage: "User creation unsuccesfull")
                        }
                    }
                    print("MYRIUM: Email user unable to authenticate with Firebase")
                } else {
                    print("MYRIUM: Email user authenticated with irebase.")
                }
            })
        } else {
            
        }
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print(error.debugDescription)
                print("UNABLE TO AUTHENTICATE WITH FIREBASE")
            } else {
                print("AUTHENTICATEd WITH FIREBASE!")
            }
            
        })
    }
}


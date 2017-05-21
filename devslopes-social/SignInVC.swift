//
//  ViewController.swift
//  devslopes-social
//
//  Created by Guilherme Gomes Cardoso on 5/18/17.
//  Copyright © 2017 Guilherme Cardoso. All rights reserved.
//

import UIKit

class SignInVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var passwordTxtFld: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        passwordTxtFld.delegate = self
        emailTxtField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.emailTxtField.resignFirstResponder()
        self.passwordTxtFld.resignFirstResponder()
        return true
    }
}


//
//  FeedVC.swift
//  devslopes-social
//
//  Created by Guilherme Gomes Cardoso on 5/26/17.
//  Copyright © 2017 Guilherme Cardoso. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase
import FirebaseAuth

class FeedVC: UIViewController {

    
    @IBAction func signOutPressed(_ sender: Any) {
        let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("MYRIUM: ID removed from keychain \(keychainResult)")
        try! FIRAuth.auth()?.signOut()
        performSegue(withIdentifier: "goToSignIn", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

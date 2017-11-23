//
//  SecondViewController.swift
//  TranslateMaster
//
//  Created by Danil on 16.11.17.
//  Copyright © 2017 Danil. All rights reserved.
//

import UIKit
import GoogleSignIn
import GoogleAPIClientForREST



class SecondViewController: UIViewController {
    
    public var messageSubject = ""
    public var authData:GIDGoogleUser = GIDGoogleUser()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    

        
        GIDSignIn.sharedInstance()        

    }


    @IBAction func searchButton(_ sender: UIButton) {
        
        messageSubject = messageForSearchTexField.text!
        
 
        
        self.messageForSearchTexField .resignFirstResponder()
  




        self.view.backgroundColor = UIColor .green
    }
    


    
    
    @IBOutlet weak var messageForSearchTexField: UITextField!
    
    @IBOutlet weak var infoTextLabel: UILabel!
    
    
     override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.messageForSearchTexField .resignFirstResponder()
    }
    


}


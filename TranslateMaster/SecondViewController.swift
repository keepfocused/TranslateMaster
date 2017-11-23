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
    
    @IBOutlet weak var messageForSearchTexField: UITextField!
    
    @IBOutlet weak var infoTextLabel: UILabel!
    
    
    public var authData:GIDGoogleUser?
    private let service = GTLRGmailService()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        

        service.authorizer = authData?.authentication.fetcherAuthorizer()

    }


    @IBAction func searchButton(_ sender: UIButton) {
        

        self.messageForSearchTexField .resignFirstResponder()
        
        lookForMessagExistence()

        self.view.backgroundColor = UIColor .green
    }
    
    
    
    func lookForMessagExistence() 
    {
        let message = messageForSearchTexField.text!
        //if (message != nil)
        let query = GTLRGmailQuery_UsersMessagesList.query(withUserId: "me")
        query.q = message
        service.executeQuery(query, delegate: self, didFinish: #selector(printMessagesList(ticket:finishedWithObjetct:error:)))
    }
    
    
    
    
    func printMessagesList(ticket: GTLRServiceTicket, finishedWithObjetct listMessagesResponse : GTLRGmail_ListMessagesResponse, error : NSError?)
    {
        

        if (listMessagesResponse.messages != nil)
        { print(listMessagesResponse)}
        else {print("No response object")
        }
    }
    
    


    
    

    
    
     override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.messageForSearchTexField .resignFirstResponder()
    }
    


}


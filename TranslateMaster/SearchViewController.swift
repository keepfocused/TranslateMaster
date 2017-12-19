//
//  File.swift
//  
//
//  Created by Danil on 19.12.17.
//
//

import Foundation

import UIKit
import GoogleSignIn
import GoogleAPIClientForREST



class SearchViewController: UIViewController {
    
    @IBOutlet weak var messageForSearchTexField: UITextField!
    
    @IBOutlet weak var infoTextLabel: UILabel!
    
    @IBOutlet weak var responseLabel: UILabel!
    
    public var authData:GIDGoogleUser?
    private let service = GTLRGmailService()
    
    private var messageId:String?
    
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
        print("looking for ... \(message)")
        //if (message != nil)
        let query = GTLRGmailQuery_UsersMessagesList.query(withUserId: "me")
        query.q = message
        service.executeQuery(query, delegate: self, didFinish: #selector(printMessagesList(ticket:finishedWithObjetct:error:)))
        
        
    }
    
    
    func fetchMessageById(id :String)
    {
        let query = GTLRGmailQuery_UsersMessagesGet.query(withUserId: "me", identifier: id)
        service.executeQuery(query, delegate: self, didFinish: #selector(printFetchedMessage(ticket:finishedWithObjetct:error:)))
        
        
    }
    
    
    func printFetchedMessage (ticket: GTLRServiceTicket, finishedWithObjetct responseMessage : GTLRGmail_ListMessagesResponse, error : NSError?)
    {
        print ("fetched message is \(responseMessage)")
        let tempDict:Dictionary = responseMessage
        responseLabel = responseMessage.
    }
    
    
    
    
    
    
    
    func printMessagesList(ticket: GTLRServiceTicket, finishedWithObjetct listMessagesResponse : GTLRGmail_ListMessagesResponse, error : NSError?)
    {
        
        
        if (listMessagesResponse.messages != nil)
        {
            print("RESPONSE START HERE")
            print(listMessagesResponse)
            //let tempSingleResponseObject = listMessagesResponse.messages?.first
            //messageId = listMessagesResponse.messages?.count
            //let arrayCount = listMessagesResponse.messages?.first
            //print("array of response messages  =  \(arrayCount)")
            let messagesArray = listMessagesResponse.messages
            for message:GTLRGmail_Message in messagesArray!
            {
                print(message.identifier)
            }
            
            
            self.responseLabel.text = listMessagesResponse.messages?.first?.identifier
            messageId = listMessagesResponse.messages?.first?.identifier
            
            fetchMessageById(id: messageId!)
            
        }
        else {print("No response object")
        }
    }
    
    
    
    
    

    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.messageForSearchTexField .resignFirstResponder()
    }
    
    
    
}


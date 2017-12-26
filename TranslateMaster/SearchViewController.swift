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

extension String {
    //: ### Base64 encoding a string
    func base64Encoded() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }
    
    //need to convert response to json & after decode it as base64
    
    //new String
    //new new string 
    
    //: ### Base64 decoding a string
    func base64Decoded() -> String? {
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}



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
        
        print("AUTH DATA = \(authData?.userID)")
        
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
        //query.format = "raw"
        service.executeQuery(query, delegate: self, didFinish: #selector(printFetchedMessage(ticket: finishedWithObjetct:error:)))
        
        print("message fetched succeseful")
        
        
        
        
    }
    
    
    func printFetchedMessage (ticket: GTLRServiceTicket, finishedWithObjetct responseMessage :GTLRGmail_Message , error : NSError?)
    {
        
        print ("fetched message is \(responseMessage)")
        
        let base64 = responseMessage.payload?.body?.data
        
        let data = base64?.data(using: .utf8)
        
        let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any]
        
        
        print ("print json = \(json)")
        
        //print (decodedResponseStringBase64)
        
//        if let decodedData = NSData(base64Encoded: decodedResponseStringBase64!, options: NSData.Base64DecodingOptions(rawValue: 0)),
//            let decodedString = NSString(data: decodedData as Data, encoding: String.dec.utf8.rawValue) {
//            print(decodedString) // foo
//        }

        
        

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
                print("message identifier")
                print(message.identifier)
                print("testing payload")
                print(message.payload)
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


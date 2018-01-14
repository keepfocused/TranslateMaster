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
    
    
    public var authData:GIDGoogleUser?
    private let service = GTLRGmailService()
    
    private var messageId:String?
    
    var importText:String = ""
    
    //MARK: - lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.analyzeButtonOutlet.isHidden = true
        self.contentTextView.isEditable = false
        self.contentTextView.isScrollEnabled = true
        self.contentTextView.showsVerticalScrollIndicator = true

        
        
        service.authorizer = authData?.authentication.fetcherAuthorizer()
        
        print("AUTH DATA = \(authData?.userID)")
        
    }
    
    
    @IBAction func searchButton(_ sender: UIButton) {
        
        
        self.messageForSearchTexField .resignFirstResponder()
        
        var string = messageForSearchTexField.text
        
        string = string?.replacingOccurrences(of: " ", with: "")
        
       
        
        if ((string?.characters.count)! >= 5)
        {
            lookForMessagExistence()
        }
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
        service.executeQuery(query, delegate: self, didFinish: #selector(manageFetchedMessage(ticket: finishedWithObjetct:error:)))
        
        print("message fetched succeseful")
        
        
    }
    
    
    func manageFetchedMessage (ticket: GTLRServiceTicket, finishedWithObjetct responseMessage :GTLRGmail_Message , error : NSError?)
    {
        
        print ("fetched message is \(responseMessage)")
        
        let rawData = responseMessage.payload?.body?.data
        
        let tempString = rawData?.replacingOccurrences(of: "_", with: "/")
        
        let base64Encoded = tempString?.replacingOccurrences(of: "-", with: "+")
        //Сделать проверку на возможность выполнения
        if (base64Encoded != nil)
        {
            let decodedText = decodeBase64(base64Encoded: base64Encoded!)
            
            self.contentTextView.text = decodedText
            
            self.analyzeButtonOutlet.isHidden = false
            
            importText = decodedText
        }
        

        
    }
    
    
    func decodeBase64(base64Encoded:String) -> String {
        
        let decodedData = Data(base64Encoded: base64Encoded)!
        let decodedString = String(data: decodedData, encoding: .utf8)!
        
        print(decodedString)
        
        return decodedString
        
    }
    
    
    
    func printMessagesList(ticket: GTLRServiceTicket, finishedWithObjetct listMessagesResponse : GTLRGmail_ListMessagesResponse, error : NSError?)
    {
        
        
        if (listMessagesResponse.messages != nil)
        {
                        
            //self.responseLabel.text = listMessagesResponse.messages?.first?.identifier
            messageId = listMessagesResponse.messages?.first?.identifier
            
            fetchMessageById(id: messageId!)
            
            changeBackgroundColor()
            
            self.contentTextView.text = "Success! Message found"
            
        }
        else {
            self.contentTextView.text = "Message with currently id not found"        }
    }
    
    func changeBackgroundColor()  {
        
        
        self.view.backgroundColor = UIColor .green
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            
            self.view.backgroundColor = UIColor .white
        })
    }
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.messageForSearchTexField .resignFirstResponder()
    }

    
    
    @IBOutlet weak var contentTextView: UITextView!
    

    @IBOutlet weak var analyzeButtonOutlet: UIButton!
    
    @IBAction func analyzeButtonAction(_ sender: UIButton) {
        print("Analyze button pressed")
        
        let textAnalyz = TextAnalyzer()
        
        
        
        textAnalyz.textForImport = importText
        
        textAnalyz.performTextAnalyze()
        
        
        if (textAnalyz != nil)
        {
            print (textAnalyz.analyzedWords)
        }
        
        var tempArray = textAnalyz.analyzedWords
        

        
        //print(" Analyzed text = \(textAnalyz.analyzedWords)")
        
    }


    
}


//
//  FirstViewController.swift
//  TranslateMaster
//
//  Created by Danil on 16.11.17.
//  Copyright © 2017 Danil. All rights reserved.
//

import GoogleAPIClientForREST
import GoogleSignIn
import UIKit


class GoogleAuthViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    
    
    // If modifying these scopes, delete your previously saved credentials by
    // resetting the iOS simulator or uninstall the app.
    private let scopes = [kGTLRAuthScopeGmailReadonly]
    
    private let service = GTLRGmailService()
    let signInButton = GIDSignInButton()
    let output = UITextView()
    var authResponseObject:GIDGoogleUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure Google Sign-in.
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().scopes = scopes
        GIDSignIn.sharedInstance().signInSilently()
        
        // Add the sign-in button.
        view.addSubview(signInButton)
        
        // Add a UITextView to display output.
        output.frame = view.bounds
        output.isEditable = false
        output.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        output.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        output.isHidden = true
        view.addSubview(output);
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            showAlert(title: "Authentication Error", message: error.localizedDescription)
            self.service.authorizer = nil
        } else {
            self.signInButton.isHidden = true
            self.output.isHidden = false
            self.service.authorizer = user.authentication.fetcherAuthorizer()
            self.authResponseObject = user
            
            let segueIdentifier = "searchMessageId"
            performSegue(withIdentifier: segueIdentifier, sender: nil)
            
 
        }
    }
    
    // Construct a query and get a list of upcoming labels from the gmail API
    func fetchLabels() {
        output.text = "Getting labels..."
        
        let query = GTLRGmailQuery_UsersLabelsList.query(withUserId: "me")
        service.executeQuery(query,
                             delegate: self,
                             didFinish: #selector(displayResultWithTicket(ticket:finishedWithObject:error:))
        )
    }
    
    // Display the labels in the UITextView
    func displayResultWithTicket(ticket : GTLRServiceTicket,
                                 finishedWithObject labelsResponse : GTLRGmail_ListLabelsResponse,
                                 error : NSError?) {
        if let error = error {
            showAlert(title: "Error", message: error.localizedDescription)
            return
        }
        var labelString = ""
        if let labels = labelsResponse.labels, labels.count > 0 {
            labelString += "Labels:\n"
            for label in labels {
                labelString += "\(label.name!)\n"
            }
        } else {
            labelString = "No labels found."
        }
        output.text = labelString
    }
    
    func fetchMessagesList()
    {
        let query = GTLRGmailQuery_UsersMessagesList.query(withUserId: "me")
        query.q = "testMessage"
        service.executeQuery(query, delegate: self, didFinish: #selector(printMessagesList(ticket:finishedWithObjetct:error:)))
        
    }
    
//    func fetchMessageById(id :String) -> String
//    {
//        let query = GTLRGmailQuery_UsersMessagesGet.query(withUserId: "me", identifier: id)
//        service.executeQuery(query, delegate: self, didFinish: #selector(printFetchedMessage))
//
//    }
    
//    func printFetchedMessage ticket: GTLRServiceTicket, finishedWithObjetct listMessagesResponse : GTLRGmail_ListMessagesResponse, error : NSError?)
//    {
//        print "fetched message is (message)"
//    }
    
    func printMessagesList(ticket: GTLRServiceTicket, finishedWithObjetct listMessagesResponse : GTLRGmail_ListMessagesResponse, error : NSError?)
    {
     
        print("printMessageMethod was called")
        if (listMessagesResponse.messages != nil)
        { print(listMessagesResponse)}
        else {print("No response object")
    }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "searchMessageId"
        {
            let authData = self.authResponseObject!
            
            if let destinationViewController = segue.destination as? SearchViewController {
                destinationViewController.authData = authData
            }
            
        
        }
    }
    
    
    // Helper for showing an alert
    func showAlert(title : String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertControllerStyle.alert
        )
        let ok = UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.default,
            handler: nil
        )
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}

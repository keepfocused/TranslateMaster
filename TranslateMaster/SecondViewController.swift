//
//  SecondViewController.swift
//  TranslateMaster
//
//  Created by Danil on 16.11.17.
//  Copyright © 2017 Danil. All rights reserved.
//

import UIKit


class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mailSearchService = GoogleAuthViewController()
        
        mailSearchService .fetchMessagesList()
        
        
        

    }


    @IBAction func searchButton(_ sender: UIButton) {
        
        self.view.backgroundColor = UIColor .red
        self.view.backgroundColor = UIColor .green
    }
    
    
    @IBOutlet weak var messageForSearchTexField: UITextField!
    
    @IBOutlet weak var infoTextLabel: UILabel!
    


}


//
//  AddNewWordViewController.swift
//  TranslateMaster
//
//  Created by Danil on 16.01.18.
//  Copyright © 2018 Danil. All rights reserved.
//

import UIKit

class AddNewCardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var addNewCardViewOutlet: UIView!

    @IBOutlet weak var saveButtonOutlet: UIButton!
    
    
    
    @IBOutlet weak var cancleButtonOutlet: UIButton!
    
    @IBOutlet weak var russianInput: UITextField!
    
    @IBOutlet weak var englishInput: UITextField!
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        
        UIView.animate(withDuration: 0.7, delay: 1.0, options: .curveEaseOut, animations: {
            // var basketTopFrame = self.basketTop.frame
            //    basketTopFrame.origin.y -= basketTopFrame.size.height
            
            var addNewCardFrame = self.addNewCardViewOutlet.frame
            addNewCardFrame.size.height += addNewCardFrame.size.height * 1.5
            self.addNewCardViewOutlet.frame = addNewCardFrame
            
            
            //
            //    var basketBottomFrame = self.basketBottom.frame
            //    basketBottomFrame.origin.y += basketBottomFrame.size.height
            //
            //    self.basketTop.frame = basketTopFrame
            //    self.basketBottom.frame = basketBottomFrame
        }, completion: { finished in
            print("Basket doors opened!")
        })
    }
    



    
 
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

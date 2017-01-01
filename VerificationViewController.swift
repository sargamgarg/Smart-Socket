//
//  VerificationViewController.swift
//  SmartSocket
//
//  Created by sargam garg on 05/05/16.
//  Copyright © 2016 self.edu.sargam. All rights reserved.
//

import Foundation
import UIKit
import LocalAuthentication
class VerificationViewController : UIViewController {
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBOutlet weak var goToAPp: UIButton!
  
  @IBOutlet weak var label: UILabel!
  
  func authenticateUser()
  {
    let context = LAContext()
    var error: NSError?
    let reasonString = "Authentication is needed to access your app!"
    
    if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error)
    {
      context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: { (success, policyError) -> Void in
        
        if success
        {
        
          print("Authentication successful!")
          DispatchQueue.main.async {
          self.label.text = "Authentication Successful"
          self.goToAPp.isEnabled = true
          }
        }
        else
        {
          switch policyError!.code
          {
          case LAError.Code.systemCancel.rawValue:
            print("Authentication was cancelled by the system.")
            DispatchQueue.main.async {
            self.label.text = "Authentication Cancelled"
            }
          case LAError.Code.userCancel.rawValue:
            print("Authentication was cancelled by the user.")
            DispatchQueue.main.async {
            self.label.text = "Authentication Cancelled"
            }
            
          case LAError.Code.userFallback.rawValue:
            print("User selected to enter password.")
            OperationQueue.main.addOperation({ () -> Void in
              self.showPasswordAlert()
            })
          default:
            print("Authentication failed! :(")
            OperationQueue.main.addOperation({ () -> Void in
              self.showPasswordAlert()
            })
          }
        }
        
      })
    }
    else
    {
      print(error?.localizedDescription)
      OperationQueue.main.addOperation({ () -> Void in
        //self.showPasswordAlert()
      })
    }
  }
  
  
  // MARK: Password Alert
  
  func showPasswordAlert()
  {
    let alertController = UIAlertController(title: "Touch ID Password", message: "Please enter your password.", preferredStyle: .alert)
    
    let defaultAction = UIAlertAction(title: "OK", style: .cancel) { (action) -> Void in
      
      if let textField = alertController.textFields?.first as UITextField?
      {
        if textField.text == "1234"
        {
          print("Authentication successful!")
          DispatchQueue.main.async {
          self.goToAPp.isEnabled = true
          self.label.text = "Authentication Successful"
          }
        }
        else
        {
          self.showPasswordAlert()
        }
      }
    }
    alertController.addAction(defaultAction)
    
    alertController.addTextField { (textField) -> Void in
      
      textField.placeholder = "Password"
      textField.isSecureTextEntry = true
      
    }
    self.present(alertController, animated: true, completion: nil)
  }
  

  
  
  @IBAction func verifyUserButtonPressed(_ sender: UIButton) {
     authenticateUser()
  }
  
}


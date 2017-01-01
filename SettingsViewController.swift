//
//  SettingsViewController.swift
//  SmartSocket
//
//  Created by sargam garg on 05/05/16.
//  Copyright © 2016 self.edu.sargam. All rights reserved.
//

import Foundation
import UIKit
class SettingsViewController: UIViewController {
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
 
    @IBAction func activateButtonPressed(_ sender: UIButton) {
    let notificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
    UIApplication.shared.registerUserNotificationSettings(notificationSettings)
  }
  
  
}

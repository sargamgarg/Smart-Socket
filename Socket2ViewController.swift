//
//  Socket2ViewController.swift
//  SmartSocket
//
//  Created by sargam garg on 30/04/16.
//  Copyright © 2016 self.edu.sargam. All rights reserved.
//

import Foundation
import UIKit
class Socket2ViewController: UIViewController, UITextFieldDelegate{
  
  let MESSAGE1 = "Incorrect value for Hour"
  let MESSAGE2 = "Incorrect value for Minutes"
  let MESSAGE3 = "Please enter a value for Hour and Minutes"
  @IBOutlet weak var socket2Image: UIImageView!
  @IBOutlet weak var socket2Button: UIButton!
  @IBOutlet weak var s2OnHour: UITextField!
  @IBOutlet weak var s2OnMin: UITextField!
  @IBOutlet weak var s2OffHour: UITextField!
  @IBOutlet weak var s2OffMin: UITextField!
  var socketArray: [AnyObject] = [0 as AnyObject,0 as AnyObject]
  var statusArray: [AnyObject] = [0 as AnyObject,0 as AnyObject]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    socket2Image.image = UIImage(named: "grey-button")
    socket2Button.isEnabled = false
    s2OnHour.delegate = self
    s2OffHour.delegate = self
    s2OnMin.delegate = self
    s2OffMin.delegate = self
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
    view.addGestureRecognizer(tap)
    
    let url = URL(string: "http://www.edu.cselian.com/mc.php")
    let request = NSMutableURLRequest(url: url!)
     let task = URLSession.shared.dataTask(with: request, completionHandler: {
      data, response, error in
      if data == nil {
        print("request failed \(error)")
        return
      }
      var parseError: NSError?
      do {
        if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
          print(jsonResult)
          let value2 : AnyObject = jsonResult["socket"]![1]
          let value4 : AnyObject = jsonResult["status"]![1]
         // print(value1.dynamicType)
          self.socketArray[1] = value2
          self.statusArray[1] = value4
          // print(self.socketArray[0].dynamicType)
          if(self.statusArray[1] as! String == "0"){
            DispatchQueue.main.async {
            self.socket2Image.image = UIImage(named: "off-button")
            self.socket2Image.isHidden = false
            self.socket2Button.isEnabled = true
            }
            
          }
          else if(self.statusArray[1] as! String == "1"){
            DispatchQueue.main.async {
            self.socket2Image.image = UIImage(named: "on-button")
            self.socket2Image.isHidden = false
            self.socket2Button.isEnabled = true
            }
          }
          print(self.socketArray[1])
          print(self.statusArray[1])
        }
      }
        catch let error as NSError {
          print(error.localizedDescription)
        }
      }) 
      task.resume()
    }
    
    override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
    }
  override func viewWillAppear(_ animated: Bool) {
    
    super.viewWillAppear(animated);
    let url = URL(string: "http://www.edu.cselian.com/mc.php"
    )
    let request = NSMutableURLRequest(url: url!)
    let task = URLSession.shared.dataTask(with: request, completionHandler: {
      data, response, error in
      if data == nil {
        print("request failed \(error)")
        return
      }
      var parseError: NSError?
      do {
        if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
          print(jsonResult)
          let value2 : AnyObject = jsonResult["socket"]![1]
          let value4 : AnyObject = jsonResult["status"]![1]
          // print(value1.dynamicType)
          self.socketArray[1] = value2
          self.statusArray[1] = value4
          // print(self.socketArray[0].dynamicType)
          if(self.statusArray[1] as! String == "0"){
            DispatchQueue.main.async {
              self.socket2Image.image = UIImage(named: "off-button")
              self.socket2Image.isHidden = false
              self.socket2Button.isEnabled = true
            }
            
          }
          else if(self.statusArray[1] as! String == "1"){
            DispatchQueue.main.async {
              self.socket2Image.image = UIImage(named: "on-button")
              self.socket2Image.isHidden = false
              self.socket2Button.isEnabled = true
            }
          }
          print(self.socketArray[1])
          print(self.statusArray[1])
        }
      }
      catch let error as NSError {
        print(error.localizedDescription)
      }
    }) 
    task.resume()
  }
     // post function
    
    func post(_ var1: Int,var2: Int) {
      let url: URL = URL(string: "http://www.edu.cselian.com/update.php"
        )!
      let request:NSMutableURLRequest = NSMutableURLRequest(url:url)
      request.httpMethod = "POST";
      let postString = "socket=\(var1)&status=\(var2)"
      request.httpBody = postString.data(using: String.Encoding.utf8);
      NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main) {
        (response, data, error) in
        print(response)
      }
    }
    
    
    func dismissKeyboard() {
      //Causes the view (or one of its embedded text fields) to resign the first responder status.
      view.endEditing(true)
    }
    
    
    // main socket function
    
    @IBAction func socket2ButtonPressed(_ sender: UIButton) {
      if((statusArray[1] as! NSObject) as! String == "1"){
        socket2Image.image = UIImage(named: "off-button")
        post(2,var2: 0)
        statusArray[1] = "0" as AnyObject
      }
      else if((statusArray[1] as! NSObject) as! String == "0") {
        socket2Image.image = UIImage(named: "on-button")
        post(2,var2: 1)
        statusArray[1] = "1" as AnyObject
      }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      if s2OnHour.isFirstResponder{
        let length = (textField.text?.characters.count)! + string.characters.count
        if (length > 2) {
          return false
        }
        else{
          return true
        }
      }
      if s2OnMin.isFirstResponder{
        let length = (textField.text?.characters.count)! + string.characters.count
        if (length > 2) {
          return false
        }
        else{
          return true
        }
      }
      if s2OffHour.isFirstResponder{
        let length = (textField.text?.characters.count)! + string.characters.count
        if (length > 2) {
          return false
        }
        else{
          return true
        }
      }
      
      if s2OffMin.isFirstResponder{
        let length = (textField.text?.characters.count)! + string.characters.count
        if (length > 2) {
          return false
        }
        else{
          return true
        }
      }
      return true
    }
    func post1(_ var1: Int,var2: String,var3: Int,var4: Int) {
      let url: URL = URL(string: "http://www.edu.cselian.com/updatesocketauto.php")!
      let request:NSMutableURLRequest = NSMutableURLRequest(url:url)
      request.httpMethod = "POST";
      let postString = "socket=\(var1)&time=\(var2)&status=\(var3)&valid=\(var4)"
      request.httpBody = postString.data(using: String.Encoding.utf8);
      NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main) {
        (response, data, error) in
        print(response)
      }
    }
    
    func alertDisplay(_ alertMessage: String) -> Bool{
      let alertController: UIAlertController = UIAlertController(title: "Oops!", message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
      let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
      alertController.addAction(okAction)
      present(alertController, animated: true, completion: nil)
      return false
    }
    
    // MARK: - Submit Button methods
    
    @IBAction func onSubmitButtonPressed(_ sender: UIButton) {
      var onHour : Int
      var onMin : Int
      var onTime : String
      if((s2OnHour.text!.isEmpty) || (s2OnMin.text!.isEmpty)) {
        alertDisplay(MESSAGE3)
      }
      else {
        onHour = Int(s2OnHour.text!)!
        onMin =  Int(s2OnMin.text!)!
        let onHourStringVal = s2OnHour.text!
        let onMinStringVal = s2OnMin.text!
        onTime = "\(onHourStringVal):\(onMinStringVal)"
        
        if (onHour < 0 || onHour > 23){
          alertDisplay(MESSAGE1)
        }
        else if(onMin < 0 || onMin > 59){
          alertDisplay(MESSAGE2)
        }
        else{
          post1(2, var2: onTime, var3: 1, var4: 1)
          s2OnHour.text = ""
          s2OnMin.text = ""
          let notification = UILocalNotification()
          notification.fireDate = Date(timeIntervalSinceNow : 5)
          notification.alertBody = "Timer to switch on socket 2 has been set for \(onTime)"
          notification.alertAction = "view"
          notification.soundName = UILocalNotificationDefaultSoundName
          notification.userInfo = ["CustomField1": "w00t"]
          UIApplication.shared.scheduleLocalNotification(notification)
        }
        
      }
    }
    
    @IBAction func offSubmitButtonPressed(_ sender: UIButton) {
      var offHour : Int
      var offMin : Int
      var offTime : String
      if((s2OffHour.text!.isEmpty) || (s2OffMin.text!.isEmpty)) {
        alertDisplay(MESSAGE3)
      }
      else {
        offHour = Int(s2OffHour.text!)!
        offMin =  Int(s2OffMin.text!)!
        let offHourStringVal = s2OffHour.text!
        let offMinStringVal = s2OffMin.text!
        offTime = "\(offHourStringVal):\(offMinStringVal)"
        
        if (offHour < 0 || offHour > 23){
          alertDisplay(MESSAGE1)
        }
        else if(offMin < 0 || offMin > 59){
          alertDisplay(MESSAGE2)
        }
        else{
          post1(2, var2: offTime, var3: 0, var4: 1)
          s2OffHour.text = ""
          s2OffMin.text = ""
          let notification = UILocalNotification()
          notification.fireDate = Date(timeIntervalSinceNow : 5)
          notification.alertBody = "Timer to switch off socket 2 has been set for \(offTime)"
          notification.alertAction = "view"
          notification.soundName = UILocalNotificationDefaultSoundName
          notification.userInfo = ["CustomField1": "w00t"]
          UIApplication.shared.scheduleLocalNotification(notification)
        }
        
      }
      
}
}





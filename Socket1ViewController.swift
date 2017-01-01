//
//  Socket1ViewController.swift
//  SmartSocket
//
//  Created by sargam garg on 29/04/16.
//  Copyright © 2016 self.edu.sargam. All rights reserved.
//


import UIKit
import Foundation
class Socket1ViewController: UIViewController, UITextFieldDelegate {
  var socketArray: [AnyObject] = [0 as AnyObject,0 as AnyObject]
  var statusArray: [AnyObject] = [0 as AnyObject,0 as AnyObject]
  
  @IBOutlet weak var socket1Button: UIButton!
  
  @IBOutlet weak var socket1Image: UIImageView!
  
  @IBOutlet weak var s1OnHour: UITextField!
  
  @IBOutlet weak var s1OnMIn: UITextField!
  
  @IBOutlet weak var s1OffHour: UITextField!
  
  @IBOutlet weak var s1OffMin: UITextField!

  
  let MESSAGE1 = "Incorrect value for Hour"
  let MESSAGE2 = "Incorrect value for Minutes"
  let MESSAGE3 = "Please enter a value for Hour and Minutes"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    s1OnHour.delegate = self
    s1OffHour.delegate = self
    s1OnMIn.delegate = self
    s1OffMin.delegate = self
    socket1Image.image = UIImage(named: "grey-button")
    socket1Button.isEnabled = false
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(Socket1ViewController.dismissKeyboard))
    view.addGestureRecognizer(tap)
    
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
          let value1 : AnyObject = jsonResult["socket"]![0]
          let value3 : AnyObject = jsonResult["status"]![0]
          print(type(of: value1))
          self.socketArray[0] = value1
          self.statusArray[0] = value3
         // print(self.socketArray[0].dynamicType)
          if(self.statusArray[0] as! String == "0"){
            DispatchQueue.main.async {
              self.socket1Image.image = UIImage(named: "off-button")
              self.socket1Image.isHidden = false
              self.socket1Button.isEnabled = true
            }
            
          }
          else if(self.statusArray[0] as! String == "1"){
            DispatchQueue.main.async {
              self.socket1Image.image = UIImage(named: "on-button")
              self.socket1Image.isHidden = false
              self.socket1Button.isEnabled = true
            }
          }
          print(self.socketArray[0])
          print(self.statusArray[0])
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
          let value1 : AnyObject = jsonResult["socket"]![0]
          let value3 : AnyObject = jsonResult["status"]![0]
          //print(value1.dynamicType)
          self.socketArray[0] = value1
          self.statusArray[0] = value3
          // print(self.socketArray[0].dynamicType)
          if(self.statusArray[0] as! String == "0"){
            DispatchQueue.main.async {
              self.socket1Image.image = UIImage(named: "off-button")
              self.socket1Image.isHidden = false
              self.socket1Button.isEnabled = true
            }
            
          }
          else if(self.statusArray[0] as! String == "1"){
            DispatchQueue.main.async {
              self.socket1Image.image = UIImage(named: "on-button")
              self.socket1Image.isHidden = false
              self.socket1Button.isEnabled = true
            }
          }
          print(self.socketArray[0])
          print(self.statusArray[0])
        }
      }
      catch let error as NSError {
        print(error.localizedDescription)
      }
    }) 
    task.resume()

  }
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
  
  // Function to dismiss keyboard
  
  func dismissKeyboard() {
    //Causes the view (or one of its embedded text fields) to resign the first responder status.
    view.endEditing(true)
  }
  
  
  @IBAction func socket1ButtonPressed(_ sender: UIButton) {
    if((statusArray[0] as! NSObject) as! String == "1"){
      socket1Image.image = UIImage(named: "off-button")
      post(1,var2: 0)
      statusArray[0] = "0" as AnyObject
    }
    else if((statusArray[0] as! NSObject) as! String == "0") {
      socket1Image.image = UIImage(named: "on-button")
      post(1,var2: 1)
      statusArray[0] = "1" as AnyObject
    }
  }
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    if s1OnHour.isFirstResponder{
      let length = (textField.text?.characters.count)! + string.characters.count
      if (length > 2) {
        return false
      }
      else{
        return true
      }
    }
    if s1OnMIn.isFirstResponder{
      let length = (textField.text?.characters.count)! + string.characters.count
      if (length > 2) {
        return false
      }
      else{
        return true
      }
    }
    if s1OffHour.isFirstResponder{
      let length = (textField.text?.characters.count)! + string.characters.count
      if (length > 2) {
        return false
      }
      else{
        return true
      }
    }
    
    if s1OffMin.isFirstResponder{
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
    if((s1OnHour.text!.isEmpty) || (s1OnMIn.text!.isEmpty)) {
      alertDisplay(MESSAGE3)
    }
    else {
      onHour = Int(s1OnHour.text!)!
      onMin =  Int(s1OnMIn.text!)!
      let onHourStringVAl = s1OnHour.text!
      let onMinStringVal = s1OnMIn.text!
       onTime = "\(onHourStringVAl):\(onMinStringVal)"
      
      if (onHour < 0 || onHour > 23){
        alertDisplay(MESSAGE1)
      }
      else if(onMin < 0 || onMin > 59){
        alertDisplay(MESSAGE2)
      }
      else{
        post1(1, var2: onTime, var3: 1, var4: 1)
        s1OnHour.text = ""
        s1OnMIn.text = ""
        let notification = UILocalNotification()
        notification.fireDate = Date(timeIntervalSinceNow : 5)
        notification.alertBody = "Timer to switch on socket 1 has been set for \(onTime)"
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
    if((s1OffHour.text!.isEmpty) || (s1OffMin.text!.isEmpty)) {
      alertDisplay(MESSAGE3)
    }
    else {
      offHour = Int(s1OffHour.text!)!
      offMin =  Int(s1OffMin.text!)!
      let offHourStringVal = s1OffHour.text!
      let offMinStringVal = s1OffMin.text!
      offTime = "\(offHourStringVal):\(offMinStringVal)"
      
      if (offHour < 0 || offHour > 23){
        alertDisplay(MESSAGE1)
      }
      else if(offMin < 0 || offMin > 59){
        alertDisplay(MESSAGE2)
      }
      else{
        post1(1, var2: offTime, var3: 0, var4: 1)
        s1OffHour.text = ""
        s1OffMin.text = ""
        let notification = UILocalNotification()
        notification.fireDate = Date(timeIntervalSinceNow : 5)
        notification.alertBody = "Timer to switch off socket 1 has been set for \(offTime)"
        notification.alertAction = "view"
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = ["CustomField1": "w00t"]
        UIApplication.shared.scheduleLocalNotification(notification)
      }
      
    }
    
  }
}

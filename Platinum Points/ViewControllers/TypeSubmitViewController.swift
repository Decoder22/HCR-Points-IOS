//
//  TypeSubmitView.swift
//  Platinum Points
//
//  Created by Brian Johncox on 6/30/18.
//  Copyright © 2018 DecodeProgramming. All rights reserved.
//

import UIKit
import ValueStepper

class TypeSubmitViewController: UIViewController, UITextViewDelegate {

    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var countStepper: ValueStepper!
    @IBOutlet var descriptionField: UITextView!
    
    var type:PointType?
    var user:User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        typeLabel.text? = type!.pointDescription
        descriptionField.layer.borderColor = UIColor.black.cgColor
        descriptionField.layer.borderWidth = 1
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submit(_ sender: Any) {
        guard let description = descriptionField.text, !description.isEmpty else{
            print("Description is empty")
            return
        }
        let count = countStepper.value
        if ( count <= 0){
            print("Count is illegal number")
            return
        }
        guard let pointType = type else{
            print("PointType not found")
            return
        }
        for _ in 0 ..< Int(count) {
            let pointLog = PointLog(pointDescription: description, resident: User.get(.name) as! String, type: pointType, floorID: User.get(.floorID) as! String)
            DataManager.sharedManager.writePoints(log: pointLog) { (err:Error?) in
                if(err != nil){
                    self.notify(title: "Failed to submit", subtitle: err.debugDescription, style: .danger)
                    print("Error in posting: ",err.debugDescription)
                }
                else{
                    //post success
                    print("Success")
                    self.navigationController?.popViewController(animated: true)
                    
                    self.navigationController?.topViewController?.notify(title: "Success", subtitle: "Your points were recorded!", style: .success)
                }
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if(textView.text == "Tell us about what you did!"){
            textView.text = ""
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if(textView.text == ""){
            textView.text = "Tell us about what you did!"
        }
    }


    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        self.descriptionField.resignFirstResponder()
    }
/*    // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */
}

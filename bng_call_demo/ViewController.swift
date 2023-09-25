//
//  ViewController.swift
//  bng_call_demo
//
//  Created by nausheen on 25/09/23.
//

import UIKit
import CallKit


class ViewController: UIViewController {
    @IBOutlet weak var dial1: UIButton!
    
    @IBOutlet weak var dial2: UIButton!
    @IBOutlet weak var dial3: UIButton!

    @IBOutlet weak var dial0: UIButton!
    @IBOutlet weak var dial9: UIButton!
    @IBOutlet weak var dial8: UIButton!
    @IBOutlet weak var dial7: UIButton!
    @IBOutlet weak var dial6: UIButton!
    @IBOutlet weak var dial5: UIButton!
    @IBOutlet weak var dial4: UIButton!
    @IBOutlet weak var calButton: UIButton!
    @IBOutlet weak var clearText: UIButton!
    @IBOutlet weak var phoneNumberView: UITextView!
    
    var phoneNumber : String = ""
    
    
    var provider = CXProvider(configuration: CXProviderConfiguration(localizedName: "Demo Call Kit"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneNumberView.textContainerInset = UIEdgeInsets(top: 120, left: 50, bottom: 50, right: 20)
        phoneNumberView.textContainer.maximumNumberOfLines = 1

        
        dial0.createRoundButton()
        dial1.createRoundButton()
        dial2.createRoundButton()
        dial3.createRoundButton()
        dial4.createRoundButton()
        dial5.createRoundButton()
        dial6.createRoundButton()
        dial7.createRoundButton()
        dial8.createRoundButton()
        dial9.createRoundButton()
        
        calButton.setImage(UIImage(named: "callButton"), for: .normal)
        calButton.setTitle("", for: .normal)
        calButton.layer.cornerRadius = 25
        
        clearText.setImage(UIImage(named: "backspace"), for: .normal)
        clearText.setTitle("", for: .normal)
        clearText.layer.cornerRadius = 25
        
        provider.setDelegate(self, queue: nil)
        let update = CXCallUpdate()
        update.remoteHandle = CXHandle(type: .generic, value: "Nausheen")
        provider.reportNewIncomingCall(with: UUID(), update: update){
            error in
            print(error?.localizedDescription)
        }
        
    }
    
    
    
    
    @IBAction func tapOnDialPad(_ sender: AnyObject) {
        phoneNumber.append(Character(String(sender.tag)))
        phoneNumberView.text = phoneNumber
    }
    
    @IBAction func calButtonAction(_ sender: Any) {
        print(phoneNumber)
        if phoneNumber != ""{
            let controller = CXCallController()
                let transaction = CXTransaction(action: CXStartCallAction(call: UUID(), handle: CXHandle(type: .phoneNumber, value: phoneNumber)))
                controller.request(transaction, completion: { error in
                    if let error = error {
                        print(error.localizedDescription)
                    }else {
                            
                        print("Call is made successfully")
                    }
                        
                })
        }
    }
    
    @IBAction func clearTextAction(_ sender: Any) {
        if phoneNumber != ""{
            phoneNumber.removeLast()
            phoneNumberView.text = phoneNumber
        }
    }
}



extension ViewController : CXProviderDelegate{
    func providerDidReset(_ provider: CXProvider) {
        print("Provider is reset here")
    }
    
    func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
        print("User performs answer call action")
        action.fulfill()
    }
    
    func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
        print("Call ends here")
        action.fulfill()
    }
}



extension UIButton{
    func createRoundButton(){
        layer.cornerRadius = bounds.size.height/2
        layer.masksToBounds = true
        clipsToBounds = true
        backgroundColor = .lightGray
        tintColor = .black
    
    }
}




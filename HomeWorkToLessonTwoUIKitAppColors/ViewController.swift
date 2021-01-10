//
//  ViewController.swift
//  HomeWorkToLessonTwoUIKitAppColors
//
//  Created by vladimir gennadievich on 07.01.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var mainImageColorMixOtlet: UIView!
    
    @IBOutlet var redValueOutlet: UILabel!
    @IBOutlet var greenValueOutlet: UILabel!
    @IBOutlet var blueValueOutlet: UILabel!
    
    @IBOutlet var redSliderOutlet: UISlider!
    @IBOutlet var greenSliderOutlet: UISlider!
    @IBOutlet var blueSliderOutlet: UISlider!
    
    @IBOutlet var redValueTextField: UITextField!
    @IBOutlet var greenValueTextOutlet: UITextField!
    @IBOutlet var blueValueTextOutlet: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adjustViewInAppForEnter()
//        configureTabRecognizer()
        
        self.redValueTextField.delegate = self
        self.greenValueTextOutlet.delegate = self
        self.blueValueTextOutlet.delegate = self
        
    }
    


    private func adjustViewInAppForEnter() {
        
        mainImageColorMixOtlet.layer.cornerRadius = 15
        
        // slider adjust
        // red
        redSliderOutlet.value = 0.76
        redSliderOutlet.minimumValue = 0.0
        redSliderOutlet.maximumValue = 1
        redSliderOutlet.minimumTrackTintColor = .red
        redSliderOutlet.maximumTrackTintColor = .gray
        
        //green
        greenSliderOutlet.value = 0.26
        greenSliderOutlet.minimumValue = 0.0
        greenSliderOutlet.maximumValue = 1
        greenSliderOutlet.minimumTrackTintColor = .green
        greenSliderOutlet.maximumTrackTintColor = .gray
        
        //blue
        blueSliderOutlet.value = 0.49
        blueSliderOutlet.minimumValue = 0.0
        blueSliderOutlet.maximumValue = 1
        blueSliderOutlet.minimumTrackTintColor = .blue
        blueSliderOutlet.maximumTrackTintColor = .gray
        
        addDoneButtonOnUpKeyboard(textField: redValueTextField)
        addDoneButtonOnUpKeyboard(textField: blueValueTextOutlet)
        addDoneButtonOnUpKeyboard(textField: greenValueTextOutlet)
        
        sendValueFromSlidersTooOutlets()
        updateColor()
    }
    
    private func twoDigitAfterPoint(digit:Float) -> Float {
        let digitForBack = (digit*100).rounded()/100
        return digitForBack
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super .touchesBegan(touches, with: event)
        super.view.endEditing(true)
    }


    
    private func fromTextFieldTooFloat(text:UITextField) -> Float? {
        
        if let float = Float(text.text!){
            return float
        } else {
            return nil
        }
        
    }
    
    private func updateColor() {
        mainImageColorMixOtlet.backgroundColor = UIColor(red: CGFloat(redSliderOutlet.value),
                                                         green: CGFloat(greenSliderOutlet.value),
                                                         blue: CGFloat(blueSliderOutlet.value),
                                                         alpha: mainImageColorMixOtlet.alpha)
    }

    private  func sendValueFromSlidersTooOutlets() {
        
        redValueOutlet.text   =   "\(twoDigitAfterPoint(digit: redSliderOutlet.value))"
        greenValueOutlet.text = "\(twoDigitAfterPoint(digit: greenSliderOutlet.value))"
        blueValueOutlet.text  =  "\(twoDigitAfterPoint(digit: blueSliderOutlet.value))"
        
        redValueTextField.text    = redValueOutlet.text
        greenValueTextOutlet.text = greenValueOutlet.text
        blueValueTextOutlet.text  = blueValueOutlet.text

    }
    
    @IBAction func changedColorByValue(_ sender: UISlider) {
        
        switch sender {
        case redSliderOutlet:
            redValueOutlet.text = "\(twoDigitAfterPoint(digit: sender.value))"
            redValueTextField.text = "\(twoDigitAfterPoint(digit: sender.value))"
        case greenSliderOutlet:
            greenValueOutlet.text = "\(twoDigitAfterPoint(digit: sender.value))"
            greenValueTextOutlet.text = "\(twoDigitAfterPoint(digit: sender.value))"
        case blueSliderOutlet:
            blueValueOutlet.text = "\(twoDigitAfterPoint(digit: sender.value))"
            blueValueTextOutlet.text = "\(twoDigitAfterPoint(digit: sender.value))"
        default:
            break
        }
        updateColor()
    }
}

// added alert
extension ViewController {
    func sendAlert(alertTitle:String,alertMessage:String) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Ok", style: .cancel)
 
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
}

extension ViewController:UITextFieldDelegate {
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        guard let checkedText = fromTextFieldTooFloat(text: textField),checkedText <= 1
        else {  sendAlert(alertTitle: "Wrong",
                          alertMessage: "Change Value");
                          textField.text = "";
                          return false }
        
        switch textField {
        case redValueTextField:
            redSliderOutlet.value = checkedText
        case greenValueTextOutlet:
            greenSliderOutlet.value = checkedText
        case blueValueTextOutlet:
            blueSliderOutlet.value = checkedText
        default:
            break
        }
        
        sendValueFromSlidersTooOutlets()
        updateColor()
        return true
    }
     
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
extension ViewController {
    private func addDoneButtonOnUpKeyboard(textField:UITextField) {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: 30))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: nil,
                                        action: nil)
        
        let doneBtn  = UIBarButtonItem(title: "Done",
                                       style: .done,
                                       target: self, action:#selector(hendleTap))
        
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        textField.inputAccessoryView = toolbar
        toolbar.sizeToFit()
        

    }
    @objc func hendleTap() {
        view.endEditing(true)
    }

}

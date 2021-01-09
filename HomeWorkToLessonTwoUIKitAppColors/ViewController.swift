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
        configureTabRecognizer()
        
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
        
        sendColorOnMainColorLaibl(red: redSliderOutlet.value,green: greenSliderOutlet.value,blue: blueSliderOutlet.value)
        
    }
    
    private func twoDigitAfterPoint(digit:Float) -> Float {
        let digitForBack = (digit*100).rounded()/100
        return digitForBack
    }
    
    private func configureTabRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hendleTap))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func hendleTap() {
        view.endEditing(true)
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
    
    private func forAll(textFromTextField:UITextField,slider:UISlider,label:UILabel) {
        
        guard let checkedText = fromTextFieldTooFloat(text: textFromTextField),checkedText <= 1
        else {  sendAlert(alertTitle: "Wrong", alertMessage: "Change Value");
                textFromTextField.text = "\(slider.value)" ; return }
        
        
        slider.value = twoDigitAfterPoint(digit: checkedText)
        label.text = "\(twoDigitAfterPoint(digit: checkedText))"
        textFromTextField.text = "\(twoDigitAfterPoint(digit: checkedText))"
        
        updateColor()
        
    }
 
    private  func sendColorOnMainColorLaibl(red:Float,green:Float,blue:Float) {
        updateColor()
        
        redValueOutlet.text   =   "\(twoDigitAfterPoint(digit: red))"
        greenValueOutlet.text = "\(twoDigitAfterPoint(digit: green))"
        blueValueOutlet.text  =  "\(twoDigitAfterPoint(digit: blue))"
        
        redValueTextField.text    = "\(twoDigitAfterPoint(digit: red))"
        greenValueTextOutlet.text = "\(twoDigitAfterPoint(digit: green))"
        blueValueTextOutlet.text  = "\(twoDigitAfterPoint(digit: blue))"

    }
    
    @IBAction func changedColorByValue(_ sender: UISlider) {
        
        switch sender {
        case redSliderOutlet:
            sendColorOnMainColorLaibl(red: sender.value,
                                      green: greenSliderOutlet.value,
                                      blue: blueSliderOutlet.value)
        case greenSliderOutlet:
            sendColorOnMainColorLaibl(red: redSliderOutlet.value,
                                      green: sender.value,
                                      blue:blueSliderOutlet.value)
        case blueSliderOutlet:
            sendColorOnMainColorLaibl(red: redSliderOutlet.value,
                                      green: greenSliderOutlet.value,
                                      blue:sender.value)
        default:
            break
        }
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
        switch textField {
        case redValueTextField:
            forAll(textFromTextField: textField, slider: redSliderOutlet, label: redValueOutlet)
        case greenValueTextOutlet:
            forAll(textFromTextField: textField, slider: greenSliderOutlet, label: greenValueOutlet)
        case blueValueTextOutlet:
            forAll(textFromTextField: textField, slider: blueSliderOutlet, label: blueValueOutlet)
        default:
            break
        }
        return true
    }
     
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

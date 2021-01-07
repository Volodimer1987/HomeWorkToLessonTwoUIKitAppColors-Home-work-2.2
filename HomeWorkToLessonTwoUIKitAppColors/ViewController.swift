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
        
    }
    
    private func adjustViewInAppForEnter() {
        
        mainImageColorMixOtlet.layer.cornerRadius = 10
        
        // slider adjust
        // red
        redSliderOutlet.value = 0.0
        redSliderOutlet.minimumValue = 0.0
        redSliderOutlet.maximumValue = 1
        
        //green
        greenSliderOutlet.value = 0.0
        greenSliderOutlet.minimumValue = 0.0
        greenSliderOutlet.maximumValue = 1
        
        //blue
        blueSliderOutlet.value = 0.0
        blueSliderOutlet.minimumValue = 0.0
        blueSliderOutlet.maximumValue = 1
        
        //colorValueOutletsAdjust
        
        redValueOutlet.text = "\(redSliderOutlet.value)"
        greenValueOutlet.text = "\(greenSliderOutlet.value)"
        blueValueOutlet.text = "\(blueSliderOutlet.value)"
        
        //adjust text in insert outlets text
        
        redValueTextField.text = "\(redSliderOutlet.value)"
        greenValueTextOutlet.text = "\(greenSliderOutlet.value)"
        blueValueTextOutlet.text = "\(blueSliderOutlet.value)"
        
        mainImageColorMixOtlet.backgroundColor = sendColorOnMainColorLaibl(red: redSliderOutlet.value,
                                                                           green: greenSliderOutlet.value,
                                                                           blue: blueSliderOutlet.value)
        
    }
    
    private func sendColorOnMainColorLaibl(red:Float,green:Float,blue:Float) ->UIColor {
        let color = UIColor(red: CGFloat(red),
                            green: CGFloat(green),
                            blue: CGFloat(blue),
                            alpha: mainImageColorMixOtlet.alpha)
        return color
    }
    
    @IBAction func changedColorByValue(_ sender: UISlider) {
        
        
        
    }
    

}


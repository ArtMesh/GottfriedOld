//
//  ViewController.swift
//  Gottfried
//
//  Created by ArtMesh on 3/24/18.
//  Copyright © 2018 ArtMesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showAlert() {
        
    let alert = UIAlertController(title: "Warning", message: "Division by 0 !", preferredStyle: UIAlertControllerStyle.alert)
        
    alert.addAction(UIAlertAction(title:"OK", style:.default, handler: nil))
        
    self.present(alert, animated:true,completion: nil)
        
    }
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var inputLabel: UILabel!

    var numInput: Double = 0
    var numResult: Double = 0
    var typeOperation: Int = 0
    
    var inputIsEmpty = true
    var resultIsEmpty = true
    var equalWasPush = false
    
    var input: Double? {
        get{
            
            return Double(inputLabel.text!)!
            
        }
        set{
            inputLabel.text = "\(String(describing: newValue))"
            //inputIsEmpty = true
        }
    }
 
    
    
    @IBAction func addNumber(_ number: UIButton) {
        
        let symbol = number.currentTitle!
        
        if equalWasPush{
            
            numInput = 0
            numResult = 0
            typeOperation = 0
            
            inputIsEmpty = true
            equalWasPush = false
            
            resultLabel.text = (String) (0)
            inputLabel.text = symbol
            
        } else {
            
            if inputIsEmpty{
                
                inputLabel.text = symbol
                inputIsEmpty = false
                
            } else {
                
                inputLabel.text = inputLabel.text! + symbol
            }
        }
    }

    private func fillLabel(_ operation: String?){

        let resultText = String (describing: numResult)
        
        
        resultLabel.text! =  (resultText + " ") + (operation! + " ")
        inputLabel.text = String (0)
        inputIsEmpty = true
        
    }
 
    
    @IBAction func addOperation(_ operation: UIButton) {
        
        if equalWasPush{
            
            numResult = 0
            equalWasPush = false
        }
        
        if (typeOperation != 0){
            calculate()
            input! = numInput
        }
        
        switch operation.currentTitle! {
            

            case "+":
                typeOperation = 1
                
                if (numResult == 0){
                    
                    numResult = input!
                    
                } else{

                numResult += input!
                    
                }
                fillLabel(operation.currentTitle)
            
            case "-":
                typeOperation = 2
                if (numResult == 0){
                    
                    numResult = input!
                    
                } else{
                    
                    numResult -= input!
                    
                }
                
                fillLabel(operation.currentTitle)
 
            case "*":
                typeOperation = 3
                if (numResult == 0){
                    
                    numResult = input!
                    
                } else{
                    
                    numResult *= input!
                    
                }
                
                fillLabel(operation.currentTitle)

            case "/":
                typeOperation = 4
                if (input == 0) {
                    
                    //inputLabel.text = ""
                    showAlert()
                    inputIsEmpty = true
                    
                } else {
                    if (numResult == 0){
                        
                        numResult = input!
                    } else {
                        
                        numResult /= input!
                    }
                
                    fillLabel(operation.currentTitle)
                }
            case "=":
                
                pushEquals()

            default:
                break
        
        }
    }
    
    @IBAction func pushCancel(_ sender: Any) {
        numResult = 0
        resultLabel.text = String (0)
        inputLabel.text = String (0)
        inputIsEmpty = true
        resultIsEmpty = true
        equalWasPush = false
    }
    
   private func pushEquals(){
        
        equalWasPush = true
        
        switch typeOperation {
            case 1:
                numResult += input!
                resultLabel.text = String (resultLabel.text! +  (inputLabel.text! + " = ") )
            case 2:
                numResult -= input!
                resultLabel.text = String (resultLabel.text! + (inputLabel.text! + " = ") )
            case 3:
                numResult *= input!
                resultLabel.text = String (resultLabel.text! + (inputLabel.text! + " = ") )
            case 4:
                if (input == 0) {
                    showAlert()
                    inputIsEmpty = true
                }
                numResult /= input!
                resultLabel.text = String (resultLabel.text! +  (inputLabel.text! + " = ") )
            default:
                break
        }
    
        inputLabel.text = String (numResult)
    }
    
    private func calculate(){
        numInput = input!
        switch typeOperation {
            case 1:
                numResult += input!
                fillLabel("+")
            case 2:
                numResult -= input!
                fillLabel("-")
            case 3:
                numResult *= input!
                fillLabel("*")
            case 4:
                if (input == 0) {
                    showAlert()
                    inputIsEmpty = true
                }
                numResult /= input!
                fillLabel("/")
            default:
                break
        }

    }
    
}


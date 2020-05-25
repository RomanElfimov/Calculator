//
//  ViewController.swift
//  Calculator
//
//  Created by Рома on 01.02.2020.
//  Copyright © 2020 Рома. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - Properties
    private var stillTyping = false
    //поставлена ли точка в числе
    private var dotIsPlaced = false
    
    private var firstOperand: Double = 0
    private var secondOperand: Double = 0
    
    private var operationSign: String = ""
    
    private var currentInput: Double {
        get {
            return Double(displayResultLabel.text!)!
        }
        set {
            let value = "\(newValue)"
            //число до точки - первый элемент массива, после точки - второй
            let valueArray = value.components(separatedBy: ".")
            //если 0, пишем только первый элемент
            if valueArray[1] == "0" {
                displayResultLabel.text = "\(valueArray[0])"
            } else {
                displayResultLabel.text = "\(newValue)"
            }

            stillTyping = false
        }
    }
    
    //MARK: - Outlet
    @IBOutlet weak var displayResultLabel: UILabel!
        
    
    //MARK: - Actions
    @IBAction func numberPressed(_ sender: UIButton) {
        //номер кнопки по заголовку
        let number = sender.currentTitle!
        
        //убираем ноль в начале
        if stillTyping {
            //ограничиваем количество символов
            if displayResultLabel.text!.count < 20 {
                displayResultLabel.text = displayResultLabel.text! + number
            }
        } else {
            displayResultLabel.text = number
            stillTyping = true
        }
    }
    
    @IBAction func twoOperandSignPressed(_ sender: UIButton) {
        //отлавливаем знак операции
        operationSign = sender.currentTitle!
        
        firstOperand = currentInput
        stillTyping = false
        
        dotIsPlaced = false
    }
    
    @IBAction func equalitySignPressed(_ sender: UIButton) {
        if stillTyping {
            secondOperand = currentInput
        }
        
        dotIsPlaced = false
        
        switch operationSign {
        case "+":
            operateWithTwoOperands{$0 + $1}
        case "-":
            operateWithTwoOperands{$0 - $1}
        case "×":
            operateWithTwoOperands{$0 * $1}
        case "÷":
            operateWithTwoOperands{$0 / $1}
        default:
            break
        }
    }
    
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        firstOperand = 0
        secondOperand = 0
        currentInput = 0
        displayResultLabel.text = "0"
        stillTyping = false
        dotIsPlaced = false
        operationSign = ""
    }
    
    @IBAction func plusMinusButtonPressed(_ sender: UIButton) {
        currentInput = -currentInput
    }
    
    @IBAction func percentageButtonPressed(_ sender: UIButton) {
        if firstOperand == 0 {
            currentInput = currentInput / 100
        } else {
            currentInput = firstOperand * currentInput / 100
        }
        stillTyping = false
    }
    
    @IBAction func squareRootButtonPressed(_ sender: UIButton) {
        currentInput = sqrt(currentInput)
    }
    
    @IBAction func dotButtonPressed(_ sender: UIButton) {
        //если пришем, и точка не стоит
        if stillTyping && !dotIsPlaced {
            displayResultLabel.text = displayResultLabel.text! + "."
            dotIsPlaced = true
        } else if !stillTyping && !dotIsPlaced {
            displayResultLabel.text = "0."
        }
    }
    
    
    //MARK: - Method
    private func operateWithTwoOperands(operation: (Double, Double) -> Double) {
        currentInput = operation(firstOperand, secondOperand)
        stillTyping = false
    }
    
    
}


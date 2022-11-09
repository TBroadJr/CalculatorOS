//
//  CalculatorViewModel.swift
//  CalculatorOS
//
//  Created by Tornelius Broadwater, Jr on 10/27/22.
//

import SwiftUI

class CalculatorViewModel: ObservableObject {
    
    @Published var display = "0"
    private var firstValue: Double?
    private var secondValue: Double?
    private var operation: CalculatorButton?
    
    let buttonsArray: [[CalculatorButton]] = [
        [.ac, .plusMinus, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equals]
    ]
    
    func receiveInput(calculatorButton: CalculatorButton) {
        switch calculatorButton {
        case .decimal, .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
            if firstValue == nil {
                appendDisplayFirstValue(calculatorButton: calculatorButton)
            } else {
                appendDisplaySecondValue(calculatorButton: calculatorButton)
            }
        case .equals:
            getAnswer(calculatorButton: calculatorButton)
        case .plus, .minus, .divide, .multiply:
            operatorSelected(calculatorButton: calculatorButton)
        case .ac:
            clear()
        case .plusMinus:
            plusMinusToggle()
        case .percent:
            guard let value = Double(display) else { return }
            display = "\(value / 100)"
        }
    }
    
    func hasValue() -> Bool {
        if firstValue != nil || secondValue != nil || operation != nil || display != "0" {
            return true
        } else {
            return false
        }
    }
    
    private func plusMinusToggle() {
        if display.hasPrefix("-") {
            display.remove(at: display.startIndex)
        } else {
            display.insert("-", at: display.startIndex)
        }
    }
    
    private func operatorSelected(calculatorButton: CalculatorButton) {
        if firstValue == nil {
            firstValue = Double(display)
            operation = calculatorButton
        }
    }
    
    private func appendDisplayFirstValue(calculatorButton: CalculatorButton) {
        guard calculatorButton != .decimal else {
            if display.contains(".") {
                return
            } else {
                display.append(".")
                return
            }
        }
        if display == "0" {
            guard calculatorButton != .zero else { return }
            display.removeFirst()
            display.append(calculatorButton.titleString)
        } else {
            display.append(calculatorButton.titleString)
        }
    }
    
    private func appendDisplaySecondValue(calculatorButton: CalculatorButton) {
        guard let displayDouble = Double(display), let firstValue1 = firstValue else { return }
        if displayDouble == firstValue1 {
            display.removeAll()
        }
        display.append(calculatorButton.titleString)
    }
    
    private func getAnswer(calculatorButton: CalculatorButton) {
        secondValue = Double(display)
        guard let firstValue = firstValue, let secondValue = secondValue, let operation = operation else { return }
        switch operation {
        case .plus:
            display = displayAnswer(val1: firstValue, val2: secondValue, operation: operation)
        case.minus:
            display = displayAnswer(val1: firstValue, val2: secondValue, operation: operation)
        case.divide:
            display = displayAnswer(val1: firstValue, val2: secondValue, operation: operation)
        case.multiply:
            display = displayAnswer(val1: firstValue, val2: secondValue, operation: operation)
        default:
            break
        }
    }
    
    private func displayAnswer(val1: Double, val2: Double, operation: CalculatorButton) -> String {
        switch operation {
        case .plus:
            let answer = val1 + val2
            let a = answer.formatted(.number)
            return "\(a)"
        case .minus:
            let answer = val1 - val2
            let a = answer.formatted(.number)
            return "\(a)"
        case .divide:
            let answer = val1 / val2
            let a = answer.formatted(.number)
            return "\(a)"
        case .multiply:
            let answer = val1 * val2
            let a = answer.formatted(.number)
            return "\(a)"
        default:
            return ""
        }
    }
    
    private func clear() {
        display = "0"
        firstValue = nil
        secondValue = nil
    }
}

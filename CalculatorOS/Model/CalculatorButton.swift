//
//  CalculatorButton.swift
//  CalculatorOS
//
//  Created by Tornelius Broadwater, Jr on 10/30/22.
//

import SwiftUI

enum CalculatorButton: String {
    
    case zero, one, two, three, four, five, six, seven, eight, nine
    case equals, plus, minus, divide, multiply
    case ac, plusMinus, percent
    case decimal
    
    var titleString: String {
        switch self {
        case .zero: return "0"
        case .decimal: return "."
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .ac: return "AC"
        case .plusMinus: return "±"
        case .percent: return "%"
        case .equals: return "="
        case .plus: return "+"
        case .minus: return "-"
        case .divide: return "÷"
        case .multiply: return "X"
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .decimal, .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
            return Color("DarkGray")
        case .equals, .plus, .minus, .divide, .multiply:
            return Color("Orange")
        case .ac, .plusMinus, .percent:
            return Color("LightGray")
        }
    }
    
    var clearButton: Bool {
        switch self {
        case .ac: return true
        default: return false
        }
    }
}

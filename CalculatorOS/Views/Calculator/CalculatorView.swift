//
//  CalculatorView.swift
//  CalculatorOS
//
//  Created by Tornelius Broadwater, Jr on 10/27/22.
//

import SwiftUI

struct CalculatorView: View {
    
    // MARK: - Properties
    @StateObject private var viewModel = CalculatorViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            background
            buttons
        }
    }
}

// MARK: - CalculatorView Extension
private extension CalculatorView {
    
    // MARK: - Background
    var background: some View {
        Color.black.ignoresSafeArea()
    }
    
    // MARK: - Displayed Text
    var displayText: some View {
        HStack {
            Text(viewModel.display)
                .foregroundColor(.white)
                .font(.system(size: 64))
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.trailing, 30)
        
    }
    
    // MARK: - Buttons
    var buttons: some View {
        VStack(spacing: 12) {
            displayText
            ForEach(viewModel.buttonsArray, id: \.self) { row in
                HStack(spacing: 12) {
                    ForEach(row, id: \.self) { button in
                        Button {
                            viewModel.receiveInput(calculatorButton: button)
                        } label: {
                            if button.clearButton {
                                Text(viewModel.hasValue() ? "AC" : "C")
                                    .font(.system(size: 32))
                                    .frame(width: getButtonFrame(button: button), height: getButtonFrame())
                                    .foregroundColor(.white)
                                    .background(button.backgroundColor)
                                    .cornerRadius(getButtonFrame())
                            } else {
                                Text(button.titleString)
                                    .font(.system(size: 32))
                                    .frame(width: getButtonFrame(button: button), height: getButtonFrame())
                                    .foregroundColor(.white)
                                    .background(button.backgroundColor)
                                    .cornerRadius(getButtonFrame())
                            }
                        }
                    }
                }
            }
        }
        .padding(.bottom)
    }
}

// MARK: - CalculatorView Functions Extension
private extension CalculatorView {
    
    // MARK: - Get Button frame
    func getButtonFrame(button: CalculatorButton = .one) -> CGFloat {
        if button == .zero {
            return (((UIScreen.main.bounds.width - 5 * 12) / 4) * 2) + 12
        } else {
            return (UIScreen.main.bounds.width - 5 * 12) / 4
        }
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}

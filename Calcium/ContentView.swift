//
//  ContentView.swift
//  Calculator
//
//  Created by Afraz Siddiqui on 3/5/21.
//

import SwiftUI

enum CalcButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case divide = "÷"
    case multiply = "x"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"

    /**
        Button colour definitions
     */
    var buttonColor: Color {
        switch self {
        case .add, .subtract, .multiply, .divide, .equal:
            return .blue
        case .clear, .negative, .percent:
            return Color(.gray)
        default:
            return Color(UIColor(red: 35/255.0, green: 35/255.0, blue: 35/255.0, alpha: 1))
        }
    }
}

enum Operation {
    case add, subtract, multiply, divide, decimal, negative, percentage, none
}

struct ContentView: View {

    @State var value = "0"
    @State var method = "Calcium"
    @State var runningNumber = 0
    @State var currentOperation: Operation = .none

    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal],
    ]

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all) // define the colour for the background

            VStack {
                Spacer()

                // Text display
                VStack(alignment: .leading) {
                    HStack {
                        // Working out
                        Spacer()
                        Text(method)
                            .bold()
                            .font(.system(size: 60))
                            .foregroundColor(.gray) // foreground text colour (e.g. ans)
                            .padding()
                        
                    }
                    Spacer()
                    HStack {
                        // Answer
                        Spacer()
                        Text(value)
                            .bold()
                            .font(.system(size: 60))
                            .foregroundColor(.white) // foreground text colour (e.g. ans)
                            .padding()
                    }
                    
                
                }
                
                // Our buttons
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                self.didTap(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size: 32))
                                    .frame(
                                        width: self.buttonWidth(item: item),
                                        height: self.buttonHeight()
                                    )
                                    .background(item.buttonColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(self.buttonWidth(item: item)/2)
                            })
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }

    /**
     Tapping functions
     */
    func didTap(button: CalcButton) {
        // Just defining some things outside of the scope
        var decimalValue = 0.0
        
        /**
         TODO: Need to fix up the runningValue and other functions (e.g. decimals, negative, percentage)
         */
        
        switch button {
        
        // OPERATIONS
        case .add, .subtract, .multiply, .divide, .equal:
            checkIfDefault()
            if button == .add {
                self.currentOperation = .add
                self.runningNumber = Int(Double(self.value) ?? 0.0)
                self.method = method+"+"+value

            }
            
            else if button == .subtract {
                self.currentOperation = .subtract
                self.runningNumber = Int(Double(self.value) ?? 0.0)
                self.method = method+"-"+value


            }
            
            else if button == .multiply {
                self.currentOperation = .multiply
                self.runningNumber = Int(Double(self.value) ?? 0.0)
                self.method = method+"x"+value


            }
            
            else if button == .divide {
                self.currentOperation = .divide
                self.runningNumber = Int(Double(self.value) ?? 0.0)
                self.method = method+"/"+value


            }
            
            else if button == .equal {
                let runningValue = self.runningNumber
                let currentValue = Int(Double(self.value) ?? 0.0)

                
                switch self.currentOperation {
                    case .add:
                        self.value = "\(runningValue + currentValue)"

                    case .subtract:
                        self.value = "\(runningValue - currentValue)"

                    case .multiply:
                        self.value = "\(runningValue * currentValue)"

                    case .divide:
                        self.value = "\(runningValue / currentValue)"
                    case .decimal:
                        self.value = "\(runningValue + currentValue)"
                    case .negative:
                        break
                    case .percentage:
                        break
                    case .none:
                        break
                }
                
                self.method = method+"="+value

            }

            if button != .equal {
                self.value = "0"
            }
            
        // CLEAR
        case .clear:
            self.value = "0"
            self.method = "Cleared"
            
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
            }
            else {
                self.value = "\(self.value)\(number)"
            }
        }
    }

    func buttonWidth(item: CalcButton) -> CGFloat {
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4*12)) / 4) * 2
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }

    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    
    func checkIfDefault() {
        if method == "Calcium" {
            method = ""
        }
        if method == "Cleared" {
            method = ""
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

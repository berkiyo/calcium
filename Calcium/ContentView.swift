//
//  ContentView.swift
//  Calcium
//
//  Created by Berk Dogan on 18/7/21.
//

import SwiftUI

/**
 Defining the calculator buttons
 */
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
    case multiply = "x"
    case divide = "/"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"
}

struct ContentView: View {
    
    /**
     Defining the buttons and positioning
     */
    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent],
        [.seven, .eight, .nine],
        [.four, .five, .six],
        [.one, .two, .three],
    ]
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack {
                /**
                The result - text display
                 */
                HStack {
                    Spacer()
                    Text("0").bold().font(.system(size: 64)).foregroundColor(.white)
                }
                .padding()
                
                
                /**
                 The buttons on the calculator
                 */
                ForEach(buttons, id: \.self) { row in
                    // Put them in a horizontal stack
                    HStack {
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size: 32))
                                    .frame(width: 70, height: 70)
                                    .background(Color.orange)
                                    .foregroundColor(.white)
                                    .cornerRadius(35)
                            })
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

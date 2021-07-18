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
enum CalcButton {
    case one
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case zero
    case add
    case subtract
    case multiply
    case divide
    case equal
    case decimal
    case percent
    case negative
}

struct ContentView: View {
    
    let buttons: [[CalcButton]] = []
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack {
                // Display text
                HStack {
                    Spacer()
                    Text("0").bold().font(.system(size: 64)).foregroundColor(.white)
                }
                .padding()
                // Calculator buttons
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

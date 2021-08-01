/**
 ContentView - Created by Berk Dogan
 */

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
    case add, subtract, multiply, divide, decimal, negative, percent, none
}


struct ContentView: View {

    @State var value = "0"
    @State var method = "Calcium"
	@State var runningNumber = 0.0
    @State var currentOperation: Operation = .none
    
    // Share button
    @State private var isSharingSheetShowing = false

    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal],
    ]

    var body: some View {
        
        // Let's do the navigation bar
        NavigationView {
            
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
                                .font(.system(size: 30))
                                .foregroundColor(.gray) // foreground text colour (e.g. ans)
                                .padding()
                            
                        }
                        Spacer()
                        HStack {
                            // Answer
                            Spacer()
                            Text(value)
                                .bold()
                                .font(.system(size: 54))
                                .foregroundColor(.white) // foreground text colour (e.g. ans)
                                .padding()
                        }
                        // More navigation bar stuff
                        .navigationTitle("Calcium")
                        .toolbar {
                            ToolbarItemGroup(placement: .navigationBarTrailing){
                                Button {
                                    print("Share tapped")
                                    shareButton()
                                } label: {
                                    Label("Share", systemImage: "square.and.arrow.up")
                                }
                                
                                Button {
                                    print("Settings tapped")
									settingsButton()
                                } label: {
                                    Label("Settings", systemImage: "gear")
                                }
                                
                            }
                            
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
        // Navigation View
        .accentColor(.white)
        
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
		case .add, .subtract, .multiply, .divide, .percent, .negative, .equal:
            checkIfDefault()
            if button == .add {
                self.currentOperation = .add
                self.runningNumber = Double(self.value) ?? 0.0
                self.method = method+"+"+value

            }
            
            else if button == .subtract {
                self.currentOperation = .subtract
                self.runningNumber = Double(self.value) ?? 0.0
                self.method = method+"-"+value


            }
            
            else if button == .multiply {
                self.currentOperation = .multiply
                self.runningNumber = Double(self.value) ?? 0.0
                self.method = method+"x"+value


            }
            
            else if button == .divide {
                self.currentOperation = .divide
                self.runningNumber = Double(self.value) ?? 0.0
                self.method = method+"/"+value


            }
			else if button == .percent {
				self.currentOperation = .percent
				self.runningNumber = Double(self.value) ?? 0.0
				self.method = method+"%"+value


			}
            
            else if button == .equal {
                let runningValue = self.runningNumber
                let currentValue = Double(self.value) ?? 0.0

                
                switch self.currentOperation {
                    
					case .add:
                        // will come back to this one --> self.method = method+"+"+value
                        self.value = "\(runningValue + currentValue)"
                    
					case .subtract:
                        self.value = "\(runningValue - currentValue)"

                    case .multiply:
                        self.value = "\(runningValue * currentValue)"

                    case .divide:
                        self.value = "\(runningValue / currentValue)"
                    
					case .decimal:
						// calculate and see if there are more than one decimal places
						self.value = "\(runningValue + currentValue)"
					
					case .percent:
						self.value = "\(runningValue * 0.01 + currentValue)"
					
					case .negative:
						self.value = "\(runningValue * (-1))"
						break
					case .none:
                        break
                }
                
                

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
    
	/**
	The share button, currently just copies the answer and allows you to share it
	*/
    func shareButton() {
        isSharingSheetShowing.toggle()
		let finalValue = value // obtain the value from the calculator, we just want to use it to share things
		let activityView = UIActivityViewController(activityItems: [finalValue], applicationActivities: nil)
        
        UIApplication.shared.windows.first?.rootViewController?.present(activityView, animated: true, completion: nil)
    }
	
	/**
	Options button
	*/
	func settingsButton() {
		
	}
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  BetterRest
//
//  Created by taco on 7/24/20.
//  Copyright © 2020 Wrecks. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUpTime = Date()
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
  
    var body: some View {
        NavigationView {
            VStack {
                Text("When would you like to wake up?")
                    .font(.headline)
                
                DatePicker("Please enter a time", selection: $wakeUpTime, displayedComponents: .hourAndMinute)
                .labelsHidden()
                
                Text("Desired amount of sleep:")
                    .font(.headline)
                
                Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                    //%g drops unneccessary zeros
                    Text("\(sleepAmount, specifier: "%g") hours")
                }
                
                Text("Daily Coffee intake:")
                    .font(.headline)
                
                Stepper(value: $coffeeAmount, in: 1...20) {
                    if coffeeAmount == 1 {
                        Text("1 cup")
                    } else {
                        Text("\(coffeeAmount) cups")
                    }
                }
            }
        .navigationBarTitle("BetterRest")
            navigationBarItems(trailing:
                Button(action: calculateBedtime) {
                    Text("Calculate")
            })
        }
    }
    
    func calculateBedtime() {
        let model = SleepCalculator()
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

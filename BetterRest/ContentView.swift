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
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
  
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
            .navigationBarItems(trailing:
                Button(action: calculateBedtime) {
                    Text("Calculate")
            })
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func calculateBedtime() {
        let model = SleepCalculator()
        
        //this provides all the details of the current date
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUpTime)
        
        /*Datecomponents returns values formatted as seconds,
        multiply those seconds by 60 to get minutes,
        multiply those minutes by 60 to get hour*/
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let prediction = try
            model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUpTime - prediction.actualSleep
            
            //this converts the sleepTime Date var into a readable string
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            alertMessage = formatter.string(from: sleepTime)
            alertTitle = "Your ideal bedtime is..."
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        
        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

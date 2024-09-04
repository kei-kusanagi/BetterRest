//
//  ContentView.swift
//  BetterRest
//
//  Created by Juan Carlos Robledo Morales on 02/09/24.
//
import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingalert = false
    
    static var defaultWakeTime: Date{
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    var body: some View {
        NavigationStack{
            Form{
                VStack(alignment: .leading, spacing: 0) {
                    Text("When do you want to wake up?")
                        .font(.headline)
                    
                    HStack {
                        DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                        Text("⏰")
                    }
                }
                VStack(alignment: .leading, spacing: 0) {
                    Text("Desired amount of sleep")
                        .font(.headline)
                    
                    
                    Stepper("\(sleepAmount.formatted()) hours 🛌", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                VStack(alignment: .leading, spacing: 0) {
                    Text("Daily coffee intake")
                        .font(.headline)
                    
                    
//                    Stepper(coffeeAmount == 1 ? "\(coffeeAmount) cup ☕️" : coffeeAmount == 2 ? "\(coffeeAmount) cups ☕️☕️" : "\(coffeeAmount) cups ☕️☕️☕️", value: $coffeeAmount, in: 1...20)
                    Stepper("^[\(coffeeAmount) cup](inflect: true) ☕️", value: $coffeeAmount, in: 1...20)
                }
            }.navigationTitle("BetterRest")
                .toolbar {
                    Button("Calculate", action: calculateBedtime)
                }
                .alert(alertTitle, isPresented: $showingalert){
                    Button("ok") {}
                } message: {
                    Text(alertMessage)
                }
        }
    }
    func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let components = Calendar.current.dateComponents([.hour,.minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleeptime = wakeUp - prediction.actualSleep
            
            alertTitle = "Your ideal vedtime is..."
            alertMessage = sleeptime.formatted(date: . omitted, time: .shortened)
            
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating yout bedtime."
        }
        
        showingalert = true
    }
}

#Preview {
    ContentView()
}

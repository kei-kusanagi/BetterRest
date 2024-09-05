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
    
    @State private var bedtime = ""
    
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
                Section(header: Text("When do you want to wake up?").font(.headline)){
                    HStack{
                        DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                        Text("⏰")
                    }.frame(maxWidth: .infinity)
                }
                Section(header: Text("Desired amount of sleep").font(.headline)){
                    Stepper("\(sleepAmount.formatted()) hours 🛌", value: $sleepAmount, in: 4...12, step: 0.25).padding(.horizontal)
                }
                Section(header: Text("Daily coffee intake").font(.headline)) {
                    HStack {
                        Text("☕️")
                            .font(.largeTitle)
                            .frame(maxWidth: .infinity ,alignment: .trailing)
                        Picker("Number of cups", selection: $coffeeAmount) {
                            ForEach(1..<21) { number in
                                Text("\(number) \(number == 1 ? "cup" : "cups")")
                            }
                        }
                        .frame(alignment: .leading)
                        .pickerStyle(WheelPickerStyle())
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                    }
                }

                Section(header: Text("Your ideal bedtime is...").font(.headline)) {
                                Text(bedtime)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(.indigo)
                                    
                                    .padding()
                }.frame(maxWidth: .infinity, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            .navigationTitle("BetterRest")
            .onChange(of: wakeUp) {
                calculateBedtime()
            }
            .onChange(of: sleepAmount) {
                calculateBedtime()
            }
            .onChange(of: coffeeAmount) {
                calculateBedtime()
            }
        }
    }
    func calculateBedtime() {
            do {
                let config = MLModelConfiguration()
                let model = try SleepCalculator(configuration: config)
                let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
                let hour = (components.hour ?? 0) * 60 * 60
                let minute = (components.minute ?? 0) * 60

                let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
                
                let sleepTime = wakeUp - prediction.actualSleep
                bedtime = sleepTime.formatted(date: .omitted, time: .shortened)
                
            } catch {
                bedtime = "Error calculating bedtime."
            }
        }
    }
#Preview {
    ContentView()
}

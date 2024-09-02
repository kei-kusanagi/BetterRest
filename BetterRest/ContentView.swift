//
//  ContentView.swift
//  BetterRest
//
//  Created by Juan Carlos Robledo Morales on 02/09/24.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date.now
    
    var body: some View {
        VStack {
            Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 2...12, step: 0.25)
            DatePicker("Please enter a date", selection: $wakeUp).labelsHidden()
        }.padding()
    }
}

#Preview {
    ContentView()
}

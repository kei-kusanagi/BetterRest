//
//  ContentView.swift
//  BetterRest
//
//  Created by Juan Carlos Robledo Morales on 02/09/24.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    
    var body: some View {
        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 2...12, step: 0.25)
    }
}

#Preview {
    ContentView()
}

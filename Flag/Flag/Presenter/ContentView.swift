//
//  ContentView.swift
//  Flag
//
//  Created by Deokhun KIM on 6/3/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            Button {
                print("a")
            } label: {
                Image(.appleLogin)
            }

        }
        .padding()
    }
}

#Preview {
    ContentView()
}

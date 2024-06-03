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
                print("aa")
            } label: {
                Image(.startEmail)
            }
            
            HStack {
                Button {
                    
                } label: {
                    Image(.cancelMedium)
                }
                
                Button {
                    
                } label: {
                    Image(.okMedium)
                }
            }

        }
        .padding()
    }
}

#Preview {
    ContentView()
}

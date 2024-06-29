//
//  CounterView.swift
//  Flag
//
//  Created by Deokhun KIM on 6/29/24.
//

import ComposableArchitecture
import SwiftUI

struct CounterView: View {
    
    let store: StoreOf<CounterFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                Text("\(viewStore.count)")
                    .font(.largeTitle)
                    .padding()
                    .background(Color.black.opacity(0.1))
                    .presentationCornerRadius(10)
                
                HStack {
                    Button("−") {
                        viewStore.send(.decrementButtonTapped)
                    }
                    .padding()
                    Button("Reset") {
                        viewStore.send(.resetButtonTapped)
                    }
                    .padding()
                    Button("+") {
                        viewStore.send(.incrementButtonTapped)
                    }
                    .padding()
                    
                }
                .font(.largeTitle)
                .background(Color.black.opacity(0.1))
                .presentationCornerRadius(10)
                
                Button(viewStore.isTimerRunning ? "stop timer" : "start timer") {
                    viewStore.send(.toggleTimerButtonTapped)
                }
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .presentationCornerRadius(10)
                
                Button("Fact") {
                    viewStore.send(.factButtonTapped)
                }
                .font(.largeTitle)
                .padding()
                
                if viewStore.isLoading {
                    ProgressView()
                } else if let fact = viewStore.fact {
                    Text(fact)
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                        .padding()
                }
            }
        }
    }
}

#Preview {
    CounterView(
        store: Store(initialState: CounterFeature.State()) {
//            CounterFeature() //로직 상관없이 View 먼저 그리기 가능
        }
    )
}

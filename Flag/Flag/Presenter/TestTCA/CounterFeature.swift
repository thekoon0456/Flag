//
//  CounterFeature.swift
//  Flag
//
//  Created by Deokhun KIM on 6/29/24.
//

import ComposableArchitecture

@Reducer
struct CounterFeature {
    struct State {
        var count = 0
    }
    
    enum Action {
        case decrementButtonTapped
        case incrementButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .decrementButtonTapped:
                state.count -= 1
                return .none //sideEffect
            case .incrementButtonTapped:
                state.count += 1
                return .none
            }
        }
    }

}






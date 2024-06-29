//
//  CounterFeature.swift
//  Flag
//
//  Created by Deokhun KIM on 6/29/24.
//

import ComposableArchitecture
import Foundation

@Reducer
struct CounterFeature {
    struct State: Equatable {
        var count = 0
        var fact: String?
        var isLoading = false
    }
    
    enum Action {
        case decrementButtonTapped
        case incrementButtonTapped
        case resetButtonTapped
        case factButtonTapped
        case factResponse(fact: String)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .decrementButtonTapped:
                state.count -= 1
                state.fact = nil
                return .none //sideEffect
            case .incrementButtonTapped:
                state.count += 1
                state.fact = nil
                return .none
            case .resetButtonTapped:
                state.count = 0
                state.fact = nil
                return .none
            case .factButtonTapped:
                state.fact = nil
                state.isLoading = true
                
                //reducer 내부에서 비동기 함수 직접적으로 수행 불가, run 사용
                //                let (data, _) = try await URLSession.shared.data(from: URL(string: "http://numbersapi.com/\(state.count)")!)
                //                state.fact = String(decoding: data, as: UTF8.self)
                //                state.isLoading = false
                //                return .none
                return .run { [count = state.count] send in
                    let (data, _) = try await URLSession.shared.data(from: URL(string: "http://numbersapi.com/\(count)")!)
                    let fact = String(decoding: data, as: UTF8.self)
                    await send(.factResponse(fact: fact)) //send: mainActor
                }
                
            case .factResponse(let fact):
                state.isLoading = false
                state.fact = fact
                return .none
            }
        }
    }
    
    //state: sideEffect없음, 같은 결과값 도출
    //sideEffect: 결과값 달라질 수 있음
    //reducer 내부에서 비동기 함수 직접적으로 수행 불가
    
}

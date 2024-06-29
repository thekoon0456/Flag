//
//  CounterFeatureTests.swift
//  Flag
//
//  Created by Deokhun KIM on 6/30/24.
//

import ComposableArchitecture
import XCTest
@testable import Flag

@MainActor
final class CounterFeatureTests: XCTestCase {
    func testCounter() async {
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        }
        
//        store.exhaustivity = .off
        
        await store.send(.incrementButtonTapped) {
            $0.count = 1
//            XCTAssertEqual($0.count, 1) //store.exhaustivity = .off 시 사용 가능
        }
        
        await store.send(.decrementButtonTapped) {
            $0.count = 0
        }
        
        await store.send(.incrementButtonTapped) {
            $0.count = 1
        }
        
        await store.send(.resetButtonTapped) {
            $0.count = 0
        }
    }
    
    func testTimer() async {
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        }
        
        await store.send(.toggleTimerButtonTapped) {
            $0.isTimerRunning = true
        }
        
        await store.receive(\.timerTick) { //effect 수신
            $0.count = 1
        }
        
        await store.receive(\.timerTick) {
            $0.count = 2
        }
        
        await store.send(.toggleTimerButtonTapped) {
            $0.isTimerRunning = false
        }
    }
    
    func testNumberFact() async {
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        } withDependencies: {
            $0.numberFact.fetch = { "\($0) is a good number." }
        }
        
        await store.send(.factButtonTapped) {
            $0.isLoading = true
        }
        
        await store.receive(\.factResponse, timeout: .seconds(1)) {
            $0.isLoading = false
            $0.fact = "0 is a good number."
        }
    }
}

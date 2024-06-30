//
//  AppFeatureTests.swift
//  FlagTests
//
//  Created by Deokhun KIM on 6/30/24.
//

import ComposableArchitecture
import XCTest
@testable import Flag

@MainActor
class AppFeatureTests: XCTestCase {
    func testIncrementInFirstTab() async {
        let store = TestStore(initialState: AppFeature.State()) {
            AppFeature()
        }
        
        await store.send(.tab1(.incrementButtonTapped)) { state in
            state.tab1.count = 1
        }
    }
    
}

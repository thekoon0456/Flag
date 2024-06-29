//
//  FlagApp.swift
//  Flag
//
//  Created by Deokhun KIM on 6/3/24.
//

import ComposableArchitecture
import SwiftUI

@main
struct FlagApp: App {
    
    static let store = Store(initialState: CounterFeature.State()) {
        CounterFeature()
            ._printChanges() //상태변화 프린트
    }
    
    var body: some Scene {
        WindowGroup {
            CounterView(
                store: FlagApp.store
            )
        }
    }
}

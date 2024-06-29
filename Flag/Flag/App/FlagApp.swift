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
    var body: some Scene {
        WindowGroup {
            CounterView(store: Store(initialState: CounterFeature.State()) { CounterFeature()
            }
            )
        }
    }
}

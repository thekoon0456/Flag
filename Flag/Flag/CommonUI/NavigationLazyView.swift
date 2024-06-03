//
//  NavigationLazyView.swift
//  Flag
//
//  Created by Deokhun KIM on 6/3/24.
//

import SwiftUI

struct NavigationLazyView<T: View>: View {
    
    let build: () -> T
    
    init(_ build: @autoclosure @escaping () -> T) {
        self.build = build
    }
    
    var body: some View {
        build()
    }
}

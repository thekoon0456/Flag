//
//  BackgroundWrapper.swift
//  Flag
//
//  Created by Deokhun KIM on 6/3/24.
//

import SwiftUI

private struct BackgroundWrapper: ViewModifier {
    
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .background(color: color)
    }
}

extension View {
    
    func background(color: Color = .fgBackgroundPrimary) -> some View {
        modifier(BackgroundWrapper(color: color))
    }
}

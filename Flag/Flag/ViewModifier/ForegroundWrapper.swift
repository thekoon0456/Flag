//
//  ForegroundWrapper.swift
//  Flag
//
//  Created by Deokhun KIM on 6/3/24.
//

import SwiftUI

private struct ForegroundWrapper: ViewModifier {
    
    let color: Color
    
    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            content
                .foregroundStyle(color)
        } else {
            content
                .foregroundColor(color)
        }
    }
}

extension View {
    
    func foreground(color: Color) -> some View {
        modifier(ForegroundWrapper(color: color))
    }
}

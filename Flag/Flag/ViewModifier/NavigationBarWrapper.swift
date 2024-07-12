//
//  NavigationBarWrapper.swift
//  Flag
//
//  Created by Deokhun KIM on 6/3/24.
//

import SwiftUI

private struct NavigationBarWrapper<L: View, T: View>: ViewModifier {
    
    let leading: L
    let trailing: T
    
    init(
        @ViewBuilder leading: () -> L,
        @ViewBuilder trailing: () -> T
    ) {
        self.leading = leading()
        self.trailing = trailing()
    }
    
    func body(content: Content) -> some View {
        if #available(iOS 14.0, *) {
            //NavigationView 내부 최상단 뷰
            content
                .toolbar {
                    ToolbarItem(
                        placement: .topBarLeading,
                        content: { leading }
                    )
                    ToolbarItem(
                        placement: .topBarTrailing,
                        content: { trailing }
                    )
                }
        } else {
            content
                .navigationBarItems(
                    leading: leading,
                    trailing: trailing
                )
        }
    }
}

extension View {
    
    func navigationBar(
        leading: () -> some View,
        trailing: () -> some View
    ) -> some View {
        modifier(NavigationBarWrapper(
            leading: leading,
            trailing: trailing)
        )
    }
}

//
//  ContactDetailView.swift
//  Flag
//
//  Created by Deokhun KIM on 7/12/24.
//

import ComposableArchitecture
import SwiftUI

struct ContactDetailView: View {
    
    let store: StoreOf<ContactDetailFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Form {
                
            }
            .navigationTitle(Text(viewStore.contact.name))
        }
    }
}

#Preview {
    NavigationStack {
        ContactDetailView(
            store: Store(
                initialState: ContactDetailFeature.State(
                    contact: Contact(id: UUID(), name: "Blob")
                ), reducer: {
                    ContactDetailFeature()
                }
            )
        )
    }
}

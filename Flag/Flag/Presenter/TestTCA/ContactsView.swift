//
//  ContactsView.swift
//  Flag
//
//  Created by Deokhun KIM on 7/1/24.
//

import ComposableArchitecture
import SwiftUI

struct ContactsView: View {
    
    let store: StoreOf<ContactsFeature>
    
    var body: some View {
        NavigationStack {
            WithViewStore(self.store, observe: \.contacts) { viewStore in
                List {
                    ForEach(viewStore.state) { contact in
                        Text(contact.name)
                    }
                }
                .navigationTitle("Contacts")
                .toolbar {
                    ToolbarItem {
                        Button {
                            viewStore.send(.addButtonTapped)
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContactsView(
        store: Store(
            initialState: ContactsFeature.State(
                contacts: [
                    Contact(id: UUID(), name: "1"),
                    Contact(id: UUID(), name: "2"),
                    Contact(id: UUID(), name: "3")
                ]
            )
        ) {
            ContactsFeature()
        }
    )
}

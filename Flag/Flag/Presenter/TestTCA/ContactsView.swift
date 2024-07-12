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
        //NavigationStackStore로 변경
        NavigationStackStore(self.store.scope(state: \.path, action: \.path)) {
            WithViewStore(self.store, observe: \.contacts) { viewStore in
                List {
                    ForEach(viewStore.state) { contact in
                        NavigationLink(state: ContactDetailFeature.State(contact: contact)) {
                            HStack {
                                Text(contact.name)
                                Spacer()
                                Button {
                                    viewStore.send(.deleteButtonTapped(id: contact.id))
                                } label: {
                                    Image(systemName: "trash")
                                        .foreground(color: .red)
                                }
                            }
                        }
                        .buttonStyle(.borderless)
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
        } destination : { store in //feature의 forEach에서 store 생성해서 주입
            ContactDetailView(store: store)
        }
        .sheet(
            store: store.scope(
                state: \.$destination.addContact,
                action: \.destination.addContact
            )
        ) { addContactStore in
            NavigationStack {
                AddContactView(store: addContactStore)
            }
        }
        .alert(
            store: store.scope(
                state: \.$destination.alert,
                action: \.destination.alert)
        )
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

//
//  ContactsFeatureTests.swift
//  FlagTests
//
//  Created by Deokhun KIM on 7/2/24.
//

import ComposableArchitecture
import XCTest
@testable import Flag

@MainActor
final class ContactsFeatureTests: XCTestCase {
    func testDeleteContact() async {
        let store = TestStore(
            initialState: ContactsFeature.State(
                contacts: [
                    Contact(id: UUID(0), name: "Blob"),
                    Contact(id: UUID(1), name: "Blob Jr."),
                ]
            )
        ) {
            ContactsFeature()
        }
        
        await store.send(.deleteButtonTapped(id: UUID(1))) {
            $0.destination = .alert(
                AlertState {
                    TextState("Are you sure?")
                } actions: {
                    ButtonState(role: .destructive, action: .confirmDeletion(id: UUID(1))) {
                        TextState("Delete")
                    }
                }
            )
        }
        
        await store.send(.destination(.presented(.alert(.confirmDeletion(id: UUID(1)))))) {
            $0.contacts.remove(id: UUID(1))
            $0.destination = nil
        }
    }
}

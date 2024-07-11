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
    
    func testAddFlow() async {
        let store = TestStore(initialState: ContactsFeature.State()) {
            ContactsFeature()
        } withDependencies: {
            $0.uuid = .incrementing //uuid 제너레이터
        }
        
        await store.send(.addButtonTapped) {
            $0.destination = .addContact(
                AddContactFeature.State(
                    contact: Contact(id: UUID(0), name: "")
                )
            ) //UUID 종속성 호출
        }
        
        await store.send(.destination(.presented(.addContact(.setName("Blob Jr."))))) {
            //            $0.destination = .addContact(
            //                AddContactFeature.State(
            //                    contact: Contact(id: UUID(0), name: "name2")
            //                )
            //            )
            
            $0.$destination[case: \.addContact]?.contact.name = "Blob Jr."
        }
        
        await store.receive(
            .destination(
                .presented(.addContact(.delegate(.saveContact(Contact(id: UUID(0), name: "Blob Jr.")))))
            )
        ) {
            $0.contacts = [
                Contact(id: UUID(0), name: "Blob Jr.")
            ]
        }
        
        await store.receive(\.destination.dismiss) {
            $0.destination = nil
        }
    }
    
    func testAddFlow_NonExhaustive() async {
        let store = TestStore(initialState: ContactsFeature.State()) {
            ContactsFeature()
        } withDependencies: {
            $0.uuid = .incrementing
        }
        
        store.exhaustivity = .off
        
        await store.send(.addButtonTapped)
        await store.send(.destination(.presented(.addContact(.setName("Blob Jr.")))))
        await store.send(.destination(.presented(.addContact(.saveButtonTapped))))
        await store.skipReceivedActions()
        store.assert {
            $0.contacts = [
                Contact(id: UUID(0), name: "Blob Jr.")
            ]
            $0.destination = nil
        }

    }
}

//
//  ContactsFeature.swift
//  Flag
//
//  Created by Deokhun KIM on 7/1/24.
//

import Foundation
import ComposableArchitecture

struct Contact: Equatable, Identifiable {
    let id: UUID
    var name: String
}

@Reducer
struct ContactsFeature {
    struct State: Equatable {
        @PresentationState var addContact: AddContactFeature.State? //타 Reducer의 state와 연동 //nil이면 표시x
        var contacts: IdentifiedArrayOf<Contact> = []
    }
    
    enum Action {
        case addButtonTapped
        case addContact(PresentationAction<AddContactFeature.Action>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action { //항상 실행됨
            case .addButtonTapped:
                state.addContact = AddContactFeature.State(
                    contact: Contact(id: UUID(), name: "")
                )
                return .none
            //PresentationAction
            case .addContact(.presented(.cancelButtonTapped)):
                state.addContact = nil
                return .none
            case .addContact(.presented(.saveButtonTapped)):
                guard let contact = state.addContact?.contact
                else { return .none }
                state.contacts.append(contact)
                state.addContact = nil
                return .none
            case let .addContact(.presented(.setName(name))):
                return .none
            case .addContact(.dismiss): //dismiss Case까지
                return .none
            }
        }
        .ifLet(\.$addContact, action: \.addContact) { //PresentationState 있을때만 실행됨
            AddContactFeature()
        }
    }
}


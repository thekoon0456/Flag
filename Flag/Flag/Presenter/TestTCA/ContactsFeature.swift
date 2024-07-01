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
        @PresentationState var addContact: AddContactFeature.State? //nil이면 표시x
        @PresentationState var alert: AlertState<Action.Alert>?
        var contacts: IdentifiedArrayOf<Contact> = []
    }
    
    enum Action {
        case addButtonTapped
        case addContact(PresentationAction<AddContactFeature.Action>)
        case alert(PresentationAction<Alert>)
        case deleteButtonTapped(id: Contact.ID)
        
        enum Alert: Equatable {
            case confirmDeletion(id: Contact.ID)
        }
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
                //            case .addContact(.presented(.delegate(.cancel))):
                //                state.addContact = nil
                //                return .none
                
            case let .addContact(.presented(.delegate(.saveContact(contact)))):
                //                guard let contact = state.addContact?.contact
                //                else { return .none }
                state.contacts.append(contact)
                //                state.addContact = nil
                return .none
                
            case .addContact:
                return .none
                
                //            case let .addContact(.presented(.setName(name))):
                //                return .none
                //
                //            case .addContact(.dismiss): //dismiss Case까지
                //                return .none
             
                
            case let .alert(.presented(.confirmDeletion(id: id))): // .alert보다 먼저 실행!
                state.contacts.remove(id: id)
                return .none
                
            case .alert:
                return .none
                
            case let .deleteButtonTapped(id: id):
                state.alert = AlertState {
                    TextState("Are you sure?")
                } actions: {
                    ButtonState(role: .destructive, action: .confirmDeletion(id: id)) {
                        TextState("Delete")
                    }
                }
                return .none
            }
        }
        .ifLet(\.$addContact, action: \.addContact) { //PresentationState 있을때만 실행됨
            AddContactFeature()
        }
        .ifLet(\.$alert, action: \.alert)
    }
}


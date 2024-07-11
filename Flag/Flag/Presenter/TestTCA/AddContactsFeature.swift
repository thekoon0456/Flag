//
//  AddContactsFeature.swift
//  Flag
//
//  Created by Deokhun KIM on 7/1/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct AddContactFeature {
    struct State: Equatable {
        var contact: Contact
    }
    
    enum Action {
        case cancelButtonTapped
        case delegate(Delegate)
        case saveButtonTapped
        case setName(String)
        //data Upstream, delegate로 전달
        //reducer에서는 .none, 상위 기능에서 로직 처리
        enum Delegate: Equatable {
//            case cancel
            case saveContact(Contact)
        }
    }
    
    @Dependency(\.dismiss) var dismiss //Dependency는 비동기.
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .cancelButtonTapped:
//                return .send(.delegate(.cancel)) //sideEffect, delegate를 통해
                return .run { _ in 
                    await self.dismiss()
                }
            case .delegate:
                return .none
            case .saveButtonTapped:
//                return .send(.delegate(.saveContact(state.contact)))
                
                return .run { [contact = state.contact] send in
                    await send(.delegate(.saveContact(contact)))
                    await self.dismiss()
                }
            case let .setName(name):
                state.contact.name = name
                return .none
            }
        }
    }
}

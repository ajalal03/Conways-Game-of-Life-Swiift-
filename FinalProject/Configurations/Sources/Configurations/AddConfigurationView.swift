//
//  AddConfigurationView.swift
//  FinalProject
//

import SwiftUI
import ComposableArchitecture
import Combine
import Theming

struct AddConfigurationView: View {
    var store: Store<AddConfigState, AddConfigState.Action>
    @ObservedObject var viewStore: ViewStore<AddConfigState, AddConfigState.Action>
    @State private var keyboardHeight: CGFloat = 0

    init(store: Store<AddConfigState, AddConfigState.Action>) {
        self.store = store
        self.viewStore = ViewStore(store)
    }
    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .center) {
                VStack(alignment: .center) {
                    //Problem 5C Goes inside the following HStacks...
                    HStack (alignment: .center) {
        
                        Text("Title:")
                            .foregroundColor(Color.gray)
                            .padding(.trailing, 3.0)
                            .frame(width: proxy.size.width * 0.2, alignment: .trailing)
                        TextField("Title", text: viewStore.binding(get: \.title, send:{ s in AddConfigState.Action.updateTitle(s)}))
                        
                    }
                    HStack(alignment: .center) {
                        Text("Size:")
                            .foregroundColor(Color.gray)
                            .padding(.trailing, 8.0)
                            .frame(width: proxy.size.width * 0.2, alignment: .trailing)
                        CounterView(store: self.store.scope(state: \.counterState, action: AddConfigState.Action.counterStateAction(action:)))
                        Spacer()
                    }
                }
                .offset(x: proxy.size.width * 0.15, y: proxy.size.height * 0.005 )
                    .padding()
                    .overlay(Rectangle().stroke(Color.gray, lineWidth: 2.0))
                    .padding(.bottom, 30.0)

                HStack(alignment: .center) {
                    Spacer()
                    Spacer()
                    // Problem 5D - your answer goes in the following buttons
                    ThemedButton(text: "Save") {
                        viewStore.send(AddConfigState.Action.ok)
                    }
                    ThemedButton(text: "Cancel") {
                        viewStore.send(AddConfigState.Action.cancel)
                    }
                    Spacer()
                }
            }
            
            .font(.title)
            .frame(width: proxy.size.width * 0.75)
            .offset(x: proxy.size.width * 0.13, y: proxy.size.height * 0.05)
        }
    }
}

struct AddConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        AddConfigurationView(
            store: Store<AddConfigState, AddConfigState.Action>(
                initialState: AddConfigState(
                    title: "",
                    counterState: CounterState(count: 10)
                ),
                reducer: addConfigReducer,
                environment: AddConfigEnvironment()
            )
        )
    }
}

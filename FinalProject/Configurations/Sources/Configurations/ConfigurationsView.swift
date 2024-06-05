//
//  ConfigurationView.swift
//  SwiftUIGameOfLife
//
import SwiftUI
import ComposableArchitecture
import Configuration

public struct ConfigurationsView: View {
    let store: Store<ConfigurationsState, ConfigurationsState.Action>
    let viewStore: ViewStore<ConfigurationsState, ConfigurationsState.Action>

    public init(store: Store<ConfigurationsState, ConfigurationsState.Action>) {
        self.store = store
        self.viewStore = ViewStore(store, removeDuplicates: ==)
    }
    
    public var body: some View {
        // Your problem 3A code starts here.
        NavigationView{
            ZStack{
                Color("PastelConfig").edgesIgnoringSafeArea(.all)
                VStack {
                    Text("Configuration")
                        .foregroundColor(Color("accent"))
                        .font(.system(size: 32))
                    Spacer()
                    List {
                        ForEachStore(
                            self.store.scope(
                                state: \.configs,
                                action: ConfigurationsState.Action.configuration(id:action:)
                            ),
                            content: ConfigurationView.init(store:)
                        )
                        
                    }
                    
                    Divider()
                        .padding(8.0)
                    HStack {
                        Spacer()
                        Button(action: {
                            self.viewStore.send(.fetch, animation: .easeOut)
                        }) {
                            Text("Fetch").font(.system(size: 24.0))
                        }
                        .padding([.top, .bottom], 8.0)
                        
                        Spacer()
                        
                        Button(action: {
                            self.viewStore.send(.clear)
                        }) {
                            Text("Clear").font(.system(size: 24.0))
                        }
                        .padding([.top, .bottom], 8.0)
                        
                        Spacer()
                    }
                    .padding([.top, .bottom], 8.0)
                }.sheet(
                    isPresented: self.viewStore.binding(
                        get: \.isAdding,
                        send: {b in .stopAdding(b)}),
                    content: {
                        AddConfigurationView(
                            store: self.store.scope(
                                state: \.addConfigState,
                                action: ConfigurationsState.Action.addConfigAction(action:)))
                    }
                )
                
                
            }
            .navigationBarHidden(false)
            .navigationBarItems( trailing: Button("Add"){viewStore.send(.add)}.padding(.trailing))
        }
        .navigationViewStyle(StackNavigationViewStyle())
                
                // Problem 5a goes here
                // Problem 3B begins here
                // Problem 5b Goes here
                // Problem 3A ends here
        }
    }


public struct ConfigurationsView_Previews: PreviewProvider {
    static let previewState = ConfigurationsState()
    public static var previews: some View {
        ConfigurationsView(
            store: Store(
                initialState: previewState,
                reducer: configurationsReducer,
                environment: ConfigurationsEnvironment()
            )
        )
    }
}

//
//  SimulationView.swift
//  SwiftUIGameOfLife
//
import SwiftUI
import ComposableArchitecture
import Grid

public struct SimulationView: View {
    let store: Store<SimulationState, SimulationState.Action>
    
    public init(store: Store<SimulationState, SimulationState.Action>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationView {
            ZStack {
                Color("PastelSimulation").edgesIgnoringSafeArea(.all)
                WithViewStore(store) { viewStore in
                    VStack {
                        Text("Simulation")
                            .foregroundColor(Color("accent"))
                            .font(.system(size: 32))
                        HStack{
                            GeometryReader { g in
                                if g.size.width < g.size.height {
                                    self.verticalContent(for: viewStore, geometry: g)
                                } else {
                                    self.horizontalContent(for: viewStore, geometry: g)
                                }
                            }
                        }
                    }
                    .navigationViewStyle(StackNavigationViewStyle())
                    //                    .foregroundColor(Color("accent"))
                    .navigationBarHidden(false)
                    // Problem 6 - your answer goes here.
                    .onAppear {
                        viewStore.send(.startTimer)
                    }
                    .onDisappear {
                        viewStore.send(.stopTimer)
                    }
                }
            }
            }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func verticalContent(
        for viewStore: ViewStore<SimulationState, SimulationState.Action>,
        geometry g: GeometryProxy
    ) -> some View {
        VStack {
            
            InstrumentationView(
                store: self.store,
                width: g.size.width * 0.82
            )
            .frame(height: g.size.height * 0.35)
            .padding(.bottom, 16.0)
            
            Divider()
            HStack{
                GridView(
                    store: self.store.scope(
                        state: \.gridState,
                        action: SimulationState.Action.grid(action:)
                    )
                )
                .padding(1.0)
            }
        }
    }
    
    func horizontalContent(
        for viewStore: ViewStore<SimulationState, SimulationState.Action>,
        geometry g: GeometryProxy
    ) -> some View {
        HStack {
                frame(alignment: .center)
                Spacer()
                InstrumentationView(store: self.store)
                Spacer()
            Divider()
                GridView(
                    store: self.store.scope(
                        state: \.gridState,
                        action: SimulationState.Action.grid(action:)
                    )
                )
                .frame(width: g.size.height)
                Spacer()
            }
    }
}

public struct SimulationView_Previews: PreviewProvider {
    static let previewState = SimulationState()
    public static var previews: some View {
        SimulationView(
            store: Store(
                initialState: previewState,
                reducer: simulationReducer,
                environment: SimulationEnvironment()
            )
        )
    }
}

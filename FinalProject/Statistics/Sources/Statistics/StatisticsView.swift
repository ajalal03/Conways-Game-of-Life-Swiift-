//
//  StatisticsView.swift
//  SwiftUIGameOfLife
//
import SwiftUI
import ComposableArchitecture
import Theming
import UIKit

public struct StatisticsView: View {
    
    let store: Store<StatisticsState, StatisticsState.Action>
    let viewStore: ViewStore<StatisticsState, StatisticsState.Action>

    public init(store: Store<StatisticsState, StatisticsState.Action>) {
        self.store = store
        self.viewStore = ViewStore(store)
    }
    
    public var body: some View {
        NavigationView {
            ZStack{
                Color("Statistics").edgesIgnoringSafeArea(.all)
                VStack {
                    Text("Statistics")
                        .foregroundColor(Color("accent"))
                        .font(.system(size: 32))
                    Form {
                        FormLine(
                            title: "Alive",
                            value: viewStore.statistics.alive
                        )
                        FormLine(
                            title: "Steps",
                            value: viewStore.statistics.steps
                        )
                        FormLine(
                            title: "Born",
                            value: viewStore.statistics.born
                        )
                        FormLine(
                            title: "Died",
                            value: viewStore.statistics.died
                        )
                        FormLine(
                            title: "Empty",
                            value: viewStore.statistics.empty
                        )
                        
                        // Your Problem 7A code starts here
                        ThemedButton(text: "Reset") {
                            self.viewStore.send(.reset)
                        }
                        .frame(alignment: .center)
                    }
                    .padding()
                }
            }
        }
            .frame( height: .infinity)
            .navigationViewStyle(StackNavigationViewStyle())
    }
}

public struct StatisticsView_Previews: PreviewProvider {
    static let previewState = StatisticsState()
    public static var previews: some View {
        StatisticsView(
            store: Store(
                initialState: previewState,
                reducer: statisticsReducer,
                environment: StatisticsEnvironment()
            )
        )
    }
}

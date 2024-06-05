//
//  FormLine.swift
//
//

import SwiftUI

struct FormLine: View {
    var title: String
    var value: Int

    var body: some View {
        Section(
            header: Text("\(title)")
                .font(.title3)
                .bold()
                .foregroundColor(Color("accent"))
        ) {
            Text( "\(value)" )
            // Problem 7B code goes here.
                .font(Font.title.monospacedDigit())
                .foregroundColor(Color("accent"))
                .frame(width: .infinity, alignment: .trailing)
        }
    }
}

struct FormLine_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            FormLine(
                title: "A",
                value: 20000
            )
        }
    }
}

//
//  FilledButtonStyle.swift
//  pecunia
//
//  Created by Wellington on 27/10/23.
//

import SwiftUI


struct FilledButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color("orangeColor"))
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}

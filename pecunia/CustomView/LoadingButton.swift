//
//  LoadingButton.swift
//  pecunia
//
//  Created by Wellington on 27/10/23.
//

import SwiftUI

struct LoadingButton: View {
    @Binding var isLoading: Bool
    var action: () -> Void
    var label: () -> Text

    var body: some View {
        Button(action: {
            if !isLoading {
                action()
            }
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 20)
                    .foregroundColor(Color("orangeColor"))

                HStack {
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .foregroundColor(.white)
                    } else {
                        label()
                    }
                }
            }
        }
        .buttonStyle(FilledButtonStyle())
        .disabled(isLoading)
    }
}

//#Preview {
//    LoadingButton()
//}

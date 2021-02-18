//
//  PublicAccountButton.swift
//  ifengus1_4
//
//  Created by Alan Yang on 2/16/21.
//

import SwiftUI

struct PublicAccountButton: View {
    @Binding var isAccountViewPresented: Bool

    var body: some View {
        Button(action: {
            isAccountViewPresented = true
        }) {
            Image(systemName: "person.circle.fill")
                .foregroundColor(.secondary)
                .font(.title)
                .clipShape(Circle())
        }
        .sheet(isPresented: self.$isAccountViewPresented) {
            UserCenterView()
        }
    }
}


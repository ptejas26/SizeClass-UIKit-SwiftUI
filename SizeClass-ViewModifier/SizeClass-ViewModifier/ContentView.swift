//
//  ContentView.swift
//  SizeClass-ViewModifier
//
//  Created by Tejas Patelia on 2024-11-09.
//

import SwiftUI

struct ContentView: View {
    @State private var sizeClass = SizeClass(horizontal: .none, vertical: .none)

    var body: some View {
        if let horizontal = sizeClass.horizontal,
           let vertical = sizeClass.vertical {
            Text("Size classes: \n H-\(horizontal) V-\(vertical)")
                .observeSizeClasses(sizeClass: $sizeClass)
                .background(Color.red)
                .foregroundStyle(Color.white)
        } else {
            Text("Change orientation of the phone to see change in size class values")
                .font(.caption)
                .observeSizeClasses(sizeClass: $sizeClass)
        }
    }
}

#Preview {
    ContentView()
}

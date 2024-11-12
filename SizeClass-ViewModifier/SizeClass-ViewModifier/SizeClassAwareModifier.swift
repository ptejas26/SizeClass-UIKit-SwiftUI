//
//  SizeClassAwareModifier.swift
//  SizeClass-ViewModifier
//
//  Code Credit to Nilaakash Singh
// https://medium.com/loblaw-digital/observing-size-class-changes-in-swiftui-with-custom-modifiers-4504409f88ec

import SwiftUI

struct SizeClassAwareModifier: ViewModifier {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Binding var sizeClass: SizeClass

    func body(content: Content) -> some View {
        content
            .onChange(of: SizeClass(horizontal: horizontalSizeClass, vertical: verticalSizeClass), { oldValue, newValue in
                print("Old: \(oldValue)")
                print("New: \(newValue)")
                sizeClass = newValue
            })
    }
}
extension View {
    func observeSizeClasses(sizeClass: Binding<SizeClass>) -> some View {
        self.modifier(SizeClassAwareModifier(sizeClass: sizeClass))
    }
}

//
//  UIView+Preview.swift
//  iOSArchitecturesDemo
//
//  Created by v.prusakov on 9/17/21.
//  Copyright © 2021 ekireev. All rights reserved.
//

import Foundation
import SwiftUI

struct UIPreviewView<V: UIView>: UIViewRepresentable {
    
    let view: V
    
    init(_ view: V) {
        self.view = view
    }
    
    func makeUIView(context: Context) -> some UIView {
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) { }
}

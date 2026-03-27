//
//  Wrapper.swift
//
//  Created by Vijayan on 07/10/25.
//

import SwiftUI

struct ARViewControllerWrapper: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> ARViewController {
        return ARViewController()
    }

    func updateUIViewController(_ uiViewController: ARViewController, context: Context) {
    }
}

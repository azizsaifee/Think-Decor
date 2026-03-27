//
//  ContentView.swift
//  SampleSwiftUI
//
//  Created by Vijayan on 07/10/25.
//

import SwiftUI

// MARK: - Model

struct Interest: Identifiable, Hashable {
    let id = UUID()
    let title: String
}

// MARK: - Main Screen

struct ChooseInterestsView: View {

    @Environment(\.dismiss) private var dismiss

    private let brand = Color(hex: "#00594E")

    @State private var searchText = ""
    @State private var selected = Set<Interest>()
    @State private var showError = false

    private let allItems: [Interest] = [
        .init(title: "Dining Table"),
        .init(title: "Working Table"),
        .init(title: "Chairs"),
        .init(title: "Console Table"),
        .init(title: "Wardrobes"),
        .init(title: "Streamers"),
        .init(title: "Personal Development"),
        .init(title: "Sofa"),
        .init(title: "Side Table")
    ]

    private var filteredItems: [Interest] {

        if searchText.isEmpty {
            return allItems
        }

        return allItems.filter {
            $0.title.lowercased().contains(searchText.lowercased())
        }
    }

    var body: some View {

        VStack(spacing: 0) {

            topBar

            ScrollView {

                VStack(alignment: .leading, spacing: 18) {

                    header

                    searchBar

                    interestGrid

                    if showError {
                        Text("Please select at least one interest")
                            .foregroundColor(.red)
                            .font(.caption)
                            .padding(.top, 4)
                    }

                    Spacer(minLength: 120)
                }
                .padding(.horizontal, 22)
            }

            finishButton
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    // MARK: - Top bar

    private var topBar: some View {

        HStack {

            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
            }

            Spacer()
        }
        .padding()
    }

    // MARK: - Header

    private var header: some View {

        VStack(alignment: .leading, spacing: 6) {

            Text("Choose Interests")
                .font(.title2.bold())

            Text("Choose the items you are interested in to fulfill your dream home your dreams")
                .foregroundColor(.gray)
                .font(.subheadline)
        }
    }

    // MARK: - Search

    private var searchBar: some View {

        HStack(spacing: 12) {

            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)

            TextField("Search...", text: $searchText)

            Spacer()

            Image(systemName: "slider.horizontal.3")
                .foregroundColor(.black)
        }
        .padding(.horizontal, 16)
        .frame(height: 50)
        .background(Color.gray.opacity(0.08))
        .cornerRadius(25)
    }

    // MARK: - Grid

    private var interestGrid: some View {

        LazyVGrid(
            columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ],
            spacing: 14
        ) {

            ForEach(filteredItems) { item in

                chip(item)
            }
        }
        .padding(.top, 6)
    }

    // MARK: - Chip

    private func chip(_ item: Interest) -> some View {

        let isSelected = selected.contains(item)

        return Button {

            toggle(item)

        } label: {

            HStack(spacing: 8) {

                if isSelected {
                    Image(systemName: "checkmark")
                        .font(.system(size: 12, weight: .bold))
                } else {
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 6, height: 6)
                }

                Text(item.title)
                    .font(.subheadline)
            }
            .foregroundColor(isSelected ? brand : .primary)
            .frame(maxWidth: .infinity)
            .frame(height: 46)
            .overlay(
                RoundedRectangle(cornerRadius: 23)
                    .stroke(isSelected ? brand : Color.gray.opacity(0.3), lineWidth: 1.5)
            )
        }
    }

    // MARK: - Finish Button

    private var finishButton: some View {

        Button {

            validate()

        } label: {

            Text("Finish")
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(brand)
                .cornerRadius(28)
                .padding(.horizontal, 22)
                .padding(.bottom, 20)
        }
    }

    // MARK: - Validation

    private func toggle(_ item: Interest) {

        if selected.contains(item) {
            selected.remove(item)
        } else {
            selected.insert(item)
        }

        if !selected.isEmpty {
            showError = false
        }
    }

    private func validate() {

        if selected.isEmpty {
            showError = true
            return
        }

        // ✅ All validations passed
        // Use selected array for API call / next screen
        print("Selected interests:", selected.map { $0.title })
    }
}


// MARK: - Preview

#Preview {
    NavigationStack {
        ChooseInterestsView()
    }
}

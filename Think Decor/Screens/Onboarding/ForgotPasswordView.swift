//
//  ContentView.swift
//  SampleSwiftUI
//
//  Created by Vijayan on 07/10/25.
//

import SwiftUI

// MARK: - Forgot Password Screen

struct ForgotPasswordView: View {

    @Environment(\.dismiss) private var dismiss
    @State private var goToCreate = false

    @State private var email = ""

    private let brandColor = Color(hex: "#00594E")

    var body: some View {

        VStack {

            topBar

            VStack(alignment: .leading, spacing: 22) {

                headerView

                emailField

                nextButton

                Spacer()
            }
            .padding(.horizontal, 24)

            Spacer()
        }
        .background(Color.white)
        .toolbar(.hidden, for: .navigationBar)
    }
}

// MARK: - Top Bar

private extension ForgotPasswordView {

    var topBar: some View {

        HStack {

            Button {
                dismiss()
            } label: {

                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.black)
            }

            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
    }
}

// MARK: - Header

private extension ForgotPasswordView {

    var headerView: some View {

        VStack(alignment: .leading, spacing: 6) {

            Text("Forgot Password")
                .font(.title2.bold())
                .foregroundColor(.black)

            Text("Recover your account password")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding(.top, 28)
    }
}

// MARK: - Email Field

private extension ForgotPasswordView {

    var emailField: some View {

        VStack(alignment: .leading, spacing: 8) {

            Text("E-mail")
                .font(.subheadline)
                .foregroundColor(.gray)

            TextField("Enter your email", text: $email)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .padding(.horizontal, 18)
                .frame(height: 54)
                .background(Color.gray.opacity(0.08))
                .cornerRadius(27)
        }
    }
}

// MARK: - Next Button

private extension ForgotPasswordView {

    var nextButton: some View {

        Button {
            goToCreate = true

    
            // 👉 Call forgot password API here
            print("Email:", email)

        } label: {

            Text("Next")
                .foregroundColor(.white)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .frame(height: 54)
                .background(brandColor)
                .cornerRadius(27)
        }
        .padding(.top, 14)
        .navigationDestination(isPresented: $goToCreate) {
                    CreateNewPasswordView()
                }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        ForgotPasswordView()
    }
}
